---
layout: default
title: "Journal Entry #2"
parent: Deployment Journal
nav_order: [REVERSE_CHRONOLOGICAL_ORDER]
date: 2025-05-07
---

# Journal Entry #2 - Environment Verification
{: .no_toc }

**Date:** 2025-05-07
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

Verified connectivity between local development environment and Rancher West Kubernetes cluster. Confirmed Helm installation and functionality to prepare for Discourse deployment using the Bitnami Helm chart approach.

## Accomplishments

- Successfully configured and verified kubectl connection to Rancher West cluster
- Confirmed Helm installation and verified functionality on local machine
- Tested authentication and permissions with the Kubernetes cluster
- Validated access to necessary namespaces for Discourse deployment
- Documented connection process for team reference

## Challenges

### Challenge 1: Kubernetes Configuration

**Description:** Encountered issues with kubectl context management when connecting to the Rancher West cluster.  Was using [this chat guidance](https://claude.ai/share/516313d0-2df7-4291-9686-fa677873373c)

**Resolution:** Downloaded kubeconfig file from Rancher dashboard but discovered that merging with existing configuration wasn't working as expected. Verified connectivity by using the explicit `--kubeconfig` flag to specify the Rancher configuration file location instead of attempting to use the default merged context.

### Challenge 2: Helm Repository Access

**Description:** Required verification that Helm had access to necessary repositories for the Bitnami Discourse chart.

**Resolution:** Updated Helm repositories with `helm repo add bitnami https://charts.bitnami.com/bitnami` and `helm repo update` commands. Verified chart accessibility with `helm search repo bitnami/discourse`.

## Decisions

### Decision 1: Kubeconfig Management Approach

**Context:** Needed to determine how to manage multiple Kubernetes contexts including the new Rancher West cluster.

**Options Considered:**
- Merge the Rancher kubeconfig with existing kubectl config
- Maintain separate kubeconfig files and use the `--kubeconfig` flag
- Create a custom script to switch between contexts

**Decision:** Selected the approach of maintaining separate kubeconfig files and using the `--kubeconfig` flag when connecting to Rancher West.

**Rationale:** While merging configs is often recommended, it was causing context conflicts with existing K3s clusters. Using a dedicated kubeconfig file with explicit path reference ensures reliable connectivity without disrupting existing cluster configurations.

### Decision 2: Helm Version Selection

**Context:** Needed to verify which Helm version to use for deployment.

**Options Considered:**
- Helm v2 with Tiller
- Helm v3 standalone

**Decision:** Confirmed using Helm v3 for all deployments.

**Rationale:** Helm v3 eliminates the need for Tiller, improving security by removing the server-side component. It also provides better integration with Kubernetes RBAC and secrets management.

## Next Actions

1. Create dedicated namespace for Discourse deployment in Rancher West - High Priority
2. Customize Bitnami Helm values.yaml file for our environment - High Priority
3. Test Helm chart installation with dry-run to verify configuration - Medium Priority
4. Document specific Rancher West configuration requirements - Medium Priority
5. Set up monitoring and logging configurations for the deployment - Low Priority

## Commands To Use

```powershell
# Kubectl verification
kubectl --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml config get-contexts
kubectl --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml config use-context rancher-w
kubectl --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml get nodes
kubectl --kubeconfig C:\Users\myuser\.kube\rancher-cluster.yaml auth can-i create deployments --namespace discourse-prod

# Attempt to use merged context (unsuccessful)
kubectl config use-context rancher-w
kubectl config current-context

# Helm verification
helm version
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo bitnami/discourse
helm template bitnami/discourse --output-dir ./test-templates
```

## References & Resources

- [Rancher Kubernetes Access Control Documentation](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/authentication-permissions-and-global-configuration/manage-role-based-access-control-rbac)
- [Helm Installation Guide](https://helm.sh/docs/intro/install/)
- [Bitnami Discourse Helm Chart Documentation](https://artifacthub.io/packages/helm/bitnami/discourse)
- [Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

---

**Hours Logged:** 4

**Tags:** kubernetes, rancher, kubectl, helm, verification, authentication, configuration