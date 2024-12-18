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

Grants, column masks and row-level filters can all be made dynamic. This means that you can define boolean expressions to dynamically calculate the data objects (for grants and masks) and beneficiaries (for all) that should be included in the access control.

These expressions are based on the metadata tags that are imported from the different source systems (data sources, catalogs, identity stores, dbt ...).

For example, you could 
 - define a dynamic column mask to mask all columns that have a tag `Classification:PII` AND tag `Category:Employee` for everyone except when the user has a tag `Department:HR`.
 - dynamically pre-approve access to all tables with tag `Category:Marketing` for all users with tag `Department:Marketing`.

## Dynamic Data Objects
{: .note }
Dynamic Data Objects can currently not be used for row-level filters. The explanation below will be for grants, but is similar for other applicable types.

To specify the data objects dynamically when creating a grant or column mask, in step 2 ('Access granted on') of the wizard, click `Add`. When it's a single-data source grant, you'll first be asked to pick your data source. In the next step, choose `Dynamic rule` and click `Continue`.

[![Filters](/assets/images/cloud/access_management/dynamic-what-choice.png)](/assets/images/cloud/access_management/dynamic-what-choice.png){:target="_blank"}

New, you will be asked to pick one or more data objects that act as the scope for the ABAC rule. This scope determines which part of the data source(s) the rule will apply to, meaning that only descendants of these data objects can be in the result of this ABAC rule. You can apply filters to more easily find what you are looking for.

[![Filters](/assets/images/cloud/access_management/dynamic-what-scope.png)](/assets/images/cloud/access_management/dynamic-what-scope.png){:target="_blank"}

When the scope is added, you can now specify the details of the rule to determine which data objects to select.  
First, you'll need to pick the type(s) of data object you want to search for and which permissions you would like to provide. In the example below we'll be selecting tables and views and provide Read permissions on them.

[![Filters](/assets/images/cloud/access_management/dynamic-what-permission.png)](/assets/images/cloud/access_management/dynamic-what-permission.png){:target="_blank"}

As the last step, you can now define the boolean expression to specify the data objects you want (within the previously selected scope and types).

[![Filters](/assets/images/cloud/access_management/dynamic-what-condition.png)](/assets/images/cloud/access_management/dynamic-what-condition.png){:target="_blank"}

Currently, two operators are available:
 - `Contains Tag` is used to check if the data object or any of its descendants contains the given tag.
 - `Has Tag` is used to check if the data object or any of its ancestors has the given tag.

More operators and options will be supported later.

## Dynamic Users
Similarly, in the 3rd step, when adding the first beneficiaries, you can choose `Dynamic` to dynamically specify the users you would like to provide access for.

{: .note }
Currently, you can only dynamically select users (not groups).  

First, you can choose whether you want to grant the access immediately or only on request.  
Next, you define the boolean expression to select the users you want.

In the example below, we automatically provide access for 7 days, when anyone with the tag `Department:Marketing` requests it.

[![Filters](/assets/images/cloud/access_management/dynamic-who.png)](/assets/images/cloud/access_management/dynamic-who.png){:target="_blank"}