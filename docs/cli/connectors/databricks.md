---
title: Databricks
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /docs/cli/connectors/databricks
---

# Databricks

[Databricks](https://www.databricks.com/){:target=_blank} is a cloud-based data analytics platform that integrates data engineering, data science, and machine learning tools to enable seamless processing, analysis, and exploration of large datasets, offering services like Databricks Delta Lake and Databricks Runtime.

The connector is available [here](https://github.com/raito-io/cli-plugin-databricks){:target="_blank"} and supports
* Synchronizing databrick users to an identity store in Raito Cloud.
* Synchronizing Databricks Unity Catalog meta data (data structure, known permissions, ...) to a data source in Raito Cloud.
* Synchronizing Databricks Unity Catalog grants from an to Raito.
* Synchronize the data usage information to Raito Cloud.

## Prerequisites
### Authentication
For the Raito CLI to authenticate to the Databricks account valid user credentials are required. 
The associated user should be admin in the Databricks account and on all workspaces.
There are no required permissions within the Databricks Unity catalog.

## Databricks-specific CLI parameters

To see all parameters, type
```bash
$> raito info raito-io/cli-plugin-databricks
```
in a terminal window.

Currently, the following configuration parameters are available:
* **databricks-account-id** (mandatory): The ID of your Databricks account.
* **databricks-user** (mandatory): The email-address of the user that should be used within the plugin.
* **databricks-password:** (mandatory): The password of the user that should be used within the plugin. 