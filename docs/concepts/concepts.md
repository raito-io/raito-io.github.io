---
title: Concepts
nav_order: 3
permalink: /concepts
---
# Concepts

### Raito Cloud
*Raito Cloud* refers to the Raito SaaS offering. It provides the full functionality that Raito has to offer to protect your data without slowing it down.

### Raito Graph
The *Raito Graph* is the graph structure that is built inside of Raito Cloud. It contains and interconnects the metadata of all data sources, the users and groups from the identity stores, the data policies, ...

### Raito CLI
The *Raito CLI* is the bridge between your infrastructure (data sources, identity stores, data catalog ...) and *Raito Cloud*. It can run safely on your own infrastructure to handle all the connections to your infrastructure in a secure way, without the need to have credentials to your data sources in *Raito Cloud*.

<!-- 
re-enable when it's available in the UI
### Tags
Meta data is highly important in Raito. Within *Raito Cloud* meta data is represented as tags. 

Tags can be specified on most elements in the *Raito Graph*. Tags will be inherited by other nodes in the graph where it makes sense. 
-->

### Data Source
A data source is an instance of a data warehouse, database, reporting tool ... or any other source of data. You can have muliple data sources of the same type (e.g: multiple Snowflake setups).

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

### User
Inside *Raito Cloud*, users under different identity stores are intelligently matched together to mark them as one physical person. <br>
For example: User 'm.scott' in Snowflake can be marked as the same person as 'michael.scott@dundermifflin.com'. This way, the meta data from one user is also available for the user.

<!-- 
TODO: re-enable when it's available in the UI
### Group
(User) Groups are imported as is into *Raito Cloud*, from the identity stores. Users will inherited the meta data from the groups they are in. 
-->

### Access Provider
An access provider describes which users have access to what with which permissions. Initially, when you ingest the access providers from your data warehouse, it will be 
very concrete, e.g. a role in Snowflake will map 1-to-1 to an access provider. But its goal is to represent information at a higher level than available in the data warehouses. 

#### Access

Access is a concrete instantiation that provides access to objects in a data warehouse. For instance, your role might promise you access to certain data sets. This is describes in an 
access provider, but it doesn't give you actual access. To get this access you need to create an access request; depending on your organization this might automatically grant you access since a corresponding access provider exists, but your access request might need some manual approvals as well.
