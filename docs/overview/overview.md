---
title: Overview
nav_order: 10
has_children: true
has_toc: false
permalink: /docs/overview
---
# Overview
The diagram below provides a simple overview of the different components in the Raito ecosystem.

[![Raito Overview](/assets/images/raito-overview.png)](/assets/images/raito-overview.png){:target="_blank"}

## Raito Cloud
The Raito Cloud component on the right of the diagram, is the SaaS web application that most Raito users will interact with. It provides
 - a clear overview of the structure your data sources
 - an overview of *who* has access to *what*
 - smart insights into the state of your data sources by looking at the access controls and how they compare to the actual usage
 - a simple way to update the access to your data sources
 - and much more...

More details can be found in the [Raito Cloud](/docs/cloud) section.

## Raito CLI
The Raito CLI component, shown in the middle of the diagram, is the link between your data sources and Raito Cloud. It is an open-source command-line interface application that can be run in your data center or even on your own laptop/desktop.

While synchronizing with Raito Cloud, the CLI extracts information from the data source. This includes the meta data structure (e.g. the databases, schemas, tables, ... present), the users, the existing access controls (e.g. Snowflake roles) and the data usage information.
In the other direction, the access controls defined in Raito Cloud are pushed to the data source (e.g. by creating and updating Snowflake roles).

The CLI is open-source to provide full transparency into what information is extracted from the data sources and sent to Raito Cloud.

The connection to a data source itself happens in a `connector`, which is a plugin of the CLI. Each type of data source will have its own connector. Raito will provide some connectors as open-source, but it's perfectly possible to implement your own connector for data sources that are not supported by us.

On the left of the diagram, we see the data sources (also called `targets`) that the connectors will connect with.

More details can be found in the [Raito CLI](/docs/cli) section.