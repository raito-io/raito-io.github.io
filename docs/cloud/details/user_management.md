---
title: Raito user management
parent: Raito Cloud
nav_order: 80
has_children: false
has_toc: false
permalink: /docs/cloud/user_management
---

# Raito user management

Raito user management in Raito is the responsibility of an admin. Such an admin can provide access to users on the user management page in the admin pane. An admin can provide access via:

- Setting up SSO to Raito
- Granting access to domains: e.g. everyone with a *@raito.io address
- Personal invite on email

By default, every new user has no Raito roles assigned, which means he is a plain user in the system.

# Roles and rights

Raito has two types of roles, namely global and local roles. A global role provides you certain permissions within Raito, a local role provides you certain permissions with regards to a specific asset.

## Raito roles

Raito considers the following global roles:

- **Admin**: an admin is responsible to manage Raito for the organization. We have a full separation of concerns, which means that an admin by default does not manage access to data objects.
- **Integrator**: an integrator is the role used to perform a CLI sync. The integrator role is hence often assigned to a service account.
- **Creator**: a creator is a super-user with respect to Raito functionality. A creator can manage access for all data objects.
- **Observer**: an observer has access to all insights in Raito, but has no rights to perform actions in Raito.
- **User**: a user is the minimum level of access to Raito which provides you all functionality to request access to data and see your personal information.

Next to this global role, we have a local role, owner. An owner can own the following assets:

- **Owner of a data source**: an owner of the data source is the only one that can remove the data source.
- **Owner of an identity store**: an owner of the identity store is the only one that can remove the identity store
- **Owner of a data object**: an owner of a data object is the one responsible to manage the access to the data object. Both via approving in the access request workflow as via edition of access providers to the data object.

## Role assignment

Global roles can be assigned through the user management page in the admin pane by clicking the three dots next to someones name. Local roles, like ownership of a data object, can be assigned on the assets page. This local assignment can be performed by an admin or via someone with the same local role.

## Role permissions - global roles

| Permission | Admin | Integrator | Creator | Observer | User |
| --- | --- | --- | --- | --- | --- |
| Manage Data Sources: add, delete, update metadata | ✅ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| Manage Identity Stores: add, delete, update metadata | ✅ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| Manage users: invite to Raito and assign roles (global and local) | ✅ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| View Data Object tree | ✅ | ✅ | ✅ | ✅ | ✅ |
| View Users | ✅ | ✅ | ✅ | ✅ | ✅ |
| View Access Provider name, purpose and WHAT-list | ✅ | ✅ | ✅ | ✅ | ✅ |
| View Access Provider WHO-list | ⛔️ | ✅ | ✅ | ✅ | ⛔️ |
| View existing access: Data Object and User | ⛔️ | ⛔️ | ✅ | ✅ | ⛔️ |
| View usage information: Data Object and User | ⛔️ | ⛔️ | ✅ | ✅ | ⛔️ |
| View dashboard metrics | ⛔️ | ⛔️ | ✅ | ✅ | ⛔️ |
| Request access | ✅ | ✅ | ✅ | ✅ | ✅ |
| Approve an access request | ⛔️ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| Manage Access Providers | ⛔️ | ✅ | ✅ | ⛔️ | ⛔️ |

## Role permissions - local roles

| Permission | Data Source owner (*) | Identity Store owner | Data Object owner |
| --- | --- | --- | --- |
| Delete the asset you own | ✅ | ✅ | ⛔️ |
| View existing access: Data Object and User | Limited to the Data Source | ⛔️ | Limited to the Data Object |
| Approve an access request | Limited to the Data Source | ⛔️ | Limited to the Data Object |
| View Access Provider WHO-list | ✅ | ⛔️ | ✅ |
| Manage Access Providers | ✅ (**) | ⛔️ | ✅ (**) |
| Assign ownership | Limited to the Data Source | Limited to the Identity Store | Limited to the Data Object |

(*) Certain permissions arise from the fact that a Data Source owner also owns all Data Objects of the Data Source.

(**) Explained in the following section

## Data Object owners & Access Providers

Owners of Data Objects can manage Access Providers within the scope of the Data Objects they own. The same applies for a Data Source owner, as he or she also owns all Data Objects in the Data Source.

### An owner owns all Data Objects of an Access Provider

✅ Sees everything 

☑️ Can edit everything, but cannot add Data Objects which he does not own

### An owner owns at least 1 Data Object anywhere in the system

✅ Sees everything

☑️ Can add/remove data objects he/she owns

⛔  Cannot edit name, WHY and WHO