---
title: Access Control Owners
parent: Access Management
grand_parent: Raito Cloud
nav_order: 70
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/owners
---

# Access Control Owners

Just like data objects, also access controls need to have at least one owner assigned. 
When a data source is first synchronized, the ownership of the access controls that are imported from the data sources is assigned to the owner of the [data source](/docs/cloud/datasources/owners).
For newly created access controls, the creator of the access control becomes its initial owner.

An access owner acts as a delegate for a data owner to manage the who-list of his access control. It remains the responsibility of the data owner to link his data objects to the what-list of such an access control. This brings a separation of concern where a data object owner only needs to determine which access controls can access the data object and where the access control owner determines who can access the collection of data objects in his access control.