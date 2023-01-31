---
title: Commands
parent: Raito CLI
has_children: false
nav_order: 25
permalink: /docs/cli/commands
---

# Commands

There are two main operation modes for the CLI using 
- [the **access** command](#access) is used to implement the access-as-code use case. 
- [the **run** command](#run) will do a full synchronization between your data warehouse(s) and Raito Cloud.

Other commands are
- [the **help** command](#help). Get more information about any other command.
- [the **info** command](#info). Get more information about a connector. 

## Access 
The **access** command can be used to implement an access-as-code workflow. It will read access controls from a YAML file and configure these in your data warehouse(s). This command is typically used in a CI/CD workflow.

A full step-by-step guide on how to use this command can be found [here](/docs/guide/access). Specific configuration for this command can be found [here](/docs/cli/configuration#access)

To get more information in a terminal window:
```bash
$> raito access --help
```

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