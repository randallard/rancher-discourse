---
layout: default
title: "Journal Entry #3"
parent: Deployment Journal
nav_order: [REVERSE_CHRONOLOGICAL_ORDER]
date: 2025-05-11
---

# Journal Entry #3 - Discourse Deployment
{: .no_toc }

**Date:** 2025-05-11
{: .fs-5 }

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Current Status

Successfully deployed Discourse using the Bitnami Helm chart on Rancher West Kubernetes cluster with Longhorn storage. Resolved several configuration issues to achieve a stable deployment.

## Accomplishments

- Deployed Discourse using Bitnami Helm chart
- Configured persistent storage with Longhorn
- Set up ingress with proper TLS configuration
- Resolved certificate and memory issues
- Verified application functionality through web interface
- Updated configuration to optimize application startup

## Deployment Process

The deployment process involved installing Discourse using the Bitnami Helm chart:

```bash
helm install discourse bitnami/discourse --namespace discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml -f source\repos\rancher-discourse\values.yaml
```

We used a customized values.yaml file with specific configurations for our environment, including:
- Hostname configuration: discourse-dev.mycompany.com
- Resource settings tuned for our environment
- TLS configuration with proper certificates
- Longhorn persistent volume settings
- Specific probe timings for application readiness

## Challenges

### Challenge 1: Certificate Issues

**Description:** Initial deployment had issues with TLS certificate recognition and HTTPS connectivity.

**Resolution:** Updated ingress configuration with proper secretName referring to our existing certificate. Verified TLS connectivity using proper certificate chain.

### Challenge 2: Memory Reservation Issues

**Description:** The cluster was experiencing resource pressure due to high memory reservation requirements.

**Resolution:** Temporarily disabled Redpanda services that were consuming significant memory resources without being utilized. This freed up necessary resources for Discourse to run properly.

### Challenge 3: Initial Application Startup Time

**Description:** Discourse was taking longer than expected to initialize, causing readiness probes to fail.

**Resolution:** Modified the readinessProbe and livenessProbe configuration to have longer initialDelaySeconds values:

```yaml
discourse:
  readinessProbe:
    initialDelaySeconds: 600
    timeoutSeconds: 20
    periodSeconds: 30
  livenessProbe:
    initialDelaySeconds: 900
```

### Challenge 4: Asset Precompilation

**Description:** Asset precompilation during startup was consuming excessive resources and extending startup time.

**Resolution:** Disabled asset precompilation by adding custom environment variables:

```yaml
discourse:
  extraEnvVars:
    - name: DISCOURSE_PRECOMPILE_ASSETS
      value: "no"
```

## Verification Steps

We used the following commands to verify the deployment:

### 1. Check Pod Status

```bash
kubectl get pods -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml
```

This showed the Discourse pods including the main application, PostgreSQL, and Redis services.

### 2. View Pod Details

```bash
kubectl describe pod discourse-xxxxxxxx-xxxxx -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml
```

This allowed us to inspect configuration details and status information.

### 3. Check Container Logs

```bash
kubectl logs discourse-xxxxxxxx-xxxxx -c discourse -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml
```

Allowed us to confirm successful initialization and identify any issues in the application startup.

### 4. Verify Services

```bash
kubectl get services -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml
```

Confirmed that all necessary services were running and properly configured.

### 5. Check Ingress Configuration

```bash
kubectl get ingress -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml
```

Verified that the ingress was properly configured with our domain and TLS settings.

## Decisions

### Decision 1: Probe Timing Configuration

**Context:** Discourse initialization takes longer than default probe timings allowed.

**Options Considered:**
- Keep default probe values and troubleshoot application for faster startup
- Increase probe delay times
- Disable probes entirely

**Decision:** Increased the probe delay times to accommodate the application's actual startup requirements.

**Rationale:** This approach allows the application sufficient time to properly initialize while still maintaining the safety mechanisms that probes provide for container health checking.

### Decision 2: Asset Precompilation

**Context:** Asset precompilation during container startup was causing excessive resource usage and slowdowns.

**Options Considered:**
- Allow default precompilation
- Disable precompilation
- Build a custom image with precompiled assets

**Decision:** Disabled asset precompilation for development environment.

**Rationale:** For development purposes, the performance impact of not precompiling assets is minimal, while the resource savings and startup time improvements are significant.

## Next Actions

1. Set up regular backup schedule for Discourse data - High Priority
2. Configure email notifications system - High Priority
3. Implement monitoring and alerting for the Discourse deployment - Medium Priority
4. Document operational procedures for maintenance tasks - Medium Priority
5. Test and optimize performance settings - Low Priority
6. Plan for production deployment with appropriate scaling considerations - Low Priority

## Commands To Use

```bash
# Get deployment status
kubectl get deployments -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml

# Check persistent volumes
kubectl get pv,pvc -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml

# Check ingress details
kubectl describe ingress discourse -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml

# Get admin credentials
kubectl get secret discourse-discourse -n discourse-dev -o jsonpath="{.data.discourse-password}" --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml | base64 -d

# Restart pods if needed
kubectl rollout restart deployment discourse -n discourse-dev --kubeconfig C:\Users\myuser\.kube\rancher-e.yaml
```

## References & Resources

- [Bitnami Discourse Helm Chart Documentation](https://artifacthub.io/packages/helm/bitnami/discourse)
- [Discourse Official Documentation](https://meta.discourse.org/c/support/setup/13)
- [Kubernetes Probes Configuration Guide](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Longhorn Storage Documentation](https://longhorn.io/docs/)
- [Rancher Ingress Configuration Guide](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/kubernetes-resources-setup/ingress)

---

**Hours Logged:** 6

**Tags:** kubernetes, rancher, discourse, helm, deployment, troubleshooting, ingress, tls, longhorn