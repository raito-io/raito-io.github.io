---
title: Identity Stores
parent: Raito Cloud
nav_order: 11
has_children: true
has_toc: true
permalink: /docs/cloud/identity_stores
---

# Identity Stores

An Identity Store in Raito contains the accounts and groups that are available in a system.
Each data source, will have it's own native identity store containing the accounts and groups that are available there. 

On top of that, also other (independent) identity stores can be added. These can provide additional groups and even accounts that may not be available (yet) in your data source(s). Also additional tags can be imported from these identity stores to provide a more complete view on users and groups. This can, for example, be your Azure Entra ID (previously called Active Directory) or Okta.
