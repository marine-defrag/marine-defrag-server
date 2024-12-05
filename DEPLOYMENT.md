# How to deploy the Marine:DeFRAG server application

This document covers the steps need to deploy the application to an existing environment. To create a new environment, refer to [PROVISIONING.md](PROVISIONING.md).

## Introduction

Production deployment of the application is handled by [Kamal](https://kamal-deploy.org/) and the process is run using a [GitHub Actions workflow](https://github.com/marine-defrag/marine-defrag-server/actions/workflows/deploy.yml).
This ensures that only people with correct access permission can deploy the application, and that developers don't have to have any production secrets on their computers.

### Deployment Process

#### Manual

* Ideally, A pull request is created and merged into the `main` branch before deployment, though deployment can target any branch.
* Visit [the deployment action](https://github.com/marine-defrag/marine-defrag-server/actions/workflows/deploy.yml).
* Use "Run workflow" and select the branch name, or tag, to deploy
* Press the green "Run workflow" button

#### Automatic

Deployment will also be triggered when [a release is created](https://github.com/marine-defrag/marine-defrag-server/releases/new).

### Update ENV values

To update an existing value, navigate to the application's repository secrets on GitHub and select ["Settings" > "Secrets and variables" > "Actions"](https://github.com/marine-defrag/marine-defrag-server/settings/secrets/actions).

Note that you can't see the current value for any of these so, if you change any of these values, you won't be able to get the old value back unless you know what it was.

To create a new secret, click "New repository secret" and enter the name and value.
