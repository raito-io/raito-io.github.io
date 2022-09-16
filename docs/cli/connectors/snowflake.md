---
title: Snowflake
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /cli/connectors/snowflake
---

# Snowflake connector

[Snowflake](https://www.snowflake.com){:target="_blank"} is a cloud-based data warehouse that you can use without having to worry about infrastructure. Its data object hierarchy is 
`database` > `schema` > `table` > `column`. Additionally, you need access to a compute resource, or `warehouse`, to run queries. Snowflake uses role-based access controls.

The current connector supports
* Import and export of Snowflake roles
* Export of users
* Export of data objects
* Export of data usage information

## Snowflake-specific parameters

To see all parameters, type 
```bash
$> raito info raito-io/cli-plugin-snowflake
```
in a terminal window.

Currently, the following configuration parameters are available:
* **sf-account** (mandatory): The account name of the Snowflake account to connect to. For example, xy123456.eu-central-1
* **sf-user** (mandatory): The username to authenticate against the Snowflake account.
* **sf-password** (mandatory): The username to authenticate against the Snowflake account.
* **sf-role** (optional): The name of the role to use for executing the necessary queries. If not specified 'ACCOUNTADMIN' is used.
* **sf-database** (mandatory): The name of the main database to connect to. This is necessary for building the connection string.
* **sf-excluded-databases** (optional): The optional comma-separated list of databases that should be skipped.
* **sf-excluded-schemas** (optional): The optional comma-separated list of schemas that should be skipped. This can either be in a specific database (as <database>.<schema>) or a just a schema name that should be skipped in all databases (e.g. `INFORMATION_SCHEMA`).
* **sf-excluded-owners** (optional): The optional comma-separated list of owners that need to be skipped when syncing users or marked as read-only when importing roles as Access Providers. This is typically used to not synchronize the users that were imported from an external Identity Store (like Okta, Active Directory, ...).
			