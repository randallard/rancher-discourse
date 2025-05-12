---
layout: page
title: Project Plan & Status
nav_order: 2
permalink: /docs/project-plan-and-status/
---

# Discourse on Rancher: Project Plan & Status

This document serves as a living record of our project plan, current status, and progress towards completing the Discourse deployment on Rancher Kubernetes.

## Current Status

**Phase**: Configuration & Customization  
**Last Updated**: May 12, 2025

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
7. **User Onboarding**: Create user guides and training materials

We've chosen to use the **Bitnami Helm Chart** approach as outlined in [our deployment options documentation]({{ '/docs/technical/deployment-options' | relative_url }}), specifically Option 1, for its balance of simplicity, maintainability, and customization capabilities.

## Core Requirements

### 1. Infrastructure Requirements
- ✅ Rancher-managed Kubernetes cluster with sufficient resources
- ✅ Appropriate storage class configuration for persistent data (Longhorn)
- ✅ Networking and ingress controller setup
- ✅ TLS certificates for secure access

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
- ✅ Working Discourse instance accessible via configured domain
- ✅ Admin account configured and secure
- ⬜ Basic theme and branding applied
- ⬜ Essential plugins installed
- ⬜ Email functionality validated

### 5. User Documentation
- ⬜ Standard user tutorial
- ⬜ Moderator guide
- ⬜ Administrator documentation
- ⬜ FAQs and common procedures

## Deployment Roadmap

### Phase 1: Planning & Setup ✅
- ✅ Create project documentation structure
- ✅ Research deployment options
- ✅ Select Bitnami Helm chart approach
- ✅ Define resource requirements
- ✅ Create Helm values.yaml configuration template
- ✅ Document prerequisites for Rancher environment

### Phase 2: Environment Preparation ✅
- ✅ Configure Kubernetes namespace
- ✅ Set up appropriate storage classes
- ✅ Configure network policies
- ✅ Prepare TLS certificates
- ✅ Set up container registry access (if needed)
- ✅ Create secrets for sensitive configuration

### Phase 3: Development Deployment ✅
- ✅ Deploy PostgreSQL using Helm chart
- ✅ Deploy Redis using Helm chart
- ✅ Deploy Discourse using Bitnami Helm chart
- ✅ Configure ingress for development access
- ✅ Validate basic functionality
- ✅ Document deployment process

### Phase 4: Configuration & Customization 🔄
- ✅ Configure admin account and settings
- ✅ Troubleshoot and resolve admin access issues
- ⬜ Install and configure required plugins
- ⬜ Apply custom theme and branding
- ⬜ Set up user authentication
- ⬜ Configure email delivery
- ⬜ Test and validate customizations
- 🔄 Monitor and resolve intermittent 503 errors

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

### Phase 7: User Documentation & Training
- ⬜ Create introductory tutorial for standard users
- ⬜ Develop moderator guidelines and training materials
- ⬜ Create administrator reference documentation
- ⬜ Compile FAQs based on initial user feedback
- ⬜ Establish documentation update process

## User Tutorial Development

### Overview
Creating comprehensive, user-friendly documentation is essential for successful adoption of our Discourse platform. The standard user tutorial will be designed to help new users navigate and use the platform effectively.

### Tutorial Requirements
- **Format**: Web-based, accessible through the Discourse platform itself
- **Audience**: Non-technical end users
- **Scope**: Core functionality for everyday participation

### Tutorial Content Plan
1. **Getting Started**
   - Account creation and login
   - Profile setup and personalization
   - Navigation overview
   - Notification settings

2. **Forum Participation**
   - How to read and follow topics
   - Creating new topics
   - Replying to discussions
   - Using formatting tools and markdown
   - Uploading images and attachments

3. **Advanced Features**
   - Using search effectively
   - Topic bookmarking and tracking
   - Tagging system
   - Voting on topics (using discourse-voting plugin)
   - Marking solutions (using discourse-solved plugin)

4. **Community Guidelines**
   - Behavior expectations
   - Reporting inappropriate content
   - Flagging system
   - Trust levels explained

### Delivery Methods
- In-app guided tour for first-time users
- Dedicated "Start Here" topic pinned to homepage
- Downloadable PDF version for offline reference
- Short video tutorials for complex processes

### Timeline
- **Draft Content**: To be completed by June 1, 2025
- **Internal Review**: June 1-7, 2025
- **Revisions**: June 8-14, 2025
- **Publication**: June 15, 2025, coinciding with user testing phase

