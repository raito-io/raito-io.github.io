---
title: Raito Cloud
nav_order: 15
has_children: false
has_toc: false
permalink: /cloud
---

# Raito Cloud

*TODO: Bart, Wannes, insert sales pitch here, without sound too sales-pitchy.* 

**Raito Cloud** supercharges all the information gathered from the [Raito CLI](/cli). Its main purpose is to *visualize* and *connect* the different types of information, so that you can clearly see
- the information available in your data warehouses,
- who has access to what,
- which data assets are accessible by few or many people,
- which data assets are barely used,
- ...

At this point we import information about the data objects, users, access providers and data usage from the data warehouse. The only information that is pushed to the data warehouse
is the data access. For the initial release there is a one-to-one relationship between access providers and the granted access (concretely: roles in Snowflake). This will allow, in the future, to
- more holistically manage access in the UI that can be translated to granular access for the CLI
- minimize the blast radius; certain people might have the right to access certain data, but why give them this access all the time? 
- ABAC or attribute-based access controls where people can get access to data through metadata tags.
- Manage access across all your data warehouses in a uniform way, even if they're using a different technology. 