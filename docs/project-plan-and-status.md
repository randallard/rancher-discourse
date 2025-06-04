---
layout: page
title: Project Plan & Status
nav_order: 2
permalink: /docs/project-plan-and-status/
---

# Discourse on Rancher: Project Plan & Status

This document serves as a living record of our project plan, current status, and progress towards completing the Discourse deployment on Rancher Kubernetes.

## Current Status

**Phase**: Production Deployment Complete - User Feedback & Enhancement Planning  
**Last Updated**: June 4, 2025

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
- ✅ User authentication integration (Two-factor auth with Duo Mobile verified)
- ✅ Email delivery service configuration

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
- ✅ Email functionality validated

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

### Phase 4: Configuration & Customization ✅
- ✅ Configure admin account and settings
- ✅ Troubleshoot and resolve admin access issues
- ✅ Resolve intermittent 503 errors by increasing memory allocation to 2GB
- ✅ Configure email delivery system with updated connection settings
- ✅ Resolve logo display issue by forcing HTTPS and re-uploading images
- ✅ Verify two-factor authentication with Duo Mobile (QR code setup and passcode login tested)
- ✅ Update Discourse to version 3.4.4 through ArgoCD
- ✅ Resolve mixed content HTTPS issues with force_https configuration
- ✅ Migrate to ReadWriteMany storage for high availability
- ✅ Scale to 2 replicas with proper memory allocation
- ⬜ Install and configure required plugins
- ⬜ Apply custom theme and branding

### Phase 5: Verification & Testing ✅
- ✅ Complete comprehensive verification checklist
- ✅ Validate all core functionality
- ✅ Performance testing and optimization
- ✅ Security validation
- ✅ User acceptance testing with Software Factory team

### Phase 6: Production Deployment ✅
- ✅ Finalize production values.yaml configuration
- ✅ Configure backup procedures via data migration process
- ✅ Deploy to production environment with 2-replica setup
- ✅ Validate all functionality with real users
- ✅ Document production deployment process
- ✅ Successfully deploy to Software Factory team
- ⬜ Set up comprehensive monitoring and alerting

### Phase 7: Post-Deployment 🔄
- ✅ Create maintenance and update procedures
- ✅ Develop disaster recovery plan (validated through migration process)
- ✅ Document operational procedures
- 🔄 Monitor production stability and performance
- 🔄 Gather user feedback for improvements

### Phase 8: User Documentation & Training ⬜
- ⬜ Create introductory tutorial for standard users
- ⬜ Develop moderator guidelines and training materials
- ⬜ Create administrator reference documentation
- ⬜ Compile FAQs based on initial user feedback
- ⬜ Establish documentation update process

### Phase 9: Enhancement Planning 🔄
- 🔄 Gather feedback from Software Factory team on current deployment
- 🔄 Evaluate SMAPP group application requirements and gather opinions
- 🔄 Plan implementation of group-based features and functionality
- ⬜ Design custom applications for specific user needs

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
- **Draft Content**: To be completed by June 15, 2025
- **Internal Review**: June 15-21, 2025
- **Revisions**: June 22-28, 2025
- **Publication**: July 1, 2025

## Key Decisions & Notes

<details>
<summary>Click to expand/collapse</summary>
<div markdown="1">

| Date | Decision | Rationale |
|------|----------|-----------|
| June 4, 2025 | Successfully deployed to production for Software Factory team | Stable deployment with 2 replicas and proper resource allocation achieved |
| June 4, 2025 | Completed storage migration to ReadWriteMany with zero data loss | Enabled high availability deployment with 2 replicas sharing storage |
| June 4, 2025 | Resolved mixed content HTTPS issues using DISCOURSE_EXTRA_CONF_CONTENT | Bitnami-specific configuration required manual config injection for force_https |
| June 4, 2025 | Doubled memory allocation and scaled to 2 replicas | Addressed memory exhaustion issues discovered during user testing |
| May 29, 2025 | Updated Discourse to version 3.4.4 via ArgoCD | Latest stable version with security updates and bug fixes |
| May 29, 2025 | Verified two-factor authentication with Duo Mobile | Confirmed QR code setup process and passcode login functionality working correctly |
| May 29, 2025 | Resolved logo display issue with HTTPS enforcement | Fixed logo visibility by forcing HTTPS protocol and re-uploading image assets |
| May 29, 2025 | Increased memory allocation to 2GB | Resolved 503 errors caused by admin dashboard graphs requiring over 1GB of memory to load |
| May 29, 2025 | Updated email connection configuration | Resolved email delivery issues for notifications and password resets |
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

### Immediate Priorities (June 2025)

1. **SMAPP Group Application Planning**
   - Gather feedback and opinions from Software Factory team on group-based functionality needs
   - Evaluate SMAPP (Small Group Application) requirements and use cases
   - Define technical specifications for group management features
   - Plan implementation timeline for custom group applications

2. **User Feedback Collection**
   - Conduct structured feedback sessions with Software Factory users
   - Document common user needs and pain points
   - Identify priority enhancements based on real usage patterns

3. **Enhanced Monitoring Setup**
   - Implement comprehensive Prometheus monitoring for production deployment
   - Set up alerting for memory usage, pod health, and performance metrics
   - Create production dashboards for ongoing operational visibility

### Medium-term Goals (July-August 2025)

