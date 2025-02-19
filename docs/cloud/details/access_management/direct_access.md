---
title: Direct Access
parent: Access Management
grand_parent: Raito Cloud
nav_order: 11
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/direct_access
---

# Direct Access
{: .note }
This feature may not be available in your environment. Please contact sales.

Some data sources don't implement RBAC (role-based access controls), but instead directly assign permissions to users on resources. Google BigQuery and Databricks are examples of such data sources.

Moving to a role-based system (like the [grants](/docs/cloud/access_management/grants) in Raito) can then often be a big step to manage access.

This is where the `Direct Access` feature comes in.

Direct Access allows you to assign permissions on Data Objects directly to a user or a group. To do this, the system will automatically create Grants in a new Grant Category, called `Direct Access`. A grant will be created for each user and group when you first assign direct access to them.  
This Grant Category is managed by the system and so cannot be updated or removed. Grants in this category will also be fully managed by the system and so you cannot create or delete Grants in this category yourself.

{: .note }
Direct Access can only be given on Data Objects which are part of a Data Source that supports it (like BigQuery and Databricks).

## Adding Direct Access
To assign permissions on a Data Object to a user or group, navigate to the page of the Data Object you want to provide access to and click on the `Access` tab there. If the data object supports it, the `Add Access` button will be available.  
When you click this, you will be guided through the following steps:
1. First, you will be able to pick the users and groups you want to provide the access to.
2. After that, you can pick the permissions you want to provide on this Data Objects.
3. As the last step, you will get an overview and have the ability to set a validity date to automatically remove the access again after a certain date.

## Removing or Editing Direct Access
Removing or editing Direct Access can be done from multiple locations:
1. You can navigate to the Data Object page and go to the `Access` tab. All users with access (either Direct or through normal Grants) will be shown there. For the ones with Direct Access, you hover over the row, click the three dots to open the context menu and choose to `Edit permissions`, `Edit end date` or `Revoke access`.
2. You can also navigate to the Direct Access grant of the user or group and edit or remove Data Objects from there. 