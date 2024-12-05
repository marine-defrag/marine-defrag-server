# How to provision a new environment for the Marine:DeFRAG server application

## Pre-requisites

To start with, we need a server running Ubuntu 24.04.1 LTS. This server should have a user with sudo privileges and a public key for SSH access.

## Initial setup

### Kamal

Kamal is a tool that helps with provisioning and deploying the Marine:DeFRAG server application. It is a Ruby gem, installed using a [separate Gemfile](gemfiles/deploy), that is made available through the `bin/kamal` interface.

To install Kamal, run this on your local machine:

```sh
bundle install --gemfile=gemfiles/deploy
```

If it generates binstubs then you can clear these out using:

```sh
git checkout bin && git clean -f bin
```

### Provisioning

To provision the new server, run this on your local machine:

```sh
bin/kamal env push
bin/kamal setup
bin/kamal accessory boot all
```

This will push environment secrets, install Docker, configure accessories including postgresql, and be [ready for deployment](DEPLOYMENT.md).
