# Script to completely uninstall a Helm release and clean up all associated resources
# Parameters
$kubeconfig = "C:\Users\<username>\.kube\<config-file>.yaml"
$namespace = "<namespace>"
$releaseName = "<release-name>"

# Function to run kubectl commands
function Invoke-Kubectl {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Command
    )
    
    Write-Host "Executing: kubectl $Command" -ForegroundColor Cyan
    $result = Invoke-Expression "kubectl --kubeconfig $kubeconfig $Command"
    return $result
}

# Function to check if resource exists
function Test-ResourceExists {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ResourceType,
        
        [Parameter(Mandatory = $false)]
        [string]$Namespace = "",
        
        [Parameter(Mandatory = $false)]
        [string]$Selector = ""
    )
    
    $namespaceArg = ""
    if ($Namespace) {
        $namespaceArg = "-n $Namespace"
    }
    
    $selectorArg = ""
    if ($Selector) {
        $selectorArg = "-l $Selector"
    }
    
    $result = Invoke-Kubectl "get $ResourceType $namespaceArg $selectorArg -o name 2>&1"
    return $result -and $result.Count -gt 0
}

# Step 1: List all resources before cleanup for reference
Write-Host "Current state before cleanup:" -ForegroundColor Green
Write-Host "Pods:" -ForegroundColor Yellow
Invoke-Kubectl "get pods -n $namespace"
Write-Host "PVCs:" -ForegroundColor Yellow
Invoke-Kubectl "get pvc -n $namespace"
Write-Host "PVs related to the namespace:" -ForegroundColor Yellow
$pvs = Invoke-Kubectl "get pv -o json | ConvertFrom-Json"
$relatedPVs = $pvs.items | Where-Object { $_.spec.claimRef.namespace -eq $namespace }
$relatedPVs | ForEach-Object { Write-Host $_.metadata.name }

# Step 2: Uninstall the Helm release
Write-Host "`nUninstalling Helm release $releaseName..." -ForegroundColor Green
Invoke-Expression "helm --kubeconfig $kubeconfig uninstall $releaseName -n $namespace"

# Step 3: Delete all PVCs in the namespace
Write-Host "`nDeleting all PVCs in namespace $namespace..." -ForegroundColor Green
$pvcs = Invoke-Kubectl "get pvc -n $namespace -o name"
if ($pvcs) {
    $pvcs | ForEach-Object {
        $pvcName = $_.Replace("persistentvolumeclaim/", "")
        Write-Host "Deleting PVC: $pvcName" -ForegroundColor Yellow
        Invoke-Kubectl "delete pvc $pvcName -n $namespace"
    }
} else {
    Write-Host "No PVCs found in namespace $namespace" -ForegroundColor Yellow
}

# Step 4: Find and delete orphaned PVs related to the namespace
Write-Host "`nDeleting orphaned PVs related to namespace $namespace..." -ForegroundColor Green
$pvs = Invoke-Kubectl "get pv -o json | ConvertFrom-Json"
$relatedPVs = $pvs.items | Where-Object { $_.spec.claimRef.namespace -eq $namespace }

if ($relatedPVs) {
    $relatedPVs | ForEach-Object {
        $pvName = $_.metadata.name
        Write-Host "Deleting PV: $pvName" -ForegroundColor Yellow
        
        # Force delete by patching finalizers if necessary
        Write-Host "Patching finalizers for PV: $pvName" -ForegroundColor Yellow
        $patchJson = '{"metadata":{"finalizers":null}}'
        Invoke-Kubectl "patch pv $pvName -p '$patchJson' --type=merge"
        
        # Delete the PV
        Invoke-Kubectl "delete pv $pvName --force --grace-period=0"
    }
} else {
    Write-Host "No PVs found related to namespace $namespace" -ForegroundColor Yellow
}

# Step 5: Delete any remaining Longhorn volumes if they exist
Write-Host "`nChecking for Longhorn volumes..." -ForegroundColor Green
$longhornExists = Test-ResourceExists -ResourceType "customresourcedefinitions" -Selector "name=volumes.longhorn.io"

if ($longhornExists) {
    Write-Host "Checking for Longhorn volumes related to namespace $namespace..." -ForegroundColor Yellow
    $volumes = Invoke-Kubectl "get volumes.longhorn.io -n longhorn-system -o json | ConvertFrom-Json"
    $relatedVolumes = $volumes.items | Where-Object { 
        $_.metadata.name -match [regex]::Escape($namespace) -or 
        $_.spec.pvc -match [regex]::Escape($namespace)
    }
    
    if ($relatedVolumes) {
        $relatedVolumes | ForEach-Object {
            $volumeName = $_.metadata.name
            Write-Host "Deleting Longhorn volume: $volumeName" -ForegroundColor Yellow
            Invoke-Kubectl "delete volumes.longhorn.io $volumeName -n longhorn-system"
        }
    } else {
        Write-Host "No Longhorn volumes found related to namespace $namespace" -ForegroundColor Yellow
    }
} else {
    Write-Host "Longhorn CRD not found, skipping Longhorn volume cleanup" -ForegroundColor Yellow
}

# Step 6: Delete the namespace if desired (commented out by default for safety)
# Write-Host "`nDeleting namespace $namespace..." -ForegroundColor Red
# Invoke-Kubectl "delete namespace $namespace"

# Step 7: Verify cleanup
Write-Host "`nVerifying cleanup..." -ForegroundColor Green

# Check pods
$podsExist = Test-ResourceExists -ResourceType "pods" -Namespace $namespace
if ($podsExist) {
    Write-Host "Warning: Pods still exist in namespace $namespace" -ForegroundColor Red
    Invoke-Kubectl "get pods -n $namespace"
} else {
    Write-Host "No pods found in namespace $namespace" -ForegroundColor Green
}

# Check PVCs
$pvcsExist = Test-ResourceExists -ResourceType "pvc" -Namespace $namespace
if ($pvcsExist) {
    Write-Host "Warning: PVCs still exist in namespace $namespace" -ForegroundColor Red
    Invoke-Kubectl "get pvc -n $namespace"
} else {
    Write-Host "No PVCs found in namespace $namespace" -ForegroundColor Green
}

# Check related PVs
$pvs = Invoke-Kubectl "get pv -o json | ConvertFrom-Json"
$relatedPVs = $pvs.items | Where-Object { $_.spec.claimRef.namespace -eq $namespace }
if ($relatedPVs) {
    Write-Host "Warning: PVs related to namespace $namespace still exist" -ForegroundColor Red
    $relatedPVs | ForEach-Object { Write-Host $_.metadata.name }
} else {
    Write-Host "No PVs found related to namespace $namespace" -ForegroundColor Green
}

Write-Host "`nCleanup process completed" -ForegroundColor Green