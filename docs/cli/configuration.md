---
title: Configuration
parent: Raito CLI
nav_order: 30
permalink: /docs/cli/configuration
---

# Configuration

## Introduction
Configuration parameters can be passed into the CLI in two different ways:  

1. **File**: you can specify the configuration parameters in a YAML file. By default, *raito.yml* or *raito.yaml* (in the working directory or '~/.raito') is used.<br>
The configuration file allows you to specify multiple targets instead of only 1 (see later). Environment variables can be used in the configuration file by using double curly brackets, e.g. {% raw %} `sf-password: "{{SNOWFLAKE_PASSWORD}}"` {% endraw %}<br>
The file to use, can be specified using the *config-file* flag.<br> 
For example:
{% raw %}
```bash
$> raito <command> --config-file myconfig.yaml
```
{% endraw %}

1. **Flags**: you can use the command line flags directly on the CLI to pass in configuration parameters.<br>
Note: this limits you to only one target (see later).

The recommended way is to use the configuration file, whereas configuration flags are convenient for development and testing. The different parameters can be divided into the following categories:
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

- **cron**: If set, the cron expression will define when a sync should run. When not set (and no frequency is defined), the sync will run once and quit after. (e.g. '0 0/2 * * *' initiates a sync evey 2 hours) \
  Examples of cron expressions are: `* 0/2 * * *`: sync every 2 hours; `0 6 * * *`: sync every day at 06:00; `5 4 * * sun`: sync each Sunday at 04:05
- **sync-at-startup**: If set, a sync will be run at startup independent of the cron expression. Only applicable if cron expression is defined.
- **frequency**: The frequency used to do the sync (in minutes). When not set (and no cron expression is defined), the default value '0' is used, which means the sync will run once and quit after.
- **skip-data-access-sync**: If set, the data access information from Raito Cloud will not be synced to the data sources in the target list, and no data access information will be sent to Raito Cloud.
- **skip-data-source-sync**: If set, the data source metadata synchronization step to Raito Cloud will be skipped for each of the targets.
- **skip-data-usage-sync**: If set, the data usage information synchronization step to Raito Cloud  will be skipped for each of the targets.
- **skip-identity-store-sync**: If set, the identity store synchronization step to Raito Cloud will be skipped for each of the targets.
- **disable-websocket**: When the frequency parameter is defined, by default, the CLI will set up a websocket connection to Raito Cloud to continuously listen to changes to access controls to be able to apply them within seconds. If this flag is set, the websocket connection will not be created and only the full syncs will run regularly. This flag has only effect if **frequency** is set.
- **only-targets** *(optional)*: comma-separated list of targets that need to be run. If left empty, all targets will be run. 

Locking parameters can be used to lock certain parts of an access provider, which means that this part of the access provider will always be managed from within the data source. Concretely, this means that this part will not be editable in the Raito Cloud UI and that this part of the access provider will never be pushed back to the data source, but still imported from the data source during a sync, even if the access provider has been internalized in Raito Cloud.  
Note that this only makes sense for access providers that represent a named entity (like a Snowflake Role or AWS Policy).  
The following options are available to lock a specific part of all the imported access controls: 

- **lock-all-who**: If set to true, the 'who' (users and groups) of all access providers imported into Raito Cloud will be locked.
- **lock-who-by-name**: Allows you to specify a comma-separated list of access provider names for which the 'who' (users and groups) should be locked when imported into Raito Cloud. The names in the list are interpreted as regular expressions which allows for partial matches (e.g. '.+-prod,.+-dev' will match all access providers ending with '-prod' or '-dev').
- **lock-who-by-tag**: Allows you to specify a comma-separated list of access provider tags for which the 'who' (users and groups) should be locked when imported into Raito Cloud. The tags in the list are interpreted as regular expressions which allows for partial matches. The format for an item should be in the form 'key:value' (e.g. 'key1:value1,key2:.+' will match all access providers that have the tag 'key1:value1' or have the tag with key 'key2'). 
- **lock-who-when-incomplete**: If set to true, the 'who' (users and groups) of all access providers imported into Raito Cloud will be locked if the access provider is incomplete (not all elements could be understood by Raito). This can be used to protect accidental removal of permissions unknown to Raito by blocking the possibility to edit it. 
- **lock-all-inheritance**: Same as `lock-all-who`, but for the 'inheritance' of the access providers.
- **lock-inheritance-by-name**: Same as `lock-who-by-name`, but for the 'inheritance' of the access providers.
- **lock-inheritance-by-tag**: Same as `lock-who-by-tag`, but for the 'inheritance' of the access providers.
- **lock-inheritance-when-incomplete**: Same as `lock-who-when-incomplete`, but for the 'inheritance' of the access providers.
- **lock-all-what**: Same as `lock-all-who`, but for the 'what' of the access providers.
- **lock-what-by-name**: Same as `lock-who-by-name`, but for the 'what' of the access providers.
- **lock-what-by-tag**: Same as `lock-who-by-tag`, but for the 'what' of the access providers.
- **lock-what-when-incomplete**: Same as `lock-who-when-incomplete`, but for the 'what' of the access providers.
- **lock-all-names**: Same as `lock-all-who`, but for the name of the access providers.
- **lock-names-by-name**: Same as `lock-who-by-name`, but for the name of the access providers.
- **lock-names-by-tag**: Same as `lock-who-by-tag`, but for the name of the access providers.
- **lock-names-when-incomplete**: Same as `lock-who-when-incomplete`, but for the name of the access providers.
- **lock-all-delete**: Same as `lock-all-who`, but for deleting the access providers.
- **lock-delete-by-name**: Same as `lock-who-by-name`, but for deleting the access providers.
- **lock-delete-by-tag**: Same as `lock-who-by-tag`, but for deleting the access providers.
- **lock-delete-when-incomplete**: Same as `lock-who-when-incomplete`, but for deleting the access providers.
- **fully-lock-all**: Same as `lock-all-who`, but this will fully lock the access providers from being edited in Raito Cloud.
- **fully-lock-by-name**: Same as `lock-who-by-name`, but this will fully lock the access providers from being edited in Raito Cloud.
- **fully-lock-by-tag**: Same as `lock-who-by-tag`, but this will fully lock the access providers from being edited in Raito Cloud.
- **fully-lock-when-incomplete**: Same as `lock-who-when-incomplete`, but this will fully lock the access providers from being edited in Raito Cloud.

Tags which are read from the data source by the connector can be used to set specific properties of access providers and data objects during import. Note that not all data sources support tags on access providers and/or data objects. The following parameters are available:
- **tag-overwrite-key-for-access-provider-name**: If set, this will determine the tag-key used for overwriting the display-name of the access provider when imported in Raito Cloud. The display-name should be defined in the value of the tag. When no tag with this key is found on the access provider, the default behavior is used.
- **tag-overwrite-key-for-access-provider-owners**: If set, will determine the tag-key used for assigning owners of the access provider when imported in to Raito Cloud. The owners are then found in the value of the tag. This value should be a comma-separated list of account names (e.g. 'accountName1,accountName2') or emails prefixed with 'email:' (e.g. 'email:test@company.com,email:test2@company.com').  
- **tag-overwrite-key-for-data-object-owners**: If set, will determine the tag-key used for assigning owners of the Data Objects when imported in to Raito Cloud. The owners are then found in the value of the tag and should be formatted in the same way as described in the `tag-overwrite-key-for-access-provider-owners` parameter.
- **tag-key-and-value-for-user-is-machine**: If set, a user will be flagged as machine user when the given key:value combination is found on the user object. For example, set the value of this configuration option to 'user-type:machine' and make sure that all your machine users are tagged with key 'user-type' and value 'machine'.

Files that are generated (either by the CLI or by Raito Cloud) are deleted by default when they are not needed anymore by the process. This behavior can be manipulated with the following parameters. These can be either defined on the top-level of the configuration file or under each target separately:
- **delete-temp-files**: By default, this is 'true'. When set to 'false', the temporary files will not be deleted after a synchronization run. This can be used for debugging reasons.
- **file-backup-location**: This parameter can be used to specify a path to store backups of the temporary files that are generated during a synchronization run. A sub-folder is created per target, using the target name + the type of run (full, manual or webhook) as name for the folder. Underneath that, another sub-folder is created per run, using a timestamp as the folder name. The backed up files are then stored in that folder. Check out the [apply-access command](/docs/cli/commands#apply-access) on how this could be used in a disaster recovery scenario.
- **maximum-backups-per-target**: When the `file-backup-location` parameter is defined, this parameter can be used to control how many backups should be kept per target+type. When this number is exceeded, older backups will be removed automatically. By default, this is 0, which means there is no maximum.

## Raito parameters
To connect the CLI to your Raito instance, you'll also need to specify the following parameters, globally or in the configuration file under the specific target section:

 - **domain** *(optional)*: The sub-domain of your Raito instance (e.g. https://*domain*.raito.io).
 - **api-user** *(optional)*: The user name of the API user to use to connect to your Raito instance.
 Note: this users needs to have the necessary permissions on the data source or identity store it needs to interact with.
 - **api-secret** *(optional)*: The secret API token for the API user to authenticate against Raito.


## Target parameters

The Raito CLI works against one or more [targets](/docs/cli/intro#targets). A target is a system or server like a data warehouse, identity store, etc.

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

The latter is done by adding these parameters at the end of the command, by placing ' -- ' after the last normal parameter. This is the standard way in Bash to mark the end of the command parameters. Everything behind that, will be passed as key-value pairs to the connector plugin.

For example:
```bash
$> raito <command> --connector raito-io/cli-plugin-snowflake --name snowflake1 --data-source-id <ds_id> -- --sf-account yyyyyy.eu-central-1 --sf-user <youruser> --sf-password <yourpassword>
```

## Config reloading
When using the `run` command, the Raito CLI will reload configuration parameters from the configuration file before each sync. 

This functionality is mainly meant for changing individual parameters (e.g. the password to connect to Raito or to your data source to allow password rotation).  
It is recommended to restart the CLI when you do larger changes to the configuration (like adding/removing targets).

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
    data-source-id: "<data-source-id>" # fetch from Raito Cloud
    identity-store-id: "<identity-store-id>" # fetch from Raito Cloud

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
