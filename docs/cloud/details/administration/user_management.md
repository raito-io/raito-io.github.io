---
title: User Management
parent: Administration
grand_parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/admin/user_management
---

# Raito user management

Raito user management in Raito is the responsibility of an Admin. Such an Admin can provide access to users on the `User Management` page in the `Admin` pane. From the User Management page, the Admin can:

- Invite new users to Raito
- Manage [Global Roles](#raito_roles) for a user
- Remove access to Raito for users

{: .note}
There are more user management options available which are currently not configurable in the user interface. This includes SSO integration and automated pre-provisioning of Raito users. To set this up, please contact <a href="mailto:support\@raito.io">Raito Support</a>.

The `User Management` page is only meant to manage users that have access to Raito. All users, including the ones that cannot sign in to Raito, are visible under `Identities > Users`.

## Roles and rights

Raito has two types of roles, namely global and resource roles. A global role provides you certain permissions within Raito, while a resource role provides you certain permissions with regards to a specific resource (e.g. Data Object, Access Control, ...).

### Raito roles

Raito considers the following global roles:

- **Admin**: an Admin is responsible to manage Raito for the organization. He manages users and roles within Raito and initially creates Data Sources and Identity Stores.
- **Integrator**: an Integrator is the role used to perform a [CLI](/docs/cli) sync. It is advised to set up 1 or more dedicated (non-human) Raito users with only this global role to use for this purpose.
- **Access Creator**: an Access Creator can create new Access Controls. So each user that needs to be able to create new Access Controls, will need to have this role.
- **Observer**: an observer has access to all insights in Raito, but has no rights to perform actions in Raito.
- **Access Manager**: an Access Manager is a super-user with respect to Raito functionality. An Access Manager can manage access for all Data Objects, can edit any Access Control, see all Insights, ... So the Access Manager also has all the permissions of the Access Creator and Observer global roles. For reasons of separation of concert, it does NOT give permissions to do CLI syncs (Integrator) or to access the Admin section of Raito.
- **User**: Raito users without any global roles have the minimum level of access which provides them the possibility to request access to data, see the available data and see their own current access.

Next to these global roles, Raito also has a resource role, named `Owner`. An owner can own one of the following assets:

- **Data Source**: an Owner of the Data Source is the only one that can rename or remove the Data Source and is also Owner of all the Data Objects in the Data Source and of the native Identity Store of that Data Source.
- **Identity Store**: an Owner of the Identity Store is the only one that can rename or remove the Identity Store.
- **Data Object**: an Owner of a Data Object is the one responsible for managing the access to the Data Object. He can approve Access Requests to this Data Object and can add or remove his Data Object to an (existing) Access Control.
- **Access Control**: an Owner of an Access Control can see all the Access Control details, edit the Access Control and approve Access Requests to that Access Control.

Resource roles are inherited on all the descendant resources. Concretely, this means that when you are Owner of a Data Source, you also own all the Data Objects in that Data Source. Or, if you are Owner of a Data Object, you are also owner of all the Data Objects underneath it.

### Role assignment

Global roles can be assigned through the User Management page in the Admin pane by clicking the three dots next to someones name and choosing `Edit Raito roles`. 

Resource roles  (e.g. ownership of a Data Object) can be assigned on the page of the resource itself. This assignment can be performed by an Admin or an existing Owner of the resource.

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

| Permission | Data Source Owner | Identity Store Owner | Data Object Owner | Access Control Owner |
| --- | --- | --- | --- | --- |
| Delete the asset you own | ✅ | ✅ | ⛔️ | ✅ |
| View existing access: Data Object and User | Limited to the Data Source | ⛔️ | Limited to the Data Object | ✅ |
| Approve an Access Request | Limited to the Data Source | ⛔️ | Limited to the Data Object | Limited to the Access Control |
| View Access Control WHO-list | ✅ | ⛔️ | ✅ | ✅ |
| Manage Access Controls | ✅ (*) | ⛔️ | ✅ (*) | ✅ |
| View Access Control audit trail | ⛔️ | ⛔️ | ⛔️ | ✅ |
| Assign ownership | Limited to the Data Source | Limited to the Identity Store | Limited to the Data Object | Limited to the Access Control |

(*) Explained below:

Owners of Data Objects can manage Access Controls within the scope of the Data Objects they own. The same applies for a Data Source Owner, as he or she also owns all Data Objects in the Data Source.

When user owns at least 1 Data Object, he will be able to add and remove the Data Objects he owns to existing Access Controls. 

When an Owner owns all Data Objects of an Access Control, he will be able to see everything in that Access Control and edit everything (similar to the Owner of the Access Control), but cannot add Data Objects which he does not own.


## Type of users

There are two distinct types of users in Raito: `Person` and `Machine` (e.g. service-account). This distinction allows us to better understand and analyze user behavior based on their type.
If there is no specific type of user set, `Person` is used as the default.

The primary motivation behind implementing this user-type classification is to ensure the accuracy and reliability of the Insights pages. `Machine` users typically exhibit distinct access patterns compared to `Person` users. Including them in the combined view of all users could potentially distort the overall insights we derive from the data. By separating these user types, we can maintain a clearer and more precise understanding of user behavior, enabling us to make data-driven decisions based on accurate and reliable information.