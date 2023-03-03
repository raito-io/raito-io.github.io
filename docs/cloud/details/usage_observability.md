---
title: Usage observability
parent: Raito Cloud
nav_order: 30
has_children: false
has_toc: false
permalink: /docs/cloud/usage_observability
---

# Usage observability

You can add intelligence to managing data access by observing data usage. Raito Cloud displays the data usage from day 1 and continues to do so. These insights are provided on multiple places within Raito Cloud, as they all cover a different angle:

- **Data objects**: all usage of a single data object is grouped on the `Usage` tab of a data object
- **Users**: all usage from a given user is grouped on the `Usage` tab of a user
- **Dashboard**: the dashboard provides an aggregated overview of usage, both based on data objects as users.

{: .info }
> ℹ️ To view observability insights, you need the necessary permissions. See [Raito user management](/docs/cloud/user_management) for more information on which roles can see what in Raito.


## Usage insights

Most insights provided by Raito cloud, combine data access and data usage. Those only covering data access can be found on [Access observability](/docs/cloud/access_observability).

### Dashboard

Usage insights on the dashboard are visible for everyone except for users. A user only obtains insights into his personal usage on the dashboard, via the "used tables" tile and "table usage" widget.

The time-period for which all insights are calculated, can be set from the dashboard.

#### Overview

The overview contains multiple maturity score indices, namely:

- **Active users**: A user is someone who is present in the who-list of at least one active access provider. An active user is a user who has accessed at least one data object in the selected time-period.
- **Used tables**: A data object is a used table, when it is at least one time accessed by a user in the selected time-period. Remark that this tile is shown to a user, and that it contains the percentage of tables the specific user has accessed.
- **Used access providers**: An access provider is used, when at least one of its privileges for a data object in its what-list is used by at least one of the users mentioned in the who-list.

#### Detail widgets

Next to the overarching maturity scores, the dashboard consists of widget providing more detailed information for the selected time interval.

- **Data usage**: Total number of queries per data source.
- **Top users**: Users who have performed the most read queries.
- **Access coverage**: A matrix, where you can see per user the percentage of access to a data source.
- **Access usage**: A matrix, where you can see per user the percentage of the access that he or she has, which he or she actually uses. For databases, this percentage is calculated based on the percentage of tables you can access.
- **Access provider usage**: The number of queries run by a user in the who-list of the access provider covering at least one element of the what-list of the access provider.
- **Table usage**: The number of queries run by a user covering that exact table. Remark that this widget is shown to a user, and that it contains the number of queries of that exact user only.

### User page

A user page is a dedicated page per user and has a link to an access and a usage tab for an individual user. These tabs are again not visible for users, except the one from yourself.

On the usage tab you find most of the same widgets as on the dashboard, yet filtered out on the behavior of the specific user.

### Data object page

A data object page is a dedicated page per data object and has a link to an access and a usage tab for an individual user. These tabs are again not visible for users.

On the usage tab you find the number of times the data object has been used for the selected time period as well as its top users.