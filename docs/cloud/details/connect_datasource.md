---
title: Connect a data source
parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/connect_datasource
---

# Connect a data source

To manage access in a data source such as Snowflake, BigQuery or S3, it first needs to be connected.

In setting up a data source, you provide details such as database access credentials and details about the type of and frequency of a synchronization. These details are listed in a YAML file and managed in the Raito CLI. Initiating setting up a data source however happens in Raito cloud.

## Add a new data source in Raito Cloud

![Data Source overview](/assets/images/cloud/ds_overview_add.png)

{: .info }
> ℹ️ To add a data source, you will need the Admin role in Raito. See [Raito user management](/docs/cloud/user_management) for more information on roles in Raito.

To add a new data source in Raito Cloud, take the following steps:

- In the sidebar navigation menu, open up the `Data sources` panel and click the `All data sources` menu item.
- Now click the `Add data source` button on the top right.
- Select the type of data source you would like to add.
Note: This choice is purely meant to guide you through setting up this specific data source type. If your data source type is not in the list (for example, when you built your own Raito CLI plugin), you can pick any type to continue.
- Provide a name for your data source. This name will be the display name for this data source within Raito Cloud and will be visible to all the users in the system.
- Next, provide an optional description for your data source to describe in more detail what this data source contains and what it is meant for.
- Select your connection method by choosing between a Raito managed CLI (Quick start) or self-managed CLI, which is recommended. Note: This option is not available for all data source types.
- When done, you will land on the initial page of your data source. Because it hasn’t been connected to the actual data source yet, instructions will be shown on how to proceed.

![Data Source details](/assets/images/cloud/ds_config.png)

Once your data source is connected and a first synchronization ran successfully, you’ll be able to start exploring the current state of your access controls and [usage](/docs/cloud/usage_observability).
<!-- TODO: add link to access controls when available -->

## Add a new identity store in Raito Cloud

Setting up a new identity store in Raito Cloud is similar to setting up a new data source. The entry point can be found by admins under Identities and Identity Stores in the main navigation. The only difference with the flow to connect a data source, is that we currently do not support the cloud CLI to connect an Identity Store.
