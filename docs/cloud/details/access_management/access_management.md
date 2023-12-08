---
title: Access Management
parent: Raito Cloud
nav_order: 12
has_children: true
has_toc: false
permalink: /docs/cloud/access_management
---

# Access Controls

Access Controls are a core concept in Raito. An access control is the abstract representation of who gets access to what.

When a data source is synchronized, the existing access controls are imported into Raito Cloud. This way you get a clear view on the [current state](/docs/cloud/insights/access) from day 1, including who has been [using the data](/docs/cloud/insights/usage) (or not). From there, you can start managing access controls from within Raito by editing existing ones or creating new ones.

[![Access Controls](/assets/images/Access_Controls.jpg)](/assets/images/Access_Controls.jpg){:target="_blank"}

On one side, the Access Control points to the Data Objects it applies to (the `WHAT`) and on the other side it points to `WHO` it applies to. The exact meaning of these links, and which links are possible depends on the Access Control action.

The WHO links can point to users, groups (of users) and other access controls. The latter allows you to set up an inheritance to allow for a more structured organization of your access controls. This also allows you to achieve similar goals as what you can do with groups. While groups are only read-only in Raito (typically imported from an identity store), these access controls can be easily managed from within Raito to provide full flexibility and a clear structure.

The WHO links can be limited in time. This allows you to provide access which is taken away again automatically after a specific time, to make sure that users only have the access they need at the time they need it.

There are different types of access controls, each serving their own goal:
- [Grant](/docs/cloud/access_management/grants)
- [Purpose](/docs/cloud/access_management/purposes)
- [Column Mask](/docs/cloud/access_management/masks)
- [Row-Level Filter](/docs/cloud/access_management/row-filters)