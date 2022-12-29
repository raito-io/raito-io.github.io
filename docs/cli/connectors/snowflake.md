---
title: Snowflake
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /docs/cli/connectors/snowflake
---

# Snowflake

[Snowflake](https://www.snowflake.com){:target="_blank"} is a cloud-based data warehouse that you can use without having to worry about infrastructure. Its data object hierarchy is 
`database` > `schema` > `table` > `column`. Additionally, you need access to a compute resource, or `warehouse`, to run queries. Snowflake uses role-based access controls.

The current connector supports
* Import and export of Snowflake roles
* Import into Raito Cloud of users
* Import into Raito Cloud of data objects
* Import into Raito Cloud of data usage information

The connector is available [here](https://github.com/raito-io/cli-plugin-snowflake){:target="_blank"}.

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
* **sf-excluded-databases** (optional): The optional comma-separated list of databases that should be skipped.
* **sf-excluded-schemas** (optional): The optional comma-separated list of schemas that should be skipped. This can either be in a specific database (as <database>.<schema>) or a just a schema name that should be skipped in all databases (e.g. `INFORMATION_SCHEMA`).
* **sf-external-identity-store-owners** (optional): The optional comma-separated list of owners of SCIM integrations with external identity stores (e.g. Okta or Active Directory). Roles which are imported from groups from these identity stores will be partially or fully locked in Raito to avoid a conflict with the SCIM integration.
* **sf-link-to-external-identity-store-groups** (optional): This boolean parameter can be set when the 'sf-external-identity-store-owners' parameter is set. When 'true', the 'who' of roles coming from the external access provider will refer to the group of the external access provider and the 'what' of the access provider will still be editable in Raito Cloud. When 'false' (default) the 'who' will contain the unpacked users of the group and the access provider in Raito Cloud will be locked entirely.
* **sf-standard-edition** (optional, `false` (default) or `true`): If set to `true`, Enterprise features will not be used. Relevant features to Raito that the Standard edition does not support are row access and masking policies, and tagging in the future. 
			