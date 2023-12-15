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
A grant provides access to specific data objects in a data source.  
The what-links also define the permissions that the grant provides to the users.

When defining the who-links, you have the option to immediately grant the access or to pre-approve the access, which mean that the access will automatically be granted when the user creates an Access Request for this Grant Access Control.

[![Grants](/assets/images/Grants.jpg)](/assets/images/Grants.jpg){:target="_blank"}

## Creating a Grant

To create a new grant, navigate to `Access controls > Grants` and click `Create grant` in the top right corner of the page.

{: .info }
> ℹ️ To create a new grant, you need be at least owner of one or more data objects or have the global `Access Manager` or `Access Creator` role in Raito. See [User Management](/docs/cloud/admin/user_management) for more information on roles in Raito.

A wizard will be shown to guide you through the different steps to create a new grant.

1. In the first step, a name for the grant must be provided. 
For data sources where grants are represented by named entities (e.g. roles), this display name will be used to generate that (technical) name from.
Additionally, an optional description of the grant can be provided in this step as well. It is recommended to do this to make clear what this grant is for.  
[![Create Grant - Step 1](/assets/images/cloud/access_management/create-step1.png)](/assets/images/cloud/access_management/create-step1.png){:target="_blank"}
2. In step 2, you must select the data source this grant is for. Grants are always part of a single data source. To provide access to multiple data sources with the same access control, use a [purpose](/docs/cloud/access_management/purposes) instead.
3. Once you selected the data source, step 3 will become available to select the data objects you want to grant access to.
   1. To add a data object, click the `+ Add Data object` link.
   2. In the panel that pops up, select the type of data object(s) you want to add and then search for the actual data objects.  
[![Create Grant - Select What](/assets/images/cloud/access_management/create-select-what.png)](/assets/images/cloud/access_management/create-select-what.png){:target="_blank"}
   3. Now click `Add data object` to add the data object to the what-list of you new grant.  
   [![Create Grant - Step 3](/assets/images/cloud/access_management/create-step3.png)](/assets/images/cloud/access_management/create-step3.png){:target="_blank"}  
   You can also add other grants here to inherit the what-list from those.  
   Note: If you do not own the data objects or grants you would like to add, an access request will be started and assigned to the owners to add these to your grant.
   4. For each data object in the list, you can select which permissions should be granted.

4. In the last step, you can select the beneficiaries (who-list) of this grant.
   1. Click the `+ Add Beneficiary` link.
   2. First, you will be asked to choose whether you want to grant the access immediately or only want to pre-approve access in case the user creates an access request for this grant. When the user creates the access request, access will automatically be granted for the timeframe you predefined. This mechanism is a great way to implement a least-privilege access mindset.  
[![Create Grant - Select Who Type](/assets/images/cloud/access_management/create-select-who-type.png)](/assets/images/cloud/access_management/create-select-who-type.png){:target="_blank"}
   3. In the next step, you can then select the users, groups, grants and/or purposes you want to provide access to this grant.  
[![Create Grant - Select Who](/assets/images/cloud/access_management/create-select-who.png)](/assets/images/cloud/access_management/create-select-who.png){:target="_blank"}
   4. Now click the `Add` button to add the new beneficiaries to the grant.
[![Create Grant - Step 4](/assets/images/cloud/access_management/create-step4.png)](/assets/images/cloud/access_management/create-step4.png){:target="_blank"}
   5. For each beneficiary, a date can be chosen until which this grant (or pre-approval) remains valid. After this time, the access will automatically be revoked again.

5. Click `Publish grant`. A dialog will pop up showing an overview of the changes that will be made. 
6. Choose `Publish grant` again to store the changes.  
When a CLI is running against the data source you picked, your new (or updated) grant will automatically be synchronized with the data source.