---
layout: default
title: Deployment Journal
nav_order: 3
has_children: true
permalink: /docs/deployment-journal
---

# Deployment Journal
{: .no_toc }

This journal documents the Deployment process of the Rancher Discourse deployment, tracking progress, decisions, challenges, and lessons learned throughout the project lifecycle.

## Latest Entry
{: .text-delta }

{% assign latest_entry = site.html_pages | where: "parent", "Deployment Journal" | sort: "date" | reverse | first %}
{% if latest_entry %}
### [{{ latest_entry.title }}]({{ latest_entry.url | relative_url }})
**Date:** {{ latest_entry.date | date: "%B %d, %Y" }}

{{ latest_entry.excerpt }}

[Read more]({{ latest_entry.url | relative_url }}){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
{% else %}
No journal entries yet.
{% endif %}

## All Entries
{: .text-delta }

{% assign entries = site.html_pages | where: "parent", "Deployment Journal" | sort: "date" | reverse %}
{% for entry in entries %}
- [{{ entry.title }}]({{ entry.url | relative_url }}) - {{ entry.date | date: "%B %d, %Y" }}
{% endfor %}