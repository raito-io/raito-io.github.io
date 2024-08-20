---
title: Snowflake
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /docs/cli/connectors/snowflake
---

# Snowflake

[Snowflake](https://www.snowflake.com){:target="_blank"} is a cloud-based data warehouse that you can use without having to worry about infrastructure. 
Using the Raito CLI Snowflake Connector you can easily enable data access management for Snowflake.

The connector supports
* Import of existing Snowflake roles into Raito Cloud
* Import of Snowflake users into Raito Cloud
* Import into Raito Cloud of data objects
* Import into Raito Cloud of data usage information
* Updating Snowflake roles as defined in Raito Cloud or using access-as-code

The connector is available [here](https://github.com/raito-io/cli-plugin-snowflake){:target="_blank"}.

## Prerequisites
The Snowflake connector requires the credentials to a user in your Snowflake account with the necessary permissions to execute the queries needed to perform its task.
The Snowflake connector will sign in using the credentials you provide and assume a Snowflake Role. By default, the `ACCOUNTADMIN` role is used, however it is highly recommended to define a custom role to use for this purpose. The `sf-role` parameter can be used to specify the role to use.

The table below describes the permissions that are required by this role.

| Permission  | Object  | Purpose  |
|---|---|---|
| IMPORTED PRIVILEGES  | SNOWFLAKE database  | To get usage data  |
| CREATE ROLE  | ACCOUNT  | To create new roles in Snowflake  |
| MANAGE GRANTS  | ACCOUNT  | To configure the roles in Snowflake  |
| APPLY MASKING POLICY  | ACCOUNT  | To read and apply column masking policies + to provide the permissions to fetch database, schema and table metadata  |
| APPLY ROW ACCESS POLICY  | ACCOUNT  | To read and apply row-level security policies + to provide the permissions to fetch database, schema and table metadata  |
| USAGE  | Warehouse  | To run queries for fetching all the metadata. This permission should be set on the default warehouse for this user  |

A step-by-step guide on how to create the role and user can be found in the [Snowflake guide](/docs/guide/cloud).

## Snowflake-specific CLI parameters

To see all parameters, type 
```bash
$> raito info raito-io/cli-plugin-snowflake
```
in a terminal window.

Currently, the following configuration parameters are available:
* **sf-account** (mandatory): The account name of the Snowflake account to connect to. See the [Snowflake documentation](https://docs.snowflake.com/en/user-guide/admin-account-identifier) on how to get this identifier. Typically this is in the form `<org-name>-<account-name>`.
* **sf-user** (mandatory): The username to authenticate against the Snowflake account.
* **sf-password**: The password to authenticate against the Snowflake account. Either this or sf-private-key must be specified.
* **sf-private-key**: The path of the file containing the private key to authenticate against the Snowflake account. Either this or sf-password must be specified.
* **sf-role** (optional): The name of the role to use for executing the necessary queries. If not specified, `ACCOUNTADMIN` is used.
* **sf-excluded-databases** (optional): The optional comma-separated list of databases that should be skipped.
* **sf-excluded-schemas** (optional): The optional comma-separated list of schemas that should be skipped. This can either be in a specific database (as  \<database \>. \<schema \>) or just a schema name that should be skipped in all databases (e.g. `INFORMATION_SCHEMA`).
* **sf-external-identity-store-owners** (optional): The optional comma-separated list of owners of SCIM integrations with external identity stores (e.g. Okta or Microsoft Entra ID). Roles which are imported from groups from these identity stores will be partially or fully locked in Raito to avoid a conflict with the SCIM integration.
* **sf-link-to-external-identity-store-groups** (optional): This boolean parameter can be set when the 'sf-external-identity-store-owners' parameter is set. When 'true', the 'who' of roles coming from the external access provider will refer to the group of the external access control and the 'what' of the access control will still be editable in Raito Cloud. When 'false' (default) the 'who' will contain the unpacked users of the group and the access control in Raito Cloud will be locked entirely.
* **sf-standard-edition** (optional, `false` (default) or `true`): If set to `true`, Enterprise features will not be used. Relevant features to Raito that the Standard edition does not support are row access and masking policies, and tagging in the future. 
			
