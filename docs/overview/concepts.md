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

<!-- 
re-enable when it's available in the UI
### Tags
Meta data is highly important in Raito. Within *Raito Cloud* meta data is represented as tags. 

Tags can be specified on most elements in the *Raito Graph*. Tags will be inherited by other nodes in the graph where it makes sense. 
-->

### Data Source
A data source is an instance of a data warehouse, database, reporting tool, ..., or any other source of data. You can have muliple data sources of the same type (e.g: multiple Snowflake setups).

Every data source is also represented by a node in the *Raito Graph*.

### Data Objects
Data objects represent all the data elements that can be found in a specific data source. A data object always belongs to a specific data source.

Data objects are organized in a hierarchy under its data source.<br>
For example, for a Snowflake data source, this hierarchy would look like this: *data source > database > schema > table > column*

### Identity Store
An identity store, literally represents a store of identities. It contains users and (optionally) groups that are recognized by the organization as valid users.<br>
An identity store can be either an external identity provider (e.g. Okta, Active Directory, ...) or a data source that contains users and groups itself. It can also be an HR tool (e.g. Workday), which typically contain more meta data about the users, which can be useful to define data policies with.

Every data source should have 1 or more identity stores configured in *Raito Cloud*, indicating that this data source contains users from these identity stores.<br>
Typically, this is the data source itself (for internal users) and/or an external identity provider (e.g. Okta, Active Directory, ...)

<!-- 
TODO: re-enable when it's available in the UI
### User 
TODO: update to current state<br>
Inside *Raito Cloud*, users under different identity stores are intelligently matched together to mark them as one physical person. <br>
For example: User 'm.scott' in Snowflake can be marked as the same person as 'michael.scott@dundermifflin.com'. This way, the meta data from one user is also available for the user.
-->

<!-- 
TODO: re-enable when it's available in the UI
### Group
(User) Groups are imported as is into *Raito Cloud*, from the identity stores. Users will inherited the meta data from the groups they are in. 
-->

### Access Provider
Access Provider is the main concept used within Raito to describe access controls. There is different flavors of access providers, which will be covered later.

When a data source is synced with Raito Cloud using the Raito CLI, the access controls in the data source are mapped to access providers. For example, for every role in Snowflake, an access provider is created in Raito Cloud. These imported access providers are marked as *external* to indicate that they are managed in the data source itself (and not by Raito Cloud).

Next to that, also *internal* access providers can be defined within Raito Cloud. These are then converted into access controls in the data source during a sync with the Raito CLI. For example, for these *internal* access providers a role (or multiple) is created in Snowflake.

<!-- 
TODO: We currently only support a small subset of what is possible later.
Talk about access providers that cover multiple data sources. Also cover static vs dynamic (ABAC), ...
We probably best have a separate page to go deeper into access providers.
-->

#### Access

An Access Provider will have 1 or more Access elements. An access element describes *who* has access to *what*.
Currently, access providers will only have 1 access element. However, in the future we will support access providers with multiple access elements to cover multiple data sources and provide more flexibility.

<!-- 
TODO: Update the above when we change this
-->

### Raito Graph 
The *Raito Graph* is the graph structure that is built inside of Raito Cloud. It contains and interconnects the metadata of all data sources, the users and groups from the identity stores, the data policies, ...