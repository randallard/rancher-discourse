---
layout: home
title: Home
nav_order: 1
permalink: /
---

# Rancher Discourse deployment Documentation

Welcome to the documentation for the Rancher Discourse deployment, documentation on our deployment of Discourse on Rancher.

## About This Project

This deployment allows users to:
- Deploy Discourse on Rancher
## Project Status
{: .fs-5 }

Want to know where we are in deployment? Check our [Project Plan & Status]({{ '/docs/project-plan-and-status' | relative_url }}) page to see our current progress, upcoming milestones, and deployment roadmap.

[View Project Status]({{ '/docs/project-plan-and-status' | relative_url }}){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

## Latest Deployment Update
{: .fs-5 }

{% assign latest_entry = site.html_pages | where: "parent", "Deployment Journal" | sort: "date" | reverse | first %}
{% if latest_entry %}
### [{{ latest_entry.title }}]({{ latest_entry.url | relative_url }})
**Date:** {{ latest_entry.date | date: "%B %d, %Y" }}

{{ latest_entry.excerpt | truncate: 150 }}

[View latest update]({{ latest_entry.url | relative_url }}){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[Deployment Journal]({{ '/docs/deployment-journal' | relative_url }}){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }
{% else %}
Deployment journal entries coming soon!

[Deployment Journal]({{ '/docs/deployment-journal' | relative_url }}){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }
{% endif %}

## Getting Started

To begin using or developing the app, check out the [Getting Started](docs/getting-started) guide.