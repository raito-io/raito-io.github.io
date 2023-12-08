---
title: Synchronize
parent: Data Sources
grand_parent: Raito Cloud
nav_order: 20
has_children: false
permalink: /docs/cloud/datasources/sync
---

# Synchronizing a Data Source
In order to regularly refresh the data in Raito Cloud and to push the access control changes from Raito Cloud to your data warehouses, your data sources need to be synchronized. There are multiple possibilities to do this:

- When you run the CLI on your own infrastructure:
  - Typically, the CLI is set up to run on a fixed schedule (typically once per day). At this time, it will do a full synchronization (unless configured differently). More information can be found on this in the [CLI documentation](/docs/cli).
  - You could also simply manually trigger a single synchronization run using the CLI.
  - If the CLI runs in continuous mode (using a CRON schedule), you can also choose to trigger the CLI from the UI for a additional synchronization. This can either be a full synchronization of just one of the tasks. This can be done (as a data source owner) on the data source page, by clicking on the three dots on the top right and choosing 'Synchronize'. Here you can select which parts of the synchronization you want to do.
  This can, for example, be used to quickly fetch some new tables in a schema that were just created so that you can start providing access to them immediately.
- If you chose to run the CLI in the cloud environment (only available in limited cases), you can manually trigger a synchronization by clicking on the three dots on the top right and choose 'Synchronize'. In this case, you will need to re-enter the sensitive information to connect to your data source, because these were not stored for safety reasons. Currently, only full synchronizations can be triggered in this scenario.
