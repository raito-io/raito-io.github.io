---
title: Row Filters
parent: Access Management
grand_parent: Raito Cloud
nav_order: 25
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/filters
---

# Row-Level Filtering

A row-level filter allows you to limit the visibility of data in specific tables. With row-level filters, users will only be able to query the rows that match predefined criteria.

The filter is applied to all users, groups or access controls specified in the who-list of the filter. 
When a table has at least one filter applied, users who are not included in any of the associated filters will not be able to view any data from that table. Conversely, users who are listed in a filter's who-list will only see rows that match the filter's criteria.

When multiple filters are assigned to a table, the union of the filter criteria becomes the effective filtering mechanism. 
This means that users who are included in any of the associated filters will only see rows that match the criteria of at least one of those filters.  

For example: suppose there are two filters (`filter1` and `filter2`) applied on the same table. `filter1` only allows to see the rows where `age > 18` and `filter2` only allows to see the rows where `countryCode == BE`. Users that are in the beneficiaries list of both filters, will be able to see all the rows that either have `age > 18` OR `countryCode == BE`.

Some data sources may have specific permissions that grant users the ability to see all rows (i.e. overriding the row-level filter).  
For data sources that don't have such a permission, you can add an additional row-level filter for that table without any filter criteria set. The beneficiaries of this filter will then be able to see all the rows in the table.

Note: Depending on the data source, some Row Filters imported from data sources cannot be edited within Raito. It is recommended to create new filters within Raito to replace existing ones.

[![Filters](/assets/images/Filters.jpg)](/assets/images/Filters.jpg){:target="_blank"}

### Creating a Filter

Creating a filter is similar to [creating a grant](/docs/cloud/access_management/grants), with a few key differences:

 - Only tables can be selected for the what-list.
 - An additional step is available to specify the filter criteria.