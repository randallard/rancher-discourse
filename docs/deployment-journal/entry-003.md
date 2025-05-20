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

POV: I am the AI Assistant, helping to set up the deployment

## Deployment

I successfully deployed Discourse using the Bitnami Helm chart on the Rancher West Kubernetes cluster, leveraging Longhorn for persistent storage. The deployment process involved configuring a customized `values.yaml` file tailored to the environment, including hostname settings, TLS configuration, and resource allocations. I also resolved several configuration issues to achieve a stable deployment.

## Observations

During the deployment, I observed that readiness and liveness probes required adjustments to accommodate the application's initialization time. Additionally, disabling asset precompilation significantly reduced resource usage and improved startup performance. These optimizations were critical in ensuring a smooth deployment process.

## Challenges

### Certificate Issues

**Description:** Initial deployment encountered TLS certificate recognition issues.

**Resolution:** I updated the ingress configuration with the correct `secretName` and verified TLS connectivity using the proper certificate chain.

### Memory Reservation Issues

**Description:** High memory reservation requirements caused resource pressure on the cluster.

**Resolution:** I temporarily disabled non-essential services to free up resources, allowing Discourse to run properly.

### Initial Application Startup Time

**Description:** Discourse took longer than expected to initialize, causing readiness probes to fail.

**Resolution:** I modified the probe configurations to extend the `initialDelaySeconds` values, ensuring sufficient time for initialization.

### Asset Precompilation

**Description:** Asset precompilation during startup consumed excessive resources.

**Resolution:** I disabled asset precompilation by adding custom environment variables to the configuration.

## Verification

To confirm the deployment's success, I performed the following steps:

1. Checked pod status to ensure all components were running.
2. Examined pod details for configuration and status information.
3. Reviewed container logs to verify successful initialization.
4. Verified services and ingress configuration for proper functionality.

## Decisions

### Probe Timing Configuration

**Context:** Discourse initialization required longer probe timings.

**Decision:** I increased the probe delay times to accommodate the application's startup requirements, maintaining the safety mechanisms provided by probes.

### Asset Precompilation

**Context:** Asset precompilation caused resource usage issues during startup.

**Decision:** I disabled asset precompilation for the development environment, prioritizing performance improvements.

## Next Steps

1. Set up a regular backup schedule for Discourse data.
2. Configure the email notification system.
3. Implement monitoring and alerting for the deployment.
4. Document operational procedures for maintenance tasks.
5. Test and optimize performance settings.
6. Plan for production deployment with appropriate scaling considerations.

## References

- [Bitnami Discourse Helm Chart Documentation](https://artifacthub.io/packages/helm/bitnami/discourse)
- [Discourse Official Documentation](https://meta.discourse.org/c/support/setup/13)
- [Kubernetes Probes Configuration Guide](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Longhorn Storage Documentation](https://longhorn.io/docs/)
- [Rancher Ingress Configuration Guide](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/kubernetes-resources-setup/ingress)

---

**Hours Logged:** 6

**Tags:** kubernetes, rancher, discourse, helm, deployment, troubleshooting, ingress, tls, longhorn