---
title: Assign data owners
parent: Raito Cloud
nav_order: 40
has_children: false
has_toc: false
permalink: /docs/cloud/assign_data_owners
---

# Assign data & access owners

## Data owners

A data owner of a data object, is the person responsible to manage access to the data. Raito allows multiple data owners for a single data object. Furthermore data ownership is propagated downwards in the data object tree. This means that whenever you own a schema, you also own all tables within that schema. Such propagated ownership is indicated as parent ownership in Raito. The default owner of a data source is the admin who has connected the data source. He obtains parent ownership on all data objects of the data source.

Ownership can be assigned at every level of the data object tree. As an admin, an access manager, or an owner of the object, you see three dots next to the data object name. This menu allows you to edit data owners. You can add or remove data owners. This also allows you to delegate your data ownership responsibilities, yet on your return, you should retract the ownership manually.

## Access owners

Next to data objects, also access controls require an owner. Just like data objects, the admin who has connected a data source becomes the default owner of all access controls present in the data source. For newly created access controls, the creator of the access control becomes its first owner.

An access owners acts as a delegate for a data owner to manage the who-list of his access control. It remains the responsiblity of the data owner to link his data objects to the what-list of such an access control. This brings a separation of concern where a data object owner only needs to determine which access controls can access his data object and where the access control owner determines who can access the collection of data objects in his access control.
