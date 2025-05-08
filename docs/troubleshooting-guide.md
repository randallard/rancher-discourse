---
layout: page
title: Troubleshooting Guide
nav_order: 2
permalink: /docs/troubleshooting-guide/
---

# Discourse on Rancher: Troubleshooting Guide

This guide addresses common issues that may arise during your Discourse deployment on Rancher Kubernetes.

## Deployment Issues

### Pods Stuck in Pending State

**Symptoms:**
- Pods remain in "Pending" status
- Deployment doesn't proceed

**Possible Causes:**
1. Insufficient cluster resources
2. PVC issues
3. Node selector/affinity issues

**Troubleshooting Steps:**
```bash
# Check pod status with details
kubectl describe pod <pod-name> -n discourse-dev

# Check PVC status
kubectl get pvc -n discourse-dev

# Check node resources
kubectl describe nodes
```

**Resolution:**
- If resources are insufficient, adjust resource requests in values.yaml
- If PVC issues, verify storageClass exists and is configured correctly
- Ensure sufficient nodes are available matching any node selectors

### Container Creation Errors

**Symptoms:**
- Pods show status like "CreateContainerError" or "CrashLoopBackOff"
- Containers repeatedly restart

**Possible Causes:**
1. Invalid configuration
2. Secret/ConfigMap issues
3. Image pull issues

**Troubleshooting Steps:**
```bash
# Check pod logs
kubectl logs <pod-name> -n discourse-dev

# Check events
kubectl get events -n discourse-dev --sort-by='.lastTimestamp'

# Check container status
kubectl describe pod <pod-name> -n discourse-dev
```

**Resolution:**
- Fix configuration errors in values.yaml
- Ensure secrets and configmaps exist and are correctly formatted
- Verify container registry access if using custom images

## Ingress/Networking Issues

### Cannot Access Discourse UI

**Symptoms:**
- Web UI not accessible at configured domain
- Browser shows connection errors

**Possible Causes:**
1. Ingress misconfiguration
2. TLS certificate issues
3. DNS issues

**Troubleshooting Steps:**
```bash
# Check ingress status
kubectl get ingress -n discourse-dev
kubectl describe ingress <ingress-name> -n discourse-dev

# Verify TLS secret
kubectl get secret <tls-secret-name> -n discourse-dev

# Check services
kubectl get svc -n discourse-dev
```

**Resolution:**
- Ensure DNS points to correct Kubernetes ingress IP
- Verify TLS certificate exists and is valid
- Check ingress controller logs for routing errors

### TLS Certificate Issues

**Symptoms:**
- Browser shows certificate errors
- Certificate invalid or for wrong domain

**Possible Causes:**
1. Incorrect secret name in ingress config
2. Expired or invalid certificate
3. Cert-manager issues (if using)

**Troubleshooting Steps:**
```bash
# Check certificate secret
kubectl describe secret <tls-secret-name> -n discourse-dev

# If using cert-manager, check certificate resource
kubectl get certificate -n discourse-dev
kubectl describe certificate <cert-name> -n discourse-dev
```

**Resolution:**
- Update ingress configuration with correct secretName
- Renew expired certificates
- Fix cert-manager configuration if needed

## Database Issues

### PostgreSQL Connection Failures

**Symptoms:**
- Discourse shows database connection errors
- PostgreSQL logs show authentication failures

**Possible Causes:**
1. Incorrect database credentials
2. Database pod not ready
3. Network policy blocking connections

**Troubleshooting Steps:**
```bash
# Check PostgreSQL pod status
kubectl get pods -l app.kubernetes.io/name=postgresql -n discourse-dev

# Check PostgreSQL logs
kubectl logs <postgresql-pod-name> -n discourse-dev

# Check if credentials in secret match values.yaml
kubectl get secret <discourse-postgresql-secret> -n discourse-dev -o yaml
```

**Resolution:**
- Update credentials in values.yaml and redeploy
- Ensure PostgreSQL pod is running correctly
- Check and update network policies if necessary

### Database Migration Failures

**Symptoms:**
- Discourse initialization logs show migration errors
- Application doesn't start properly

**Possible Causes:**
1. Database version mismatch
2. Insufficient permissions
3. Schema conflicts

**Troubleshooting Steps:**
```bash
# Check Discourse container logs for migration errors
kubectl logs <discourse-pod-name> -n discourse-dev

# Check PostgreSQL logs
kubectl logs <postgresql-pod-name> -n discourse-dev
```

**Resolution:**
- Ensure compatible PostgreSQL version
- Verify database user has sufficient permissions
- For major version upgrades, follow Discourse migration documentation

## Application Issues

### Plugin Installation Failures

**Symptoms:**
- Plugins not appearing in admin UI
- Error messages during plugin installation

**Possible Causes:**
1. Plugin URL incorrect
2. Plugin compatibility issues
3. Network connectivity issues

**Troubleshooting Steps:**
```bash
# Check Discourse container logs
kubectl logs <discourse-pod-name> -n discourse-dev

# Verify plugin configuration in values.yaml
# Check plugin repository URLs
```

**Resolution:**
- Update plugin URLs in values.yaml
- Verify plugin compatibility with your Discourse version
- Ensure container has network access to plugin repositories

### Email Delivery Issues

