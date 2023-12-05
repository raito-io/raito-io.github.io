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

By default, every new user has no Raito roles assigned, which means he/she is a plain user in the system, and will only be able to request access.

## Roles and rights

Raito has two types of roles, namely global and local roles. A global role provides you certain permissions within Raito, a local role provides you certain permissions with regards to a specific asset.

### Raito roles

Raito considers the following global roles:

- **Admin**: an admin is responsible to manage Raito for the organization. He manages users and roles withing Raito and connects Data Sources and Identity Stores. Raito has a full separation of concerns, which means that an admin by default does not manage access to data objects.
- **Integrator**: an integrator is the role used to perform a CLI sync. The integrator role is hence often assigned to a service account.
- **Access manager**: an access manager is a super-user with respect to Raito functionality. An access manager can manage access for all data objects.
- **Access creator**: an access creator can create new access controls. This role is typically used for users that don't own any data objects, but still need to be able to create acess controls (e.g. purposes). 
- **Observer**: an observer has access to all insights in Raito, but has no rights to perform actions in Raito.
- **User**: a user is the minimum level of access to Raito which provides you all functionality to request access to data and see your personal information.

Next to these global roles, Raito also has a resource role, named `owner`. An owner can own one of the following assets:

- **Data Source**: an owner of the data source is the only one that can rename or remove the data source and is also owner of all the data objects in the data source and of the native identity store of the data source.
- **Identity Store**: an owner of the identity store is the only one that can rename or remove the identity store
- **Data Object**: an owner of a data object is the one responsible for managing the access to the data object. He can approve data object access requests and can add or remove his data object to the what-list of an access control.
- **Access Control**: an owner of an access control can see all the access control details, edit the access control and approve access requests to that access control.

### Role assignment

Global roles can be assigned through the user management page in the admin pane by clicking the three dots next to someones name. 

Resource roles, like ownership of a data object, can be assigned on the page of the resource itself. This assignment can be performed by an admin or an existing owner of the resource.

### Role permissions - global roles

| Permission | Admin | Integrator | Access Manager | Access Creator | Observer | User |
| --- | --- | --- | --- | --- | --- | --- |
| Manage Data Sources: add, delete, update metadata | ✅ | ⛔️ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| Manage Identity Stores: add, delete, update metadata | ✅ | ⛔️ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| Manage users: invite to Raito and assign roles (global and local) | ✅ | ⛔️ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| View Data Object tree | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| View Users | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| View name, purpose and WHAT-list of all Access Controls | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| View WHO-list of all Access Controls | ⛔️ | ✅ | ✅ | ⛔️ | ✅ | ⛔️ |
| View access of all Data Objects and Users | ⛔️ | ⛔️ | ✅ | ⛔️ | ✅ | ⛔️ |
| View usage information of all Data Objects, Access Controls and Users | ⛔️ | ⛔️ | ✅ | ⛔️ | ✅ | ⛔️ |
| View dashboard metrics | ⛔️ | ⛔️ | ✅ | ⛔️ | ✅ | ⛔️ |
| Request access | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Approve any access request | ⛔️ | ⛔️ | ⛔️ | ⛔️ | ⛔️ | ⛔️ |
| Manage all Access Controls | ⛔️ | ⛔️ | ✅ | ⛔️ | ⛔️ | ⛔️ |
| View global Audit trail | ⛔️ | ⛔️ | ✅ | ⛔️ | ✅ | ⛔️ |

### Role permissions - local roles

| Permission | Data Source owner | Identity Store owner | Data Object owner | Access Control owner |
| --- | --- | --- | --- | --- |
| Delete the asset you own | ✅ | ✅ | ⛔️ | ✅ |
| View existing access: Data Object and User | Limited to the Data Source | ⛔️ | Limited to the Data Object | ✅ |
| Approve an access request | Limited to the Data Source | ⛔️ | Limited to the Data Object | Limited to the Access Control |
| View Access Control WHO-list | ✅ | ⛔️ | ✅ | ✅ |
| Manage Access Controls | ✅ (*) | ⛔️ | ✅ (*) | ✅ |
| View Access Control audit trail | ⛔️ | ⛔️ | ⛔️ | ✅ |
| Assign ownership | Limited to the Data Source | Limited to the Identity Store | Limited to the Data Object | Limited to the Access Control |

(*) Explained in the following section

### Data Object owners & Access Controls

Owners of Data Objects can manage Access Controls within the scope of the Data Objects they own. The same applies for a Data Source owner, as he or she also owns all Data Objects in the Data Source.

#### An owner owns all Data Objects of an Access Control

✅ Sees everything 

☑️ Can edit everything, but cannot add Data Objects which he does not own

#### An owner owns at least 1 Data Object anywhere in the system

✅ Sees everything

☑️ Can add/remove data objects he/she owns

⛔  Cannot edit name, WHY and WHO


## Type of users

There are two distinct types of users in Raito: `Person` and `Machine` (e.g. service-account). This distinction allows us to better understand and analyze user behavior based on their type.
If there is no specific type of user set, `Person` is used as the default.

The primary motivation behind implementing this user-type classification is to ensure the accuracy and reliability of the Insights pages. `Machine` users typically exhibit distinct access patterns compared to `Person` users. Including them in the combined view of all users could potentially distort the overall insights we derive from the data. By separating these user types, we can maintain a clearer and more precise understanding of user behavior, enabling us to make data-driven decisions based on accurate and reliable information.