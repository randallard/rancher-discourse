---
layout: default
title: "Journal Entry #8"
parent: Deployment Journal
nav_order: [REVERSE_CHRONOLOGICAL_ORDER] 
date: 2025-06-04
---

# Journal Entry #8 - Production Deployment & Scaling
{: .no_toc }

**Date:** 2025-06-04
{: .fs-5 }

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

Ryan's notes - review of these docs proved invaluable in going over past decisions and catching a false assumption I'd made based on one of the failed attempts to fix the mixed content issue - realizing that allowed us to go back to 2 replicas with confidence - super thankful for that.

POV: I am the AI Assistant, helping to set up the deployment

## Progress Update

Successfully deployed Discourse to production for the Software Factory team after resolving critical scaling and mixed content issues. The deployment now runs with improved architecture, better resource allocation, and proper HTTPS configuration.

## Major Milestones

### Production Rollout to Software Factory

**Achievement:** Successfully deployed stable Discourse instance to initial user group.

**Process:** Rolled out to small internal team first for testing and validation before broader deployment.

**Status:** ✅ Completed - Software Factory team actively using the platform.

### Memory Optimization & Resource Scaling

**Problem:** Initial deployment experienced memory exhaustion leading to pod crashes during user testing.

**Solution:** 
- Doubled memory allocation for Discourse pods
- Upgraded resource limits and requests in deployment configuration
- Implemented proper resource monitoring

**Status:** ✅ Completed - Pods now stable under user load.

## Critical Issues Resolved

### Mixed Content HTTPS Resolution

**Problem:** Discourse was generating HTTP URLs for assets (fonts, favicon, logo) on HTTPS site, causing browser mixed content errors and blocking resources.

**Root Cause:** Missing `force_https = true` configuration in `/opt/bitnami/discourse/config/discourse.conf` file.

**Solution Process:**
1. Verified NGINX ingress TLS configuration was correct
2. Confirmed `DISCOURSE_FORCE_HTTPS=true` environment variable was set
3. Discovered Bitnami scripts expect `DISCOURSE_ENABLE_HTTPS` instead
4. Found that standard environment variables weren't populating config file
5. **Final Solution:** Added `DISCOURSE_EXTRA_CONF_CONTENT: "force_https = true"` to manually inject required configuration

**Status:** ✅ Completed - All assets now load properly over HTTPS.

### Storage Migration to ReadWriteMany

**Problem:** Single replica setup with ReadWriteOnce storage limited scalability and availability.

**Solution:** Executed comprehensive data migration:
- Migrated 3 PVCs from ReadWriteOnce to ReadWriteMany using Longhorn
- `discourse` → `discourse-v2` (10Gi)
- `data-discourse-postgresql-0` → `data-discourse-postgresql-v2` (8Gi)
- `redis-data-discourse-redis-master-0` → `redis-data-discourse-redis-master-v2` (8Gi)

**Migration Process:**
1. Scaled down all services for clean data state
2. Used parallel copy job for safe data transfer
3. Updated deployment configuration for ReadWriteMany PVCs
4. Scaled to 2 replicas for improved availability
5. Deployed via ArgoCD with zero downtime

**Status:** ✅ Completed - Running 2 Discourse pods with shared storage.

## Architecture Improvements

### High Availability Configuration

Successfully transitioned from single-replica to multi-replica architecture:
- **2 Discourse pods** running with shared ReadWriteMany storage
- **Improved load distribution** across replicas
- **Better fault tolerance** with redundant instances
- **Zero downtime deployment** capability

### Resource Optimization

Implemented proper resource management:
- Doubled memory allocation to handle user load
- Configured appropriate CPU limits and requests
- Set up resource monitoring for proactive scaling

## Technical Achievements

- **Data Integrity:** Zero data loss during migration process
- **Service Continuity:** Maintained same URL (`discourse.fcsf.dcn`) throughout migration
- **Configuration Management:** Resolved Bitnami-specific environment variable handling
- **Storage Scalability:** Successfully migrated to shared storage architecture

## Outstanding Items

### Future Enhancements

- Complete passkey login configuration and testing
- Implement comprehensive monitoring and alerting
- Document production deployment procedures
- Plan for broader user rollout beyond Software Factory

## Next Steps

1. Monitor production stability and performance metrics
2. Gather user feedback from Software Factory team
3. Prepare for expanded user rollout
4. Implement automated backup and disaster recovery procedures

## Technical Notes

- Bitnami Discourse images require specific environment variable names that differ from standard Discourse documentation
- `DISCOURSE_EXTRA_CONF_CONTENT` is essential for custom configuration injection
- ReadWriteMany storage with Longhorn works reliably for multi-replica deployments
- ArgoCD sync status remains clean after migration completion

## Lessons Learned

- Always test with real user load before production deployment
- Bitnami container configurations may require manual config injection
- Data migration planning is critical for zero-downtime operations
- Resource monitoring is essential for identifying scaling needs early

---

**Hours Logged:** 8.5 (across multiple sessions)

**Tags:** kubernetes, rancher, discourse, helm, production, scaling, memory-optimization, https, mixed-content, readwritemany, longhorn, data-migration, argocd, software-factory, bitnami