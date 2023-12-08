---
title: Access Insights
parent: Insights
grand_parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/insights/access
---

# Access Insights

Managing data access starts with observing existing access to data. Raito Cloud displays the existing access from day 1 and continues to do so. These insights are provided in multiple places within Raito Cloud, as they all cover a different angle.

{: .info }
> ℹ️ To view insights, you need the necessary permissions. See [User Management](/docs/cloud/admin/user_management) for more information on which roles can see what in Raito.

## User page

Every user known in the system has a dedicated page. It contains a `Controls`, an `Access` and an `Insights` tab for an individual user. These tabs will only be visible if you have the necessary permissions.

On the `Controls` tab you find an overview of all access controls the user is part of. On the `Access` tab you find an overview of all data objects the user can access and via which access control(s). Note that Raito expands access control inheritance and groups to show this list. This tab also provides the permissions per data object. A full lineage is shown via the link “view lineage”, including validity periods.

## Data object page

A data object page is a dedicated page per data object and contains an `Access` and an `Insights` tab. These tabs will only be visible if you have the necessary permissions.

On the `Access` tab you find an overview of all users that can access the data object and via which access control. Note that Raito expands access control inheritance and groups to show this list. This tab also provides the permissions per data object. A full lineage is shown via the link “view lineage”, including validity periods.

## Access control page

The `general` tab of the access control page provides an overview of the WHAT-list and the WHO-list of the access control. As such you can deduct who has access to what through that access control.
