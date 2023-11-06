---
title: Access and usage insights
parent: Raito Cloud
nav_order: 30
has_children: false
has_toc: false
permalink: /docs/cloud/usage_observability
---

# Access and usage insights

You can add intelligence to managing data access by observing data usage. Raito Cloud displays the data usage from day 1 and continues to do so. These insights are provided on multiple places within Raito Cloud, as they all cover a different angle:

- **Data objects**: all usage of a single data object is grouped on the `Insights` tab of the data object
- **Users**: all usage from a given user is grouped on the `Insights` tab of the user
- **Access Controls**: all usage from a given access control is grouped on the `Insights` tab of the access control
- **Dashboard**: the dashboard provides an aggregated overview of usage, both based on data objects, access controls, as users.
- **Insights**: the insights page provides insights for users, data objects and access controls.

{: .info }
> ℹ️ To view access and usage insights, you need the necessary permissions. See [Raito user management](/docs/cloud/user_management) for more information on which roles can see what in Raito.


## Definitions

- **Used**.- Something is used when at least one permission on one of the data objects is used within the given time period
- **Access** - percentage of data that can be accessed  
*Note*: even though this term has multiple meanings, it will be clear from the context when it is access or short for percentage of access.
- **Usage** - percentage of access which is actually used
- **Access risk - also referred to as risk**: Percentage of data that can be accessed through a read or write permission, but which has not been used
- **Exposure** - percentage of users that can access an access control or data
- **Exposure risk -** Percentage of users that can access data, but which have not used it
- **Utility** - The percentage of users that have access to data and use it
- **Active users** - percentage of exposed users that have actually used their access

## Usage insights

Most insights provided by Raito cloud, combine data access and data usage. The overview of existing access can be found on [Access observability](/docs/cloud/access_observability).

### Dashboard

Usage insights on the dashboard are visible for everyone except for users. The time-period for which all insights are calculated, can be set from the dashboard, yet can differ for every data source, depending on the timeframe for which insights are available.

#### Overview

The overview contains multiple maturity score indices, namely:

- **Active users**: A user is someone who is present in the who-list of at least one active access control. An active user is a user who has accessed at least one data object in the selected time-period.
- **Used data**: A data object is used, when it is at least one time accessed by a user in the selected time-period.
- **Used access controls**: An access control is used, when at least one of its permissions for a data object in its what-list is used by at least one of the users mentioned in the who-list.

#### Maturity Score

The Maturity score is the average of the above three scores.

#### Distributions

The dashboard contains a widget called `Accounts Distribution` . This widget shows the number of users with accounts in 1 data source as well as the number of users with accounts in multiple data sources.

Next to this widget, we have the widget `User Distribution` . This widget shows the number of users with access and the number of users without access.

### Insights page

#### Access control

The access control page contains the access risk map and the exposure risk map. The access risk map provides insights in how many data objects are accessible through an access control and how many of them are actually being used, whereas the exposure riks map provides insights in how many users obtain access via an access control and how many actually use this access.

Next to this, there is a full list of all access controls where you can see the access and usage of this access control, the exposure and active users of this access control as well as the deducted values of risk and utility.

#### User

The user page contains the access risk map and a query distribution map. The access risk map provides insights in how many data objects are accessible by the user and how many of them are actually being used. The query distribution map shows how many users have run how many queries.

Next to this, there is a full list of all users where you can see the access and usage of this user, his number of queries and his risk.

#### Data object

The data object page contains the exposure risk map and a query distribution map. The exposure risk map provides insights in how many users have access to data and how many of them have actually used it. The query distribution map shows how many data objects have been subject of how many read queries.

Next to this, there is a full list of all data objects where you can see the exposure and active users for this data object, the number of queries it has been subject to and the utility.

### Detail page

#### Access control

The access control insights tab shows the risk score and the utility score next to a usage table, which shows the number of queries per beneficiary as well as his last usage. It contains a short-cut to remove a user from an access control based on these insights.

#### User

The user insights tab shows the risk score next to an access control usage widget and a data usage widget. Both contain the number of queries, the last usage and allow you to view the lineage. The access control widget contains a short-cut to remove a user from an access control based on these insights.

#### Data object

The data object insights tab shows the utility score next to a usage table, which shows the number of queries per beneficiary as well as his last usage and it allows you to view the lineage.
