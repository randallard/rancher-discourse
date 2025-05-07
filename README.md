# Rancher Discourse deployment Documentation

[![Just the Docs Version](https://img.shields.io/gem/v/just-the-docs)](https://github.com/just-the-docs/just-the-docs)
[![GitHub license](https://img.shields.io/github/license/randallard/rancher-discourse)](https://github.com/randallard/rancher-discourse/blob/main/LICENSE)

## Overview

This repository contains comprehensive documentation for the Rancher Discourse deployment, a deployment of Discourse on Rancher.

**Documentation Homepage**: [Home | Rancher Discourse deployment](https://randallard.github.io/rancher-discourse/)

## About the Documentation

This documentation is built using [Just the Docs](https://just-the-docs.github.io/just-the-docs/), a modern, customizable, and responsive Jekyll theme for documentation. It provides:

- Comprehensive guidance for both users and developers
- Technical specifications and architectural details
- Deployment journal tracking the project's progress
- Contribution guidelines for collaborators

## Documentation Structure

- **Home**: Introduction and project overview
- **Deployment Journal**: Progress tracking and Deployment notes
- **Technical Documentation**: Architecture, frontend, backend, and API details
- **User Guide**: Installation, configuration, and gameplay instructions
- **Contributing Guidelines**: How to contribute to the project

## Local Deployment

### Prerequisites

- Ruby version 2.5.0 or higher
- RubyGems
- Jekyll and Bundler

### Setup

1. Clone the repository
   ```bash
   git clone https://github.com/randallard/rancher-discourse.git
   cd rancher-discourse
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

3. Run the Deployment server
   ```bash
   bundle exec jekyll serve
   ```

4. Open your browser and navigate to `http://localhost:4000`

## Contributing to the Documentation

Contributions to improve the documentation are welcome. Please feel free to submit issues or pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-documentation`)
3. Commit your changes (`git commit -m 'Add some amazing documentation'`)
4. Push to the branch (`git push origin feature/amazing-documentation`)
5. Open a Pull Request

## License

This documentation is distributed under the [MIT License](LICENSE).