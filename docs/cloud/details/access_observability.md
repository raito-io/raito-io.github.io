---
title: Access observability
parent: Raito Cloud
nav_order: 20
has_children: false
has_toc: false
permalink: /docs/cloud/access_observability
---

# Access observability

Managing data access starts with observing existing access to data. Raito Cloud displays the existing access from day 1 and continues to do so. These insights are provided in multiple places within Raito Cloud, as they all cover a different angle:

- **Data objects**: all access to a single data object is grouped on the `Access` tab of a data object
- **Users**: all access for a given user is grouped on the `Access` tab of a user
- **Dashboard**: the dashboard provides an aggregated overview of access, both based on data objects and users.


{: .info }
> ℹ️ To view observability insights, you need the necessary permissions. See [Raito user management](/docs/cloud/user_management) for more information on which roles can see what in Raito.

## Access insights

Most insights provided by Raito Cloud, combine data access and data usage. As such they will be discussed on [Usage observability](/docs/cloud/usage_observability).

Within this section, we only describe the overview of existing access, not insights based upon them.

### User page

Every user known in the system has a dedicated page. It contains an `Access` and an `Insights` tab for an individual user. These tabs will only be visible if you have the necessary permissions.

On the `Access` tab you find an overview of all data objects the user can access and via which access control(s). Note that Raito expands access control inheritance and groups to show this list. This tab also provides the permissions per data object. A full lineage is shown via the link “view lineage”, including validity periods.

### Data object page

A data object page is a dedicated page per data object and contains an `Access` and an `Insights` tab. These tabs will only be visible if you have the necessary permissions.

On the `Access` tab you find an overview of all users that can access the data object and via which access control. Note that Raito expands access control inheritance and groups to show this list. This tab also provides the permissions per data object. A full lineage is shown via the link “view lineage”, including validity periods.

### Access control page

The `general` tab of the access control page provides an overview of the WHAT-list and the WHO-list of the access control. As such you can deduct who has access to what through that access control.
