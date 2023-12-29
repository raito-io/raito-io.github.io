---
title: Row Filters
parent: Access Management
grand_parent: Raito Cloud
nav_order: 25
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/filters
---

# Row Level Filtering

A row level filter allows you to limit the visibly of data in specific tables. With row level filters, users will only see rows that match predefined criteria.

The filter is applied to all users, groups or access controls specified in the who-list of the filter. 
When a table has at least one filter assigned, users who are not included in any of the associated filters will not be able to view any data from that table. Conversely, users who are listed in a filter's who-list will only see rows that match the filter's criteria.
However, exceptions can be made by adding specific entities to the who-list. Additionally, some data source may have specific permissions that grant users the ability to see all rows.

When multiple filters are assigned to a table, the union of the filter criteria becomes the effective filtering mechanism. 
This means that users who are included in any of the associated filters will only see rows that match the criteria of at least one of those filters.

Note: Depending on the data source, some Row Filters imported from data sources cannot be edited within Raito. It is recommended to create new filters within Raito to replace existing ones.

[![Filters](/assets/images/Filters.jpg)](/assets/images/Filters.jpg){:target="_blank"}

### Creating a Filter

Creating a filter is similar to [creating a grant](/docs/cloud/access_management/grants), with a few key differences:

 - Only tables can be selected for the what-list.
 - An additional step is available to specify the filter criteria.