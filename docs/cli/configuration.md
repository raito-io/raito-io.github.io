---
title: Configuration
parent: CLI
nav_order: 4
permalink: /cli/configuration
---
# Configuration
## Introduction
Configuration parameters can be passed into the CLI in 3 different ways:
1. **Flags**: you can use the command line flags directly on the CLI to pass in configuration parameters.<br>
Note: this limits you to only one target (see later).
2. **File**: you can specify the configuration parameters in a YAML file. By default, *raito.yml* (in the working directory) is used. The file to use, can be specified using the *config-file* flag.<br> 
For example:
```bash
$> raito <command> --config-file myconfig.yaml
```
The configuration file allows you to specify multiple targets instead of only 1 (see later).
1. **Environment Variables**: the flags can also be specified as environment variables. The name of the environment variable is constructed by taking the command line flag name, convert it to upper-case, replace dashes (-) to underscores (\_) and prefix with *RAITO\_*.<br>
e.g. parameter *--config-file* as command line flag becomes *RAITO_CONFIG_FILE* as an environment variable.

To easily explain the different parameters, we split them up in different categories:

## Global parameters
 - **config-file** *(optional)*: the file path of the configuration YAML file to use. By default, the system will look for a file called 'raito.yml' or 'raito.yaml' in the working directory or under directory '~/.raito/'.
 - **log-file** *(optional)*: the file path of the log file to use. If not specified, no logging to file is done.
 - **debug** *(optional)*: a boolean flag to request extra debug output. Can be useful when building a plugin or when something is wrong.

## Targets
The Raito CLI works against one or more [targets](/cli/intro#targets).

A target has the following parameters:
 - **connector**: the name of the connector (plugin) to use to connect to the data source or identity store.
 - **name** *(optional)*: the name of this specific target. This name is used during logging to understand which target is active at that time. If not specified, the *target-connector* value is used.
 - **data-source-id**: the id (UUID) of the data source in Raito the target corresponds to. This parameter only needs to be specified for actions that require it.
 - **identity-store-id**: the id (UUID) of the data source in Raito that the target corresponds to. This is not necessary when the target is a data source only or when not connecting to Raito (e.g. the *access* command).

There are two options to specify targets:

### 1. Command-line
You can specify your target directly with the command-line arguments. This only allows you to specify one target.

For example:
```bash
$> raito <command> --connector snowflake --name production-snowflake --data-source-id xxxx ...
```

### 2. Configuration file
Specifying the targets in a configuration file, allows you to specify multiple targets.

An example *raito.yml* file: 
```yaml
# Parameters that can be configurated globally can go here:
domain: app

# The list of targets (data sources and/or identity stores) to handle in the CLI:
targets:
  - name: okta1
    connector: okta
    identity-store-id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

    # You can specify the raito API user and secret per target. This user needs to have the necessary permissions on the data source and/or identity store
    # If it's the same for all targets, you can also put these as global parameters.
    api-user: okta1
    api-secret: <mysecret>

    # The connector specific parameters
    okta-domain: xxx.okta.com
    okta-token: <secret-token>

    # Action specific parameters. These can also be specified globally.
    delete-temp-files: true
    replace-tags: true
    replace-groups: true
    delete-untouched: true

  - name: snowflake1
    connector: snowflake
    data-source-id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    identity-store-id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

    # Specify api-user and api-secret if you want to override the user to use for
    api-user: snowflake1
    api-secret: <mysecret>

    # The connector specific parameters
    sf-account: yyyyyy.eu-central-1
    sf-user: <youruser>
    sf-password: <yourpassword>

    # Action specific parameters. These can also be specified globally. 
    delete-temp-files: true
    replace-tags: true
    replace-groups: true
    delete-untouched: true

    # These allow you to skip certain actions during the 'run' command. These can also be specified globally.
    skip-data-source-sync: false
    skip-identity-store-sync: false
    skip-data-access-sync: false

...
```

When specifying multiple targets, it can be useful to only execute a subset of the targets for a specific run. To do this, simply specify the *only-targets* parameters as a comma-separated list of targets to run.

For example (with the above configuration file), to run the okta and snowflake targets alone (considering there are more in the configuration file):
```bash
$> raito <command> --only-targets okta1,snowflake1
```

## Raito parameters
To connect the CLI to your Raito instance, you'll also need to specify the following parameters, either as command line flags, as environment variables, in the configuration file globally or in the configuration file under the specific target section:

 - **domain** *(optional)*: The sub-domain of your Raito instance (from https://<subdomain>.raito.io).
 - **api-user** *(optional)*: The user name of the API user to use to connect to your Raito instance.
 Note: this users needs to have the necessary permissions on the data source or identity store it needs to interact with.
 - **api-secret** *(optional)*: The secret API token for the API user to authenticate against Raito.

## Connector specific parameters
Each connector will have its specific parameters. These can either be specified under the target definition in the configuration file, as seen in the example configuration file above, or directly on the command line (when the single target is specified there).

The latter is done by adding these parameters at the end of the command, by placing ' -- ' after the last normal parameter. This is the standard way in Bash to mark the end of the command parameters. Everything behind that, will be pass as key-value pairs to the connector plugin.

For example:
```bash
$> raito <command> --connector snowflake --name snowflake1 --data-source-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -- --sf-account yyyyyy.eu-central-1 --sf-user <youruser> --sf-password <yourpassword>
```

## Overview
| Parameter name | Description | Applies To |
|----------------|-------------|------------|
|                |             |            |
|                |             |            |