## Key Decisions & Notes

<details>
<summary>Click to expand/collapse</summary>
<div markdown="1">

| Date | Decision | Rationale |
|------|----------|-----------|
| May 12, 2025 | Document VPN requirement for admin access | Resolved authentication issues related to network connectivity |
| May 12, 2025 | Maintained asset precompilation settings | Verified that authentication issues were network-related, not asset compilation related |
| May 11, 2025 | Disabled asset precompilation | Improved container startup time and reduced resource usage during initialization |
| May 11, 2025 | Increased probe delays | Accommodated actual application startup requirements, avoiding premature restarts |
| May 11, 2025 | Added user documentation phase | Recognized the importance of end-user guidance for adoption success |
| May 7, 2025 | Selected Bitnami Helm chart for deployment | Provides maintained, production-ready solution with simplified deployment while allowing sufficient customization |
| May 7, 2025 | Documented deployment options | To provide a clear comparison of approaches and justify our selected method |
| May 7, 2025 | Adopted documentation-first approach | To ensure clear requirements and procedures before beginning deployment |

</div>
</details>

## Next Steps

1. Investigate and resolve intermittent 503 errors
2. Set up regular backup schedule (high priority)
3. Configure email notification system (high priority)
4. Document operational procedures, including VPN requirements
5. Complete configuration of required plugins
6. Apply organization branding and theme
7. Create draft user tutorial content

## Current Focus: Troubleshooting 503 Errors & Email Configuration

With the development environment deployed and admin access configured, our current priorities are:

1. **503 Error Investigation**: Monitoring and troubleshooting intermittent 503 errors that occur when accessing specific Discourse topics
2. **Email System Setup**: Configuring and testing email functionality for notifications and password resets (high priority)
3. **Backup Configuration**: Setting up regular backup schedule for Discourse data (high priority)
4. **Operational Documentation**: Documenting VPN requirements and access procedures
5. **Plugin Configuration**: Setting up and testing the discourse-solved, discourse-voting, and discourse-data-explorer plugins
6. **Branding Implementation**: Applying organizational themes and customizations

We've successfully overcome initial deployment challenges with certificates, memory allocation, startup optimizations, and admin authentication issues, providing a solid foundation for further development and configuration.

## Recent Accomplishments

1. **Successful Discourse Deployment**: Deployed Discourse using Bitnami Helm chart on Rancher West Kubernetes cluster with Longhorn storage
2. **Admin Access Resolution**: Diagnosed and resolved admin authentication issues related to VPN connectivity
3. **Deployment Documentation**: Created detailed documentation of deployment process and troubleshooting steps
4. **Configuration Optimization**: Optimized container startup by configuring appropriate probe timings and disabling asset precompilation

## Known Issues

1. **Intermittent 503 Errors**: Investigating sporadic 503 errors when accessing specific Discourse topics
2. **VPN Dependency**: Admin access requires VPN connectivity, which needs to be documented clearly
3. **Admin Account Creation**: Manual creation worked through kubectl - not with helm

## Technology Choices

### Infrastructure
- **Container Orchestration**: Kubernetes managed by Rancher
- **Deployment Method**: Helm charts (Bitnami)
- **Database**: PostgreSQL (included in Helm chart)
- **Cache**: Redis (included in Helm chart)
- **Ingress**: NGINX Ingress Controller
- **TLS**: Let's Encrypt with cert-manager
- **Storage**: Longhorn

### Discourse Configuration
- **Version**: Latest stable from Bitnami chart (3.4.3)
- **Plugins**: discourse-solved, discourse-voting, discourse-data-explorer
- **Theme**: Custom theme based on organization branding
- **Authentication**: Internal with SSO integration (if required)

### Operations
- **Monitoring**: Prometheus and Grafana
- **Logging**: ELK Stack or Loki
- **Backups**: Automated using Velero
- **CI/CD**: GitOps with ArgoCD or FluxCD

## Open Questions

- What is causing the intermittent 503 errors and how can they be resolved?
- What specific metrics should we monitor for Discourse health?
- What backup schedule is appropriate for our usage patterns?
- How should we handle Discourse updates and database migrations?
- What additional plugins might be needed as usage grows?
- How will we measure user adoption and engagement?
- What user feedback mechanisms should we implement for the documentation?