---
title: Grants
parent: Access Management
grand_parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/grants
---

# Grants
A Grant provides access to specific data objects in one or more data sources.

The what-links also define the permissions that the grant provides to the users.

When defining the who-links, you have the option to immediately grant the access or to pre-approve the access, which mean that the access will automatically be granted when the user creates an Access Request for this Grant Access Control.

[![Grants](/assets/images/Grants.jpg)](/assets/images/Grants.jpg){:target="_blank"}

The category of the grant will determine which options are available to configure the grant. 

## Permissions
When adding a data object in the what-list of a grant, you also have to specify which permissions you want to grant on this data object.

The available permissions are determined by the type of data object and the data source that the data object is in. For example: on a Snowflake table, permissions like `SELECT`, `INSERT`, ... will be available.  
Data objects on a higher level will also show the permissions that are available on all its descendants. For example: on a Snowflake schema, you will also see the `SELECT` permission, which means that the `SELECT` permission will be applied on all tables and views in that schema.

On top of these, 3 additional permissions are always available to provide a high-level abstraction on top of the data source specific permissions: `Read`, `Write` and `Admin`.  
These global permissions will be unpacked to data source specific permissions when the access control is synced to the data source.  
For example: on a Snowflake table, the `Read` permission will translate into the `SELECT` permission, while the `Write` permission is unpacked to the `INSERT`, `UPDATE`, `DELETE` and `TRUNCATE` permissions. This mapping is determined by the CLI connector plugin.

## Creating a Grant

To create a new grant, navigate to `Access > Grants > All grants` (or any of the grant categories) and click `Create grant` in the top right corner of the page.

{: .info }
> ℹ️ To create a new grant, you need be at least owner of one or more data objects or have the global `Access Manager` or `Access Creator` role in Raito. See [User Management](/docs/cloud/admin/user_management) for more information on roles in Raito.

A wizard will be shown to guide you through the different steps to create a new grant.

1. In the first step, a name for the grant must be provided. 
For data sources where grants are represented by named entities (e.g. roles), this display name will be used to generate that (technical) name from.
Additionally, an optional description of the grant can be provided in this step as well. It is recommended to do this to make clear what this grant is for.  
[![Create Grant - Step 1](/assets/images/cloud/access_management/create-step1.png)](/assets/images/cloud/access_management/create-step1.png){:target="_blank"}
2. In step 2, you specify what this grant provides access to.
To get started, click the `Add` button in the `Access granted on` section.
[![Create Grant - Select Data Source](/assets/images/cloud/access_management/create-step3a.png)](/assets/images/cloud/access_management/create-step3a.png){:target="_blank"}
   1. If this is the first element you add and the grant category you picked is a single-data source category, you'll be asked to pick your data source first. Pick one and click `Continue`.
   2. If this is the first element you add, you have to choose between defining a Static list or defining a Dynamic rule to calculate the items based on attributes. For more information on attribute-based grants, see [Attribute-Based Access Controls](/docs/cloud/abac).  
   For now, pick `Static list` and click `Continue`. 
   3. Next, you pick what you want to provide access to. This can be Data Objects (e.g. tables, schemas, files, folders ... ) or other grants (to set up inheritance). You can also add Masking rules and Row-level filters that should apply to your grant.  
   Let's just choose `Data objects` now and click `Continue`.
[![Create Grant - Select What Type](/assets/images/cloud/access_management/create-step3b.png)](/assets/images/cloud/access_management/create-step3b.png){:target="_blank"}
   1. Now you can easily select the data objects you want to provide access to. Use the search bar on top to search and filter for what you need, select the data objects you want and click `Add`.
   [![Create Grant - Select Data Objects](/assets/images/cloud/access_management/create-step3c.png)](/assets/images/cloud/access_management/create-step3c.png){:target="_blank"}  
   2. By default, the objects are added with 'Read' access. You can easily update the permissions you would like to provide.  
   Note: If you are not the owner of the data objects or grants you would like to add, an access request will be started and assigned to the owners to add these to your grant. These items will be indicated with a question mark icon next to them.  
   Below the list of selected Data Objects, you will automatically get a list of the Data Sources that this grant will be deployed to. You can select a different type of access per data source, if needed. 
   [![Create Grant - Select Permissions](/assets/images/cloud/access_management/create-step3d.png)](/assets/images/cloud/access_management/create-step3d.png){:target="_blank"}

1. In the last step, you can select who you want to provide this access to.
[![Create Grant - Add Beneficiaries](/assets/images/cloud/access_management/create-step4a.png)](/assets/images/cloud/access_management/create-step4a.png){:target="_blank"}
   1. Click the `Add` link.
   2. Also here, you have to choose between defining a Static list or defining a Dynamic rule to calculate the items based on attributes when you add the first item. For more information on attribute-based grants, see [Attribute-Based Access Controls](/docs/cloud/abac). For now, pick `Static list` and click `Continue`.
   3. Next, you'll need to choose the type of beneficiary you want to add. This can be Users, Groups or other Grants (to set up inheritance). For this example, select `Users` and click `Continue`.
   [![Create Grant - Beneficiary Type](/assets/images/cloud/access_management/create-step4b.png)](/assets/images/cloud/access_management/create-step4b.png){:target="_blank"}
   4. Now you can search for the users you want to add and click `Add`.
   [![Create Grant - Add Users](/assets/images/cloud/access_management/create-step4c.png)](/assets/images/cloud/access_management/create-step4c.png){:target="_blank"}
   5. Next, when adding users and groups, you can choose to either immediately `Grant` the access or to only pre-approve the access (`On request`). This means that the user (or users in the group) will automatically get access when they create an access request for this grant. In this case, you can choose for how long they receive the access. After that time, it automatically gets removed again.
   For this example, just choose `Granted` and click `Continue`.
   6. Once the user is added to the list, you can still choose until when they user should get this access. At the selected date and time, the access will automatically be removed again.
   [![Create Grant - Add Users](/assets/images/cloud/access_management/create-step4d.png)](/assets/images/cloud/access_management/create-step4d.png){:target="_blank"}


1. When your grant is ready, click `Publish`. 
2. When a CLI is running against the data source you picked, your new (or updated) grant will automatically be create/updated in the data source.