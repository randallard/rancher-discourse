---
layout: home
title: Home
nav_order: 1
permalink: /
---

# Prisoner's Dilemma App Documentation

Welcome to the documentation for the Prisoner's Dilemma app, a tool for playing and exploring the classic game theory scenario.

## What is the Prisoner's Dilemma?

The Prisoner's Dilemma is a fundamental concept in game theory that demonstrates why two rational individuals might not cooperate, even when cooperation would benefit both.

## About This Project

This app allows users to:
- Play Prisoner's Dilemma games with friends
- Implement different strategies
- Track results and analyze outcomes
- Learn about game theory concepts

## Project Status
{: .fs-5 }

Want to know where we are in development? Check our [Project Plan & Status]({{ '/docs/project-plan-and-status' | relative_url }}) page to see our current progress, upcoming milestones, and development roadmap.

[View Project Status]({{ '/docs/project-plan-and-status' | relative_url }}){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

## Latest Development Update
{: .fs-5 }

{% assign latest_entry = site.html_pages | where: "parent", "Development Journal" | sort: "date" | reverse | first %}
{% if latest_entry %}
### [{{ latest_entry.title }}]({{ latest_entry.url | relative_url }})
**Date:** {{ latest_entry.date | date: "%B %d, %Y" }}

{{ latest_entry.excerpt | truncate: 150 }}

[View latest update]({{ latest_entry.url | relative_url }}){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[Development Journal]({{ '/docs/development-journal' | relative_url }}){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }
{% else %}
Development journal entries coming soon!

[Development Journal]({{ '/docs/development-journal' | relative_url }}){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }
{% endif %}

## Getting Started

To begin using or developing the app, check out the [Getting Started](docs/getting-started) guide.