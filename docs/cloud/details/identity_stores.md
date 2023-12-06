---
title: Identity Stores
parent: Raito Cloud
nav_order: 11
has_children: false
has_toc: false
permalink: /docs/cloud/identity_store
---

# Identity Stores

An Identity Store in Raito contains the accounts and groups that are available in a system.
Each data source, will have it's own native identity store containing the accounts and groups that are available there. 

On top of that, also other (independent) identity stores can be added. These can provide additional groups and even accounts that may not be available (yet) in your data source(s). Also additional tags can be imported from these identity stores to provide a more complete view on users and groups. This can, for example, be your Azure Entra ID (previously called Active Directory) or Okta.

## Add a new identity store in Raito Cloud

Setting up a new identity store in Raito Cloud is similar to setting up a new data source. The entry point can be found by admins under Identities and Identity Stores in the main navigation. The only difference with the flow to connect a data source, is that we currently do not support the cloud CLI to connect an Identity Store.
