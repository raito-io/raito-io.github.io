---
parent: Overview
title: Concepts
nav_order: 10
permalink: /docs/overview/concepts
---

# Concepts

### Raito Cloud
*Raito Cloud* refers to the Raito SaaS offering. It provides the full functionality that Raito has to offer to protect your data without slowing it down.

### Raito CLI
The *Raito CLI* is the bridge between your infrastructure (data sources, identity stores, data catalog ...) and *Raito Cloud*. It can run safely on your own infrastructure to handle all the connections to your infrastructure in a secure way, without the need to have credentials to your data sources in *Raito Cloud*.

Alternatively, there is an option to run the CLI from within Raito Cloud. This is a good option to get started with Raito quickly, but not recommended for production environments.

<!-- 
re-enable when it's available in the UI
### Tags
Meta data is highly important in Raito. Within *Raito Cloud* metadata is represented as tags. 

Tags can be specified on most elements in the *Raito Graph*. Tags will be inherited by other nodes in the graph where it makes sense. 
-->

### Data Source
A data source is an instance of a data warehouse, database, reporting tool, …, or any other source of data in your data landscape. Some examples are, Snowflake and BigQuery. You can have multiple data sources of the same type (e.g. multiple Snowflake accounts).

### Data Objects
Data objects represent all the data elements that can be found in a specific data source. A data object always belongs to a specific data source.

Data objects are organized in a hierarchy under its data source. Each data source has its own set of data object types, which are defined by the CLI connector. Each data object type also contains the necessary information for Raito to understand its capabilities (e.g. the permissions that are applicable to that data object type).<br>
For example, for a Snowflake data source, the hierarchy of data objects would look like this: *data source > database > schema > table > column*

### Identity Store
An identity store, literally represents a store of identities. It contains accounts and (optionally) groups.<br>
Each data source has one *native* identity store linked to it, which cannot be changed or removed. This native identity store should contain all the user accounts that are known by the data source. It is synchronized by the CLI together with the data source.

Next to that, also external (standalone) identity stores can be imported (e.g. Okta, Active Directory, ...). These can provide additional information about the users. When such an external identity store is linked to a data source, the groups from that identity store can also be used when providing access to that data source.

An identity store can also be marked as *master* which indicates that this is the main identity store of your company. The groups in this identity store can be used everywhere.

### Account
An account is a representation of a user in a single Identity Store.

### User
A user is a collection of accounts across multiple Identity Stores, typically belonging to a single (physical) person or service.

When new accounts are imported (when the identity store is synced by the Raito CLI) these accounts are automatically attached under an existing user when the email address matches or to a new user when no user was found with that email address. 

An account can be transfered to another or new user manually if needed.

### Group
A group is a group of accounts as defined in the identity stores.

### Access Provider
Access Provider is the main concept used within Raito to describe access controls.

When a data source is synced with Raito Cloud using the Raito CLI, the access controls in the data source are mapped to access providers. For example, for every role in Snowflake, an access provider is created in Raito Cloud. These imported access providers are marked as *external* to indicate that they are managed in the data source itself (and not by Raito Cloud).

Next to that, new *internal* access providers can be defined within Raito Cloud or existing *external* access providers can be converted to *internal*. These *internal* access providers are then converted into access controls in the data source during a sync with the Raito CLI. 

For example, an *internal* access provider in Raito would translate to a role in Snowflake. If the role already exists, it gets updated, otherwise a new role is created.

### Raito Graph 
The *Raito Graph* is the graph structure that is built inside of Raito Cloud. It contains and interconnects the metadata of all data sources, the users and groups from the identity stores, the access controls, data usage, ... This graph allows us to extract knowlegde and actionable insights out of all the metadata supplied. 