4. **SMAPP Implementation**
   - Begin development of small group application features
   - Implement group-based permissions and workflows
   - Test group functionality with pilot users

5. **Documentation Completion**
   - Finalize standard user tutorial based on production feedback
   - Create moderator and administrator guides
   - Develop troubleshooting and FAQ documentation

6. **Platform Enhancement**
   - Complete configuration of required plugins (discourse-solved, discourse-voting, discourse-data-explorer)
   - Apply organization branding and theme customizations
   - Implement any custom features identified through user feedback

## Current Focus: Production Support & Enhancement Planning

With successful production deployment to the Software Factory team, our current priorities are:

1. **Production Monitoring**: Ensuring stable operation of the 2-replica deployment with proper resource monitoring
2. **User Feedback Collection**: Gathering insights from real users to guide future enhancements
3. **SMAPP Planning**: Understanding requirements for small group application functionality
4. **Performance Optimization**: Monitoring and optimizing the production deployment based on actual usage patterns
5. **Documentation**: Creating user-friendly guides based on real user interactions and feedback

## Recent Accomplishments

### Major Production Milestones ✅
1. **Production Deployment Success**: Successfully deployed stable Discourse instance to Software Factory team
2. **High Availability Architecture**: Implemented 2-replica deployment with ReadWriteMany storage using Longhorn
3. **Zero-Downtime Migration**: Successfully migrated all data (3 PVCs) from ReadWriteOnce to ReadWriteMany storage
4. **Mixed Content Resolution**: Resolved complex HTTPS mixed content issues using Bitnami-specific configuration methods
5. **Resource Optimization**: Doubled memory allocation and implemented proper resource monitoring after user load testing

### Technical Achievements ✅
6. **Storage Scalability**: Successfully migrated to shared storage architecture enabling horizontal scaling
7. **Configuration Management**: Mastered Bitnami-specific environment variable handling and custom config injection
8. **Deployment Automation**: Maintained ArgoCD-based deployment pipeline throughout scaling and migration process
9. **Performance Validation**: Validated system performance under real user load and optimized accordingly
10. **Data Integrity**: Achieved zero data loss during complex storage migration process

### Operational Excellence ✅
11. **Service Continuity**: Maintained same URL and user experience throughout all migrations and upgrades  
12. **Documentation**: Created comprehensive deployment and troubleshooting documentation
13. **Version Management**: Successfully updated Discourse to version 3.4.4 through automated pipeline
14. **Security**: Verified two-factor authentication and HTTPS configurations in production environment

## Current Production Status

- **Environment**: Production deployment on Rancher West Kubernetes cluster
- **Scale**: 2 Discourse pods with shared ReadWriteMany storage
- **Users**: Software Factory team actively using platform
- **Uptime**: Stable operation with proper resource allocation
- **Storage**: Longhorn-based ReadWriteMany PVCs supporting high availability
- **Security**: HTTPS enforced, 2FA verified, secure admin access documented

## Known Issues

**Resolved Issues** ✅
- ~~VPN Dependency: Admin access requires VPN connectivity~~ - Documented and resolved
- ~~Resource Requirements: Memory requirements higher than initially estimated~~ - Addressed with doubled allocation
- ~~Mixed Content HTTPS Issues~~ - Resolved with proper force_https configuration
- ~~Single Point of Failure Storage~~ - Resolved with ReadWriteMany migration

**Current Monitoring Items** 🔄
- Production performance metrics under growing user load
- Resource utilization trends for capacity planning
- User adoption patterns and feature usage analytics

## Technology Choices

### Infrastructure
- **Container Orchestration**: Kubernetes managed by Rancher
- **Deployment Method**: Helm charts (Bitnami) with ArgoCD automation
- **Database**: PostgreSQL (included in Helm chart)
- **Cache**: Redis (included in Helm chart)
- **Ingress**: NGINX Ingress Controller
- **TLS**: Let's Encrypt with cert-manager
- **Storage**: Longhorn with ReadWriteMany support
- **CI/CD**: ArgoCD for automated deployments
- **High Availability**: 2-replica deployment with shared storage

### Discourse Configuration
- **Version**: 3.4.4 (managed via ArgoCD)
- **Plugins**: discourse-solved, discourse-voting, discourse-data-explorer (pending configuration)
- **Theme**: Custom theme based on organization branding (pending implementation)
- **Authentication**: Internal with two-factor authentication (Duo Mobile verified)
- **Configuration**: Custom config injection via DISCOURSE_EXTRA_CONF_CONTENT

### Operations
- **Monitoring**: Prometheus and Grafana (implementation in progress)
- **Logging**: ELK Stack or Loki (to be implemented)
- **Backups**: Validated through successful data migration process
- **Scaling**: Horizontal scaling capability demonstrated through ReadWriteMany migration

## Open Questions

### Technical Planning
- What specific SMAPP group application features are most needed by users?
- How should we implement group-based permissions and workflows?
- What monitoring thresholds should trigger scaling events?
- What backup schedule is appropriate for our current usage patterns?

### User Experience
- What additional plugins might be needed based on Software Factory feedback?
- How should we measure user adoption and engagement success?
- What user feedback mechanisms should we implement for ongoing improvements?
- What performance benchmarks indicate readiness for broader rollout?

### Operational
- How will we handle Discourse updates and database migrations in the production environment?
- What disaster recovery procedures should we establish beyond the current migration capability?
- How should we plan capacity scaling based on user growth patterns?