---
title: Installation
parent: Raito CLI
nav_order: 20
permalink: /docs/cli/installation
---
# Installation

## Installing the CLI
### Using Homebrew

To install the Raito CLI on macOS or Linux, the easiest way is using Homebrew.

Simply execute the following in a terminal window:
```bash
$> brew install raito-io/tap/cli
```

### Manual installation

If you don't have Brew you can also install it manually. To do this, go to [the Github releases](https://github.com/raito-io/cli/releases){:target="_blank"}, find the version you want (the latest is always recommended) and find the build that corresponds to your operating system. Right-click on the file and copy the link URL. 
The following snippet shows and example of how you can then use that URL to download and unpack the Raito CLI.

```bash
$> wget https://github.com/raito-io/cli/releases/download/v0.19.0/raito-0.19.0-darwin_arm64.tar.gz
$> tar -xzvf raito-0.19.0-darwin_arm64.tar.gz
$> ./raito --help
```

## Check installation

To get the version you have installed:
```bash
$> raito --version
```

or an overview of the possibilities of the CLI, execute:
```bash
$> raito --help
```

Find out more about the different actions you can perform with the CLI [here](/docs/cli/commands). 

### Using Docker
To run the Raito CLI **run** command continuously, a docker container can be used.
Download the latest Docker image by using the following command:

```bash
$> docker pull ghcr.io/raito-io/raito-cli-runner:latest
```

Find out more about how to run the Docker Raito CLI runner [here](/docs/cli/docker).

## Further reading

Next, you can take a look at the different [commands](/docs/cli/commands) the Raito CLI has to offer or learn how to [configure](/docs/cli/configuration) the CLI to start connecting it to your data warehouse(s) and Raito Cloud.

A full step-by-step guide on how to get started with Snowflake and Raito Cloud can be found [here](/docs/guide/cloud).