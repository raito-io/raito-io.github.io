---
title: Create
parent: Identity Stores
grand_parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/identity_stores/create
---

# Setting up a new Identity Store

Creating a new identity store in Raito Cloud is similar to setting up a new [data source](/docs/cloud/datasources/create).

To add a new identity store in Raito Cloud, follow these steps:

- In the sidebar navigation menu, open up the `Identities` panel and click the `Identity stores` menu item.
- Now click the `Add identity store` button in the top right corner.
- Select the type of identity store you would like to add.
Note: This choice is purely meant to guide you through setting up this specific identity store type. If your identity store type is not in the list (for example, when you built your own Raito CLI plugin), you can pick any type to continue.
- Provide a name for your identity store. This name will be the display name for this identity store within Raito Cloud and will be visible to all the users in the system.
- Next, provide an optional description for your identity store to describe in more detail what this identity store contains and what it is meant for.
- When done, you will land on the main page of your new identity store. Because it hasn’t been connected to the actual identity store yet, instructions will be shown on how to proceed. The instruction to set up the CLI for connecting an identity store are identical to those of data sources.


{: .info }
> ℹ️ To add a identity store, you need to have the global `Admin` role in Raito. See [User Management](/docs/cloud/admin/user_management) for more information on roles in Raito.

Once the identity store is created, you will be the default owner. You can assign additional owners to make changes when necessary.