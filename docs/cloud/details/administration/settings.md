---
title: Settings
parent: Administration
grand_parent: Raito Cloud
nav_order: 20
has_children: false
has_toc: false
permalink: /docs/cloud/admin/settings
---

# Settings

Users with the global `Admin` role, can adapt the settings of the Raito Cloud platform by going to `Admin > Settings` in the main menu on the left.

The settings are grouped per category. These are described in the sections below.

## Access Requests
The `Access requests` settings page allows you to configure how the Access Request functionality in Raito Cloud should behave. It is especially meant to tailor the experience for the end user, making sure that they can only request access to the data that you want.

In the first section of the Access requests settings, you can choose the grant categories to which users will be able to request access to. If all of them are disabled, users will not be able to request access to Grants directly. 

The second section allows you to define whether users can request access to data objects or not. Next to that, it allows you to define, per data source, which data object types users  can request access to. To do this, simply click the `Configure` button next to each data source. There, you can choose to either allow picking all data objects or limit it to certain data object types.
For example, you may want to make sure that users can only request access to schemas in Snowflake and not to individual tables or views.

## Grant Categories
The `Grant categories` settings page allows you to configure which [grant categories](/docs/overview/concepts#grant-categories) should be available and how they should behave.

### Adding a grant category
To add a new grant category, simply click the `Add category` button on the Grant categories settings page.

The settings for a specific grant category are grouped in logical sections:
1. **General**: Here you can define an icon, name and description for your grant category. You can also define if
  - grants of this category can be created in the Raito UI or not.
  - grants with the same name are allowed for this category or not.
  - the description of grants in the category is mandatory or optional.
2. **Grant access on**: Allows you to define what data a grant in this category can provide access to:
  - *Data objects*: if disabled, data objects cannot be directly added to these grants. Typically this is used for higher level grant categories that groups other grants together.
  - *Multiple data sources*: if enabled, these grants can provide access to data from multiple data sources.
3. **Grant access to**: Allows you to define which types of beneficiaries a grant in this category can have:
 - *Users*: to allow adding users directly as beneficiary
 - *Groups*: to allow adding groups as beneficiary
 - *Inheritance*: to allow adding other grants as beneficiary. Here you can configure things more fine-grained by choosing to allow linking to *All* grant categories or just to grant of the same category (*Self*) or to a specific list of categories. This functionality allows you to limit the hierarchy between grant categories. For example, you may want to group grants of category Data Product in grant of category Purpose, but not the other way around.
4. **Default access type**: This lets you select the default access type the grant should become for each specific data source. Since most data sources only have 1 access type, this is not applicable. For example, in AWS, you could define if a grant of this category turns into an AWS IAM Policy or an AWS IAM Role.

When you configured all the different settings, 

### Editing a grant category
To edit an existing grant category, simply click the context menu next to the grant category (three dots icon) and select `Edit`.

You will be presented with the same options as when you would create a new grant category.

Warning: changing certain parameters may cause some existing grants to not comply with your settings anymore. When such a grant is edited, it will need to be made compliant before it can be saved.

### Removing a grant category
To delete an existing grant category, simply click the context menu next to the grant category (three dots icon) and select `Delete`.

Note: you cannot delete a category when grants still existing in this category. You'll need to delete these first before you can delete the category. Note that it may take up to 48 hours after the synchronization before the grants are actually deleted.

### The default category
There will always be a fixed default category. All imported grants will be put in this category. 

While you can update most settings of the default category, some settings will be locked.