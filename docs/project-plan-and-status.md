---
layout: page
title: Project Plan & Status
nav_order: 2
permalink: /docs/project-plan-and-status/
---

# Discourse on Rancher: Project Plan & Status

This document serves as a living record of our project plan, current status, and progress towards completing the Discourse deployment on Rancher Kubernetes.

## Current Status

**Phase**: Planning & Setup  
**Last Updated**: May 7, 2025

## Project Vision

To deploy and configure a production-ready Discourse forum on our Rancher-managed Kubernetes cluster using the Bitnami Helm chart approach, providing a scalable and maintainable community platform.

## Deployment Approach

Our deployment will follow a structured approach with emphasis on documentation and testing:

1. **Research & Selection**: Evaluate deployment options and select optimal approach
2. **Environment Preparation**: Configure Rancher and Kubernetes prerequisites 
3. **Deployment Configuration**: Create and validate Helm chart values
4. **Testing Deployment**: Deploy in development environment and validate functionality
5. **Production Deployment**: Roll out to production with monitoring and backup strategies
6. **Documentation**: Maintain comprehensive deployment and operational documentation

We've chosen to use the **Bitnami Helm Chart** approach as outlined in [our deployment options documentation](/docs/technical/deployment-options), specifically Option 1, for its balance of simplicity, maintainability, and customization capabilities.

## Core Requirements

### 1. Infrastructure Requirements
- ⬜ Rancher-managed Kubernetes cluster with sufficient resources
- ⬜ Appropriate storage class configuration for persistent data
- ⬜ Networking and ingress controller setup
- ⬜ TLS certificates for secure access

### 2. Discourse Configuration
- ⬜ Custom theme and branding
- ⬜ Required plugins installation and configuration
- ⬜ User authentication integration
- ⬜ Email delivery service configuration

### 3. Operational Requirements
- ⬜ Automated backup and restore procedures
- ⬜ Monitoring and alerting setup
- ⬜ Update and maintenance procedures
- ⬜ Disaster recovery documentation

### 4. Minimal Viable Deployment
- ⬜ Working Discourse instance accessible via configured domain
- ⬜ Admin account configured and secure
- ⬜ Basic theme and branding applied
- ⬜ Essential plugins installed
- ⬜ Email functionality validated

## Deployment Roadmap

### Phase 1: Planning & Setup ⬜
- ✓ Create project documentation structure
- ✓ Research deployment options
- ✓ Select Bitnami Helm chart approach
- ⬜ Define resource requirements
- ⬜ Create Helm values.yaml configuration template
- ⬜ Document prerequisites for Rancher environment

### Phase 2: Environment Preparation
- ⬜ Configure Kubernetes namespace
- ⬜ Set up appropriate storage classes
- ⬜ Configure network policies
- ⬜ Prepare TLS certificates
- ⬜ Set up container registry access (if needed)
- ⬜ Create secrets for sensitive configuration

### Phase 3: Development Deployment
- ⬜ Deploy PostgreSQL using Helm chart
- ⬜ Deploy Redis using Helm chart
- ⬜ Deploy Discourse using Bitnami Helm chart
- ⬜ Configure ingress for development access
- ⬜ Validate basic functionality
- ⬜ Document deployment process

### Phase 4: Configuration & Customization
- ⬜ Configure admin account and settings
- ⬜ Install and configure required plugins
- ⬜ Apply custom theme and branding
- ⬜ Set up user authentication
- ⬜ Configure email delivery
- ⬜ Test and validate customizations

### Phase 5: Production Deployment
- ⬜ Finalize production values.yaml configuration
- ⬜ Set up monitoring and alerting
- ⬜ Configure backup procedures
- ⬜ Deploy to production environment
- ⬜ Validate all functionality
- ⬜ Document production deployment

### Phase 6: Post-Deployment
- ⬜ Create maintenance and update procedures
- ⬜ Develop disaster recovery plan
- ⬜ Train administrators on operational procedures
- ⬜ Handover documentation and training

## Key Decisions & Notes

<details>
<summary>Click to expand/collapse</summary>
<div markdown="1">

| Date | Decision | Rationale |
|------|----------|-----------|
| May 7, 2025 | Selected Bitnami Helm chart for deployment | Provides maintained, production-ready solution with simplified deployment while allowing sufficient customization |
| May 7, 2025 | Documented deployment options | To provide a clear comparison of approaches and justify our selected method |
| May 7, 2025 | Adopted documentation-first approach | To ensure clear requirements and procedures before beginning deployment |

</div>
</details>

## Next Steps

1. Define specific resource requirements for our Discourse deployment
2. Create a customized values.yaml file for our environment
3. Document Rancher and Kubernetes prerequisites
4. Prepare development environment for initial deployment
5. Create deployment verification checklist

## Current Focus: Environment Preparation

With the deployment approach selected, we're now focusing on preparing our Rancher environment for the Discourse deployment. This includes:

1. **Resource Planning**: Determining CPU, memory, and storage requirements
2. **Helm Configuration**: Creating a values.yaml file specific to our needs
3. **Environment Setup**: Configuring the necessary Kubernetes prerequisites
4. **Deployment Documentation**: Creating step-by-step deployment instructions

We've documented three potential approaches for deploying Discourse on Rancher in our [deployment options](/docs/technical/deployment-options) guide and have selected Option 1 (Bitnami Helm chart) as our preferred method due to its balance of simplicity and flexibility.

## Technology Choices

### Infrastructure
- **Container Orchestration**: Kubernetes managed by Rancher
- **Deployment Method**: Helm charts (Bitnami)
- **Database**: PostgreSQL (included in Helm chart)
- **Cache**: Redis (included in Helm chart)
- **Ingress**: NGINX Ingress Controller
- **TLS**: Let's Encrypt with cert-manager

### Discourse Configuration
- **Version**: Latest stable from Bitnami chart
- **Plugins**: To be determined based on requirements
- **Theme**: Custom theme based on organization branding
- **Authentication**: Internal with SSO integration (if required)

### Operations
- **Monitoring**: Prometheus and Grafana
- **Logging**: ELK Stack or Loki
- **Backups**: Automated using Velero
- **CI/CD**: GitOps with ArgoCD or FluxCD

## Open Questions

- What storage class should we use for persistent data?
- What resource limits should we set for Discourse, PostgreSQL, and Redis?
- What specific plugins are required for our Discourse implementation?
- Should we implement SSO authentication, and if so, with which provider?
- What monitoring metrics and alerts are most important for this deployment?
- What is our strategy for handling Discourse updates and database migrations?