---
title: Data sources
parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/connect_datasource
---

# Data Sources

The starting point for setting up Raito, is to configure one or more data sources (e.g. Snowflake, BigQuery or S3).

In setting up a data source, you provide details such as database access credentials and details about the type of and frequency of a synchronization. These details are listed in a YAML file and managed in the Raito CLI. Initiating setting up a data source however happens in Raito cloud.

## Setting up a new Data Source

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

A full guide on how to fully setup your first data source can be found in our [Guides](/docs/guide).

Once your data source is connected and a first synchronization ran successfully, you’ll be able to start exploring the current state of your access controls and [usage](/docs/cloud/usage_observability).
<!-- TODO: add link to access controls when available -->

## Synchronizing a Data Source
In order to regularly refresh the data in Raito Cloud and to push the access control changes from Raito Cloud to your data warehouses, your data sources need to be synchronized. There are multiple possibilities to do this:

- When you run the CLI on your own infrastructure:
  - Typically, the CLI is set up to run on a fixed schedule (typically once per day). At this time, it will do a full synchronization (unless configured differently). More information can be found on this in the [CLI documentation](/docs/cli).
  - You could also simply manually trigger a single synchronization run using the CLI.
  - If the CLI runs in continuous mode (using a CRON schedule), you can also choose to trigger the CLI from the UI for a additional synchronization. This can either be a full synchronization of just one of the tasks. This can be done (as a data source owner) on the data source page, by clicking on the three dots on the top right and choosing 'Synchronize'. Here you can select which parts of the synchronization you want to do.
  This can, for example, be used to quickly fetch some new tables in a schema that were just created so that you can start providing access to them immediately.
- If you chose to run the CLI in the cloud environment (only available in limited cases), you can manually trigger a synchronization by clicking on the three dots on the top right and choose 'Synchronize'. In this case, you will need to re-enter the sensitive information to connect to your data source, because these were not stored for safety reasons. Only full syncs can be triggered in this case at the moment.
