---
title: Purposes
parent: Access Management
grand_parent: Raito Cloud
nav_order: 15
has_children: false
has_toc: false
permalink: /docs/cloud/access_management/purposes
---

# Purposes

Purposes group access controls from multiple data sources to be used together for a specific objective. Unlike grants, purposes do not directly contain data objects in their what-list. Instead, they can inherit them from grants or other purposes. Additionally, purposes can have masks and row filters attached to them.

Using purposes allows for a clear separation of responsibilities between data owners, who create grants to expose their data products in a single data source, and purpose owners, who combine data from multiple sources to serve higher-level objectives.

Similar to grants, access to a purpose can be pre-approved instead of granted immediately.

[![Purposes](/assets/images/Purposes.jpg)](/assets/images/Purposes.jpg){:target="_blank"}

### Creating a Purpose

Creating a purpose is similar to [creating a grant](/docs/cloud/access_management/grants), with a few key differences:

 - The who-list of a purpose can only include users, groups, and other purposes.
 - The what-list of a purpose can only include grants and other purposes.