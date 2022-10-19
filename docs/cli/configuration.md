---
title: Configuration
parent: Raito CLI
nav_order: 30
permalink: /docs/cli/configuration
---
# Configuration
## Introduction
Configuration parameters can be passed into the CLI in two different ways:


1. **File**: you can specify the configuration parameters in a YAML file. By default, *raito.yml* or *raito.yaml* (in the working directory or '~/.raito') is used. The file to use, can be specified using the *config-file* flag.<br> 
For example:
```bash
$> raito <command> --config-file myconfig.yaml
```
The configuration file allows you to specify multiple targets instead of only 1 (see later). Environment variables can be used in the configuration file by using double curly brackets, e.g. {% raw %}
```js
sf-password: "{{SNOWFLAKE_PASSWORD}}"
```
{% endraw %}
1. **Flags**: you can use the command line flags directly on the CLI to pass in configuration parameters.<br>
Note: this limits you to only one target (see later).


<!-- 1. **Environment Variables**: the flags can also be specified as environment variables. The name of the environment variable is constructed by taking the command line flag name, convert it to upper-case, replace dashes (-) to underscores (\_) and prefix with *RAITO\_*.<br>
e.g. parameter *--config-file* as command line flag becomes *RAITO_CONFIG_FILE* as an environment variable. -->

