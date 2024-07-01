---
title: Attribute-Based Access Controls
parent: Access Management
grand_parent: Raito Cloud
nav_order: 40
has_children: false
has_toc: false
permalink: /docs/cloud/abac
---

# Attribute-Based Access Controls (ABAC)

{: .note }
This feature may not be available in your environment. Please contact sales.

Grants, purposes, column masks and row-level filters can all be made dynamic. This means that you can define boolean expressions to dynamically calculate the data objects (for grants and masks) and beneficiaries (for all) that should be included in the access control.

These expressions are based on the metadata tags that are imported from the different source systems (data sources, catalogs, identity stores, dbt ...).

For example, you could 
 - define a dynamic column mask to mask all columns that have a tag `Classification:PII` AND tag `Category:Employee` for everyone except when the user has a tag `Department:HR`.
 - dynamically pre-approve access to all tables with tag `Category:Marketing` for all users with tag `Department:Marketing`.

## Dynamic Data Objects
{: .note }
Dynamic Data Objects can currently not be used for purposes and row-level filters. The explanation below will be for grants, but is similar for other applicable types.

To specify the data objects dynamically when editing an existing or creating a new grant or column mask, in step 2 of the wizard, choose `Dynamic`.

[![Filters](/assets/images/cloud/access_management/dynamic-what-title.png)](/assets/images/cloud/access_management/dynamic-what-title.png){:target="_blank"}

After selecting the data source you want to use from the grant, you can limit the scope of the ABAC-rule further by selecting one or multiple data objects. This scope determines which part of the data source the rule will apply to.

[![Filters](/assets/images/cloud/access_management/dynamic-what-scope.png)](/assets/images/cloud/access_management/dynamic-what-scope.png){:target="_blank"}

Next, you pick the type(s) of data object you want to select and what permissions you would like to provide. In the example below we'll be selecting tables and views and provide Read permissions on them.

[![Filters](/assets/images/cloud/access_management/dynamic-what-permission.png)](/assets/images/cloud/access_management/dynamic-what-permission.png){:target="_blank"}

As the last step, you can now define the boolean expression to filter out the data objects you want (within the previously selected scope and types).

[![Filters](/assets/images/cloud/access_management/dynamic-what-condition.png)](/assets/images/cloud/access_management/dynamic-what-condition.png){:target="_blank"}

Currently, two operators are available:
 - `Contains Tag` is used to check if the data object or any of its descendants contains the given tag.
 - `Has Tag` is used to check if the data object or any of its ancestors has the given tag.

More operators and options will be supported later.

## Dynamic Users
To specify the beneficiaries dynamically, in step 3 of the wizard, choose `Dynamic`.

{: .note }
Currently, you can only dynamically select users (not groups).  

First, you can choose to immediately Grant the access or to do it On Request (as pre-approval).

Next, you define the boolean expression to select the users you want.

[![Filters](/assets/images/cloud/access_management/dynamic-who.png)](/assets/images/cloud/access_management/dynamic-who.png){:target="_blank"}