---
title: Raito Cloud
nav_order: 40
has_children: true
has_toc: false
permalink: /docs/cloud
---

# Raito Cloud

✅ Insights into existing data access and usage

✅ Request access to the data you require

✅ Manage access across all your data sources through collaboration

✅ Guidance towards data access management best-practices

[![Raito Overview](/assets/images/cloud/dashboard.png)](/assets/images/cloud/dashboard.png){:target="_blank"}


{% include cloud_navigation.html %}

## Why Raito Cloud?

Use Raito Cloud to scale data access management and enable true data ownership.

- Allow data consumers to seek for data they require and request access to it.
- Enable data owners to manage access to the data assets within their responsibility.
- Define and enforce central policies to ensure regulatory compliance
- Empower data owners and data governance specialists via insights in data access and data usage to increase data access maturity
- Provide consistent data access to your users across all data sources
- Automatically recommend actions to improve your data access maturity

## Core concepts

Raito uses a combination of common and custom terminology. The core concepts are explained by the following definitions, which are listed in a logical functional order:

- **Data source:** A data source is an instance of a data warehouse, database, reporting tool, …, or any other source of data in your analytical data landscape. Snowflake and BigQuery can be data sources in the Raito setting, your CRM or ERP application won’t be. You can have multiple data sources of the same type (e.g. multiple Snowflake accounts).
- **Data object**: Data objects represent all the data elements that can be found in a specific data source. A data object always belongs to a specific data source. Data objects are the entities of data you protect with Raito.
Data objects are organized in a hierarchy under its data source. For example, in a Snowflake data source, this hierarchy would look like this: *data source > database > schema > table > column*
- **Identity Store**: An identity store, literally represents a store of identities. It contains accounts and (optionally) groups.
Each data source have one **native** identity store linked to it, which cannot be changed or removed. This native identity store should contain all the user accounts that are known by the data source. It is synchronized by the CLI together with the data source.
Next to that, also external (standalone) identity stores can be imported (e.g. Okta, Active Directory, ...). These can provide additional information about the users. When such an external identity store is linked to a data source, the groups from that identity store can also be used when providing access to that data source.
An identity store can also me marked as **master** which indicates that this is the main identity store of your company. The groups in this identity store can be used everywhere.
- **Account**: An account is a representation of a user in a single Identity Store. A user can use his account of a Data Source to identify himself to that Data Source.
-  **User**: a user is a collection of accounts across multiple Data Sources or Identity Stores, typically belonging to a single physical person.
- **Access provider**: an access provider is what actually provides access to data objects for one or more defined users. As such it links users in a who-list to data objects in a what-list providing permissions per data object. These access providers are pushed towards the data sources and translated into what defines access in the data sources, e.g. roles, IAM policies, permissions, ...