**Symptoms:**
- Emails not being sent
- Error messages related to SMTP in logs

**Possible Causes:**
1. Incorrect SMTP configuration
2. Network connectivity to SMTP server
3. Authentication issues

**Troubleshooting Steps:**
```bash
# Check Discourse logs for email errors
kubectl logs <discourse-pod-name> -n discourse-dev

# Verify SMTP configuration in values.yaml
# Test SMTP server connectivity from within the pod
kubectl exec -it <discourse-pod-name> -n discourse-dev -- bash
nc -zv <smtp-host> <smtp-port>
```

**Resolution:**
- Update SMTP configuration in values.yaml
- Ensure network connectivity to SMTP server
- Verify SMTP credentials are correct

## Resource/Performance Issues

### High CPU/Memory Usage

**Symptoms:**
- Pods showing high resource utilization
- Performance degradation

**Possible Causes:**
1. Insufficient resource allocation
2. Traffic spikes
3. Database inefficiency

**Troubleshooting Steps:**
```bash
# Check resource usage
kubectl top pods -n discourse-dev

# Check detailed metrics if Prometheus is set up
# Review Grafana dashboards

# Check database performance
kubectl exec -it <postgresql-pod-name> -n discourse-dev -- psql -U <username> -d <database> -c "SELECT * FROM pg_stat_activity;"
```

**Resolution:**
- Increase resource limits in values.yaml
- Consider enabling autoscaling
- Optimize database queries and indexes

### Persistent Volume Issues

**Symptoms:**
- PVCs remain in Pending state
- Storage-related errors in logs

**Possible Causes:**
1. StorageClass issues
2. Insufficient storage capacity
3. Volume provisioner problems

**Troubleshooting Steps:**
```bash
# Check PVC status
kubectl get pvc -n discourse-dev
kubectl describe pvc <pvc-name> -n discourse-dev

# Check StorageClass
kubectl get storageclass
kubectl describe storageclass <storageclass-name>
```

**Resolution:**
- Verify StorageClass exists and is default if not specified
- Check storage provider capacity and quotas
- Ensure volume provisioner is working correctly

## Upgrade Issues

### Failed Helm Upgrades

**Symptoms:**
- Helm upgrade command fails
- Error messages during upgrade

**Possible Causes:**
1. Configuration changes incompatible with current state
2. Chart version incompatibilities
3. Resource conflicts

**Troubleshooting Steps:**
```bash
# Check Helm release status
helm --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml status discourse -n discourse-dev

# Get detailed description of the release
helm --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml get manifest discourse -n discourse-dev

# Check for any issues in the cluster
kubectl get events -n discourse-dev --sort-by='.lastTimestamp'
```

**Resolution:**
- Resolve configuration conflicts
- Consider a fresh installation if upgrade path is problematic
- Backup data before attempting major version upgrades

### Post-Upgrade Functionality Issues

**Symptoms:**
- Features stop working after upgrade
- New errors in application logs

**Possible Causes:**
1. Plugin compatibility with new version
2. Configuration changes needed for new version
3. Database schema changes

**Troubleshooting Steps:**
```bash
# Check application logs
kubectl logs <discourse-pod-name> -n discourse-dev

# Review Discourse upgrade notes for the version
# Check for required site setting changes
```

**Resolution:**
- Update plugins to compatible versions
- Apply any required configuration changes
- Run rake tasks if needed for database migrations

## Recovery Procedures

### Restoring from Backup

If you need to restore Discourse from a backup:

1. **Locate your backup file** (from S3 or local storage)

2. **Stop the Discourse application**:
```bash
kubectl scale deployment discourse --replicas=0 -n discourse-dev
```

3. **Restore the database**:
```bash
# Copy backup to PostgreSQL pod
kubectl cp backup.sql <postgresql-pod-name>:/tmp/ -n discourse-dev

# Restore database
kubectl exec -it <postgresql-pod-name> -n discourse-dev -- psql -U <username> -d <database> -f /tmp/backup.sql
```

4. **Restore uploads** (if separate from database backup):
```bash
# Copy uploads to Discourse pod
kubectl cp uploads.tar.gz <discourse-pod-name>:/tmp/ -n discourse-dev

# Extract uploads
kubectl exec -it <discourse-pod-name> -n discourse-dev -- bash -c "cd /bitnami/discourse && tar -xzvf /tmp/uploads.tar.gz"
```

5. **Restart Discourse**:
```bash
kubectl scale deployment discourse --replicas=1 -n discourse-dev
```

### Rolling Back a Deployment

If you need to roll back to a previous version:

1. **List Helm release revisions**:
```bash
helm --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml history discourse -n discourse-dev
```

2. **Roll back to a specific revision**:
```bash
helm --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml rollback discourse <revision-number> -n discourse-dev
```

3. **Verify rollback was successful**:
```bash
helm --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml status discourse -n discourse-dev
kubectl get pods -n discourse-dev
```

## Getting Help

If you encounter issues not covered in this guide:

1. Check the [Discourse Meta](https://meta.discourse.org/) forum for similar issues
2. Review the [Bitnami Discourse Helm Chart documentation](https://github.com/bitnami/charts/tree/master/bitnami/discourse)
3. Check the [Rancher documentation](https://rancher.com/docs/) for Kubernetes-specific issues
4. Consult the project team for assistance