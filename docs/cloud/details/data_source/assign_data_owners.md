---
title: Data Owners
parent: Data Sources
grand_parent: Raito Cloud
nav_order: 30
has_children: false
permalink: /docs/cloud/datasources/owners
---

# Data Owners

A data owner of a data object, is the person responsible to manage access to the data. Raito allows multiple data owners for a single data object. Furthermore data ownership is propagated downwards in the data object tree. This means that whenever you own a schema, you also own all tables within that schema. Such propagated ownership is indicated as parent ownership in Raito. The default owner of a data source is the admin who has connected the data source. He obtains parent ownership on all data objects of the data source.

Ownership can be assigned at every level of the data object tree. As an admin or an owner of the object, you see three dots next to the data object name. This menu allows you to edit data owners. You can add or remove data owners. This also allows you to delegate your data ownership responsibilities.
