---
title: Column Masks
parent: Access Management
grand_parent: Raito Cloud
nav_order: 20
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/masks
---

# Column Masks

{: .note }
This feature may not be available in your environment. Please contact sales.

A column mask allows you to limit the visibility of data in specific columns. With column masks, users will only see a limited version of the data in those columns, unless they have the permission to see the data unmasked.

Each data source has its own set of masking capabilities, so when creating a masking rule, you will need to specify the type of masking algorithm to use. 

By default, the mask is applied to all users, groups, or access controls specified in the who-list of the mask. However, exceptions can be made by adding specific entities to the who-list. Additionally, some data sources may have specific permissions that grant users the ability to see all data unmasked.

Note: Column masks imported from data sources cannot be edited within Raito. It is recommended to create new masking rules within Raito to replace existing ones.

[![Masks](/assets/images/Masks.jpg)](/assets/images/Masks.jpg){:target="_blank"}

### Creating a Mask

Creating a mask is similar to [creating a grant](/docs/cloud/access_management/grants), with a few key differences:

 - Only columns can be selected for the what-list. You'll need to select the parent table first and then pick the columns you would like to mask.
 - In the section `Where does the mask apply?' you can select the type of masking that needs to be applied for each data source by clicking the Edit button next to it.  
 [![Create Mask - Select Type](/assets/images/cloud/access_management/create-mask-type.png)](/assets/images/cloud/access_management/create-mask-type.png){:target="_blank"}