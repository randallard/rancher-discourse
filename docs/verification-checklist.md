---
layout: page
title: Verification Checklist
nav_order: 2
permalink: /docs/verification-checklist/
---

# Discourse Deployment Verification Checklist

Use this checklist to validate your Discourse deployment in each environment.

## Infrastructure Verification

### Kubernetes Resources
- [ ] All pods are in Running state
- [ ] All services are correctly created
- [ ] Ingress resource is properly configured
- [ ] Persistent volume claims are bound
- [ ] Resource requests and limits are appropriate

### Networking
- [ ] Discourse web UI is accessible via configured domain
- [ ] HTTPS/TLS is working correctly
- [ ] Internal services can communicate
- [ ] External resources (email, S3) are accessible

### Storage
- [ ] PostgreSQL data persistence is working
- [ ] Redis data persistence is working
- [ ] Discourse uploads are persisted
- [ ] Backup storage location is accessible

## Application Verification

### Basic Functionality
- [ ] Admin login works with configured credentials
- [ ] Basic site settings are correctly applied
- [ ] New user registration works
- [ ] Creating topics and posts functions properly
- [ ] Search functionality works

### Email Functionality
- [ ] System emails are being sent
- [ ] New user email verification works
- [ ] Notification emails are delivered
- [ ] Reply by email works (if configured)

### Plugin Functionality
- [ ] All required plugins are installed
- [ ] discourse-solved plugin works (solutions can be marked)
- [ ] discourse-voting plugin works (votes can be cast)
- [ ] discourse-data-explorer plugin works (queries can be run)

### Customization
- [ ] Site title is correctly set
- [ ] Logo appears correctly
- [ ] Theme is applied correctly
- [ ] Categories are created as needed

## Operational Verification

### Monitoring
- [ ] Prometheus metrics are being collected
- [ ] Grafana dashboards are available
- [ ] Alerts are properly configured
- [ ] System health can be verified

### Backup & Recovery
- [ ] Automated backups are running
- [ ] Backups can be verified
- [ ] Restore process is documented and tested
- [ ] Disaster recovery plan is in place

### Security
- [ ] Admin passwords are strong and secure
- [ ] Database passwords are strong and secure
- [ ] TLS is properly configured
- [ ] Security settings are appropriately set
- [ ] Rate limiting is enabled

### Performance
- [ ] Page load times are acceptable
- [ ] Database performance is good
- [ ] CPU and memory usage are within expected ranges
- [ ] Scaling works if configured

## Post-Deployment Verification

### Documentation
- [ ] Deployment process is documented
- [ ] Operational procedures are documented
- [ ] User documentation is available
- [ ] Troubleshooting guide is created

### Training
- [ ] Administrators are trained
- [ ] Moderators understand their roles
- [ ] IT staff know maintenance procedures
- [ ] Support process is established

## Additional Notes:

* Perform this verification in the development environment first
* Address any issues before proceeding to production
* Re-verify after any significant changes or updates
* Schedule regular reviews of this checklist as part of maintenance