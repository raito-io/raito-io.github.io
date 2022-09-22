---
title: Installation
parent: Raito CLI
nav_order: 20
permalink: /docs/cli/get_started
---
# Get started

## Installing the CLI
### Using Homebrew

To install the Raito CLI on MacOS or Linux, the easiest way is using Homebrew.

Simply execute the following the do the installation:
```bash
$> brew install raito-io/tap/cli
```

### Manual installation

Alternatively, go to [the Github releases](https://github.com/raito-io/cli/releases){:target="_blank"}, find the version you want and go from there. E.g.

```bash
$> wget https://github.com/raito-io/cli/releases/download/v0.19.0/raito-0.19.0-darwin_arm64.tar.gz
$> tar -xzvf raito-0.19.0-darwin_arm64.tar.gz
$> ./raito --help
```

Currently we release for Linux and Mac OS.

## Install Raito CLI

To get the version you have installed:
```bash
$> raito --version
```

or an overview of the possibilities of the CLI, execute:
```bash
$> raito --help
```

There are two main operation modes for the CLI through the 
- [**access** command](/docs/cli/commands/access). Push access controls to your data warehouses using (versioned) yaml files.
- [**run** command](/docs/cli/commands/run). Export information from your data warehouse into Raito Cloud and push access controls from Raito Cloud to your data warehouse.

Find out more [here](/docs/cli/commands). For the rest of this get started we'll make sure that everything is working properly.

## Connect Raito CLI ...

The Raito CLI uses a yaml configuration; [an example here](/docs/cli/configuration#2-configuration-file){:target="_blank"}. By default it will look for a file called
`raito.yml` in the working directory, or in the `~/.raito` directory. See [here](/docs/cli/configuration#2-configuration-file) for more details.  

### .... to Raito Cloud [optional]

In your `raito.yaml` file, make sure that the `domain`, `api-user` and `api-secret` are correctly set. 

*TODO: implement!*

To test your connections with Raito Cloud, run the  following command:
```bash
$> raito connect cloud
```
If a connection could be established, you should see a message like
```bash
Successfully connected to Raito Cloud
```


### ... to a data source

We will try to connect to a Snowflake data warehouse in this section. To do this, you'll need to use the Snowflake connector. It can be automatically downloaded (from Github)[https://github.com/raito-io/cli-plugin-snowflake]{:target="_blank"}
by adding the following configuration to `raito.yml`
```js
repositories:
  - name: raito-io
    token: "<github_personal_access_token>"
```
To get more information on how to create a Personal Access Token, consult [the Github documentation](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token){:target="_blank"}. When you run the CLI, it will download the Snowflake plugin for the version you've specified in `connector-version` (or latest???) to the `~/.raito/plugins/raito-io` folder. Subsequentially the CLI will always first check if the plugin is available in that folder before connecting to Github.

To actually test the connection, make sure the following parameters are specified in your target's configuration in `raito.yml`:
```js
sf-account: <e.g. xy123456.eu-central-1>
sf-user: <youruser>
sf-password: <yourpassword>
sf-database: <yourdatabase>
```
and then test the connection with
```bash
$> raito connect --only-targets snowflake1
```
If a connection could be established, you should see a message like
```bash
Successfully connected to target snowflake1
```

If that didn't work, try making a connection through a tool like  `curl`, e.g. from the [Snowflake community](https://community.snowflake.com/s/article/Normal-responses-on-curl-v-k-requests){:target="_blank"}.

## Further reading

If you want to know more, go to the [CLI section](/docs/cli) or read about [general Raito concepts](/docs/concepts). 
