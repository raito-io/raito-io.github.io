---
title: Commands
parent: Raito CLI
has_children: false
nav_order: 25
permalink: /docs/cli/commands
---

# Commands

There are two main operation modes for the CLI using 
- [the **access** command](#access). Push access controls to your data warehouses using (versioned) yaml files.
- [the **run** command](#run). Export information from your data warehouse into Raito Cloud and push access controls from Raito Cloud to your data warehouse.

Other commands are
- [the **help** command](#help). Get more information about any other command.
- [the **info** command](#info). Get more information about a connector. 

## Access 

A guide on usage is [here](/docs/guide/access), and specific configuration for this command can be found [here](/docs/cli/configuration#access)

To get more information in a terminal window:
```bash
$> raito access --help
```

## Run

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

[TODO: double check]

For example
```bash
$> raito info raito-io/cli-plugin-snowflake latest
```