The recommended way is to use the configuration through file, whereas configuration flags are convenient for development and testing. The different parameters can be divided into the following categories:
- [Global parameters](#global-parameters). Parameters applicable to `raito` command, like logging. 
- [Command-specific parameters](#command-specific-parameters). Parameters applicable to a sub-command, e.g. `raito access`.
- [Raito parameters](#raito-parameters). Parameters required to connect to Raito Cloud. 
- [Target parameters](#target-parameters). Parameters to configure a target.
- [Connector-specific parameters](#connector-specific-parameters). Parameters specific to a connector.

In the case of configuration through a file; some of the global, command-specific, and raito parameters can also be specified at the target level, this means they will only be available and used when executing that target. See the [example configuration file](#configuration-file) below. 

## Global parameters
 - **config-file** *(optional)*: the file path of the configuration YAML file to use. By default, the system will look for a file called 'raito.yml' or 'raito.yaml' in the working directory or under directory '~/.raito/'.
 - **log-file** *(optional)*: the file path of the log file to use. If not specified, no logging to file is done.
 - **debug** *(optional)*: a boolean flag to request extra debug output. Can be useful when building a plugin or when something is wrong.
 - **only-targets** *(optional)*: comma-separated list of targets that need to be run. If left empty, all targets will be run. 
 <!-- - **environment**: does not need to mentioned I guess. -->
 - **log-output** enable full line-by-line logging instead of the logging summary.
 - **repositories** allows you to specity a Github Personal Account Token to download a connector from a private repository. It can be configured like


 {% raw %}
```yaml
repositories:
  - name: raito-io
    token: "{{GITHUB_PERSONAL_ACCOUNT_TOKEN}}"
```
 {% endraw %}

## Command specific parameters
A specific command can have its own parameters. These can be revealed by doing
```bash
$> raito <command> --help
```

### *run*

 - **frequency**: The frequency used to do the sync (in minutes). When not set, the default value '0' is used, which means the sync will run once and quit after.
- **skip-data-access-sync**: If set, the data access information from Raito Cloud will not be synced to the data sources in the target list, and no data access information will be sent to Raito Cloud.
- **skip-data-source-sync**: If set, the data source meta data synchronization step to Raito Cloud will be skipped for each of the targets.
- **skip-data-usage-sync**: If set, the data usage information synchronization step to Raito Cloud  will be skipped for each of the targets.
- **skip-identity-store-sync**: If set, the identity store synchronization step to Raito Cloud will be skipped for each of the targets.
<!-- - **delete-untouched**: false by default. Removes objects that have not been updated during the CLI sync. For instance, if set to false during a data source sync, data objects that do not exist anymore in the target will not be removed from Raito Cloud.  -->
<!-- - **replace-tags**:  TODO: should we document this as we do not support groups right now?  -->
<!-- - **delete-temp-files**: false by default. Delete temporary files that contain the information extracted from the  target and are uploaded to Raito Cloud.  -->
<!-- - **replace-groups**: TODO: should we document this as we do not support groups right now?  -->

### *access*

One extra option:
- **access-file**. If set, specify a custom file path to use for the location of the access definition file. Default is "access.yml". This can also be specified under the target in the configuration file. That way, you can specify access to multiple targets to be provisioned in one run. 

## Raito parameters
To connect the CLI to your Raito instance, you'll also need to specify the following parameters, globally or in the configuration file under the specific target section:

 - **domain** *(optional)*: The sub-domain of your Raito instance (e.g. https://*domain*.raito.io).
 - **api-user** *(optional)*: The user name of the API user to use to connect to your Raito instance.
 Note: this users needs to have the necessary permissions on the data source or identity store it needs to interact with.
 - **api-secret** *(optional)*: The secret API token for the API user to authenticate against Raito.


## Target parameters

The Raito CLI works against one or more [targets](/docs/cli/intro#targets). A target is a system or server like a data warehouse, identity provider, etc.

A target has the following parameters:
- **name** *(optional)*: a name you can choose for this specific target. This name is used during logging to understand which target is active at that time. If not specified, the *target-connector* value is used.
- **data-source-id**: the id (NanoID) of the data source in Raito the target corresponds to. This parameter only needs to be specified for actions that require it.
- **identity-store-id**: the id (NanoID) of the data source in Raito that the target corresponds to. This parameter only needs to be specified for actions that require it.
- **connector-name**: the name of the connector (plugin) to use to connect to the data source or identity store. Several targets can use the same connector if you have multiple data warehouses
 of the same type.
- **connector-version**: the version of the connector (plugin) to use to connect to the data source or identity store. If not specified, the latest version of the connector will be used.
 of the same type.


## Connector-specific parameters
Each connector will have its specific set of parameters. These are defined in the connnector itself. These parameters can be shown by
```bash
$> raito info <connector-name> <connector-version>
```
The value for `<connector-name>` is as defined in the target configuration, e.g. `raito.io/cli-plugin-snowflake`. If `<connector-version>` is not specified, it will use the latest version. The Snowflake connector's parameters are documented [here](/docs/cli/connectors/snowflake#snowflake-specific-parameters).

These can either be specified under the target definition in the configuration file, as seen in the [example configuration file](#configuration-file), or directly on the command line (when the single target is specified there).

The latter is done by adding these parameters at the end of the command, by placing ' -- ' after the last normal parameter. This is the standard way in Bash to mark the end of the command parameters. Everything behind that, will be pass as key-value pairs to the connector plugin.

For example:
```bash
$> raito <command> --connector raito-io/cli-plugin-snowflake --name snowflake1 --data-source-id <ds_id> -- --sf-account yyyyyy.eu-central-1 --sf-user <youruser> --sf-password <yourpassword>
```

## Examples

There are two options to specify targets:
- through a configuration file - *recommended* -, and
- as flags on the command line

### Configuration file
Specifying the targets in a configuration file, allows you to specify multiple targets.


An example *raito.yml* file: 
```yaml
# Parameters that can be configurated globally can go here:
domain: app
api-user: snowflake1
api-secret: <mysecret>

# The list of targets (data sources and/or identity stores) to handle in the CLI:
targets:
  - name: snowflake_global
    connector-name: raito-io/cli-plugin-snowflake
    connector-version: latest
    data-source-id: <ds_id> # fetch from Raito Cloud
    identity-store-id: <is_id> # fetch from Raito Cloud

    # The connector specific parameters
    sf-account: yyyyyy.eu-central-1
    sf-user: <youruser>
    sf-password: <yourpassword>

    # These allow you to skip certain actions during the 'run' command. These can also be specified globally.
    skip-data-source-sync: false
    skip-identity-store-sync: false
    skip-data-access-sync: false
    skip-data-usage-sync: false

...
```

When specifying multiple targets, it can be useful to only execute a subset of the targets for a specific run. To do this, simply specify the *only-targets* parameters as a comma-separated list of targets to run.

For example (with the above configuration file), to run the okta and snowflake targets alone (considering there are more in the configuration file):
```bash
$> raito <command> --only-targets snowflake_global
```

### Command-line
You can specify your target directly with the command-line arguments. This only allows you to specify one target. Connector-specific parameters
need to be included after a double dash.

For example:
```bash
$> raito <command> --connector-name raito-io/cli-plugin-snowflake --name snowflake_global --data-source-id xxxx -- --sf-account yyyyyy.eu-central-1 ...
```
