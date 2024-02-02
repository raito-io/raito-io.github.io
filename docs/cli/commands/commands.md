---
title: Commands
parent: Raito CLI
has_children: false
nav_order: 25
permalink: /docs/cli/commands
---

# Commands
As described in the [introduction](/docs/cli/intro), the Raito CLI provides different commands to serve different use cases.

## Run
The **run** command is used to do a full synchronization between your data warehouse(s) and Raito Cloud as shown on the [Introduction page](/docs/cli/intro). 

The **run** command can be configured to either run just one full sync and exit immediately after or to keep running and repeat a full sync regularly. In the latter case, the CLI will, between full syncs, also listen continuously for changes to access controls in Raito Cloud and update them in the data warehouse(s). This allows changes to access controls to be applied within seconds.

A guide on how to use this command in combination with Raito Cloud can be found [here](/docs/guide/cloud), and specific configuration for this command can be found [here](/docs/cli/configuration#run)

The get more information in a terminal window:
```bash
$> raito run --help
```

## Help
Can be used like this
```bash
$> raito run --help
```
or
```bash
raito help run
```

## Info
This command let's you retrieve information that is provided by a connector. 

For example, to get more information about the Snowflake connector you can run
```bash
$> raito info raito-io/cli-plugin-snowflake
```