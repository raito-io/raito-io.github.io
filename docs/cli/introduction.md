---
title: Introduction
parent: Raito CLI
nav_order: 10
permalink: /docs/cli/intro
---
# Introduction
The Raito Command-Line Interface (CLI) has two main purposes:

1. To synchronize data between your data sources and identity stores, and Raito Cloud. For this, you can use the *run* command.
[![CLI GitOps Overview](/assets/images/raito-integration-overview.png)](/assets/images/raito-integration-overview.png){:target="_blank"}
Basically, the run command will execute a list of actions on each of the targets:
    1. Fetch all users and groups from the identity store (e.g. Okta, Active Directory, ...) or from the data source (which will also have accounts and possibly groups) and synchronize this with the matching identity store in Raito Cloud.<br>
    *Step 1 and 2 in the picture*<br><br>
    2. Fetch all the meta data from data source (which can be done through a data catalog) and update the appropriate data source in Raito Cloud.<br>
    *Step 3 and 4 in the picture*<br><br>
    3. Fetch the access controls defined in the data sources and push them to Raito Cloud. This will only look at the access controls that are not managed from within Raito Cloud (see next step). This way a full 360° of all access controls will be available in Raito Cloud from day one.<br>
    *Step 5 and 6 in the picture*<br><br>
    4. Get the *internal* access providers from Raito Cloud and update the access controls in the target data source accordingly.<br>
    *Step 7 and 8 in the picture*<br><br>
    5. Retrieve the data usage information from the data source and push it to Raito Cloud.<br>
    *Step 9 and 10 in the picture*<br><br>

1. For an access-as-code use case, the CLI can be used in continuous integration (CI) pipelines or manually to easily and immediately apply access controls to the target data source(s) right from your source code repository. It enables an easy to use access-as-code (GitOps) mechanism for (data) engineers to locally manage the access controls for the data objects. For this, you can use the *access* command.
[![CLI GitOps Overview](/assets/images/cli-gitops-overview.png)](/assets/images/cli-gitops-overview.png){:target="_blank"}

## Target
Targets are the different data sources and identity stores that the CLI will connect with. The logic to interact with the different types of targets is implemented in plugins (also called connectors).
 
See [Target Configuration](/docs/cli/configuration#targets) on how to specify and configure the targets in the CLI.

## Connector
A [connector](/docs/cli/connectors) is the part of the CLI that connects to a specific target.

For example, the [*Snowflake* connector](/docs/cli/connectors/snowflake) is used to connect to Snowflake targets.

Connectors are implemented as plugins for the CLI. A connector plugin is basically a small application, implementing a specific API to make sure the CLI can communicate with it to execute the necessary target-specific work (e.g. fetch the Snowflake meta data or push the access controls to Snowflake).