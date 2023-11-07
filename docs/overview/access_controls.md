---
parent: Overview
title: Access Controls
nav_order: 20
permalink: /docs/overview/access_controls
---

# Access Controls

Access Controls are a core concept in Raito. An access control is the abstract representation of who gets access to what.

Access Controls are initially imported from the data source. This allows you to start taking control over your access controls step by step from within Raito by editing existing ones or creating new ones.

[![Access Controls](/assets/images/Access_Controls.jpg)](/assets/images/Access_Controls.jpg){:target="_blank"}

On one side, the Access Control points to the Data Objects it applies to (the WHAT) and on the other side it points to WHO it applies to. The exact meaning of these links, and which links are possible depends on the Access Control action.

The WHO links can point to users, groups (of users) and other access controls (depending on the action). The latter allows you to set up an inheritance to allow for a more structured organization of your access controls. This also allows you to achieve similar goals as what you can do with groups. While groups are only read-only in Raito (typically imported from an identity store), these access controls can be easily managed from within Raito to provide full flexibility and a clear structure.

The WHO links can be limited in time. This allows you to provide access which is taken away again automatically after a specific time, to make sure that users only have the access they need at the time they need it.

## Access Control Actions

The action of an Access Control defines the exact meaning of the access control.

### Grant

A grant provides access to specific data objects in a data source. 

The what-links also define the permissions that the grant provides to the users.

When defining the who-links, you will have the option to immediately grant the access or to pre-approve the access, which mean that the access will automatically be granted when the user creates an Access Request for this Grant Access Control.

[![Grants](/assets/images/Grants.jpg)](/assets/images/Grants.jpg){:target="_blank"}

### Purpose

A purpose groups access controls (potentially from multiple data sources) to be used in combination for a single purpose. A purpose therefor has no what-list, but can be used in the who-list of grants, masks and other purposes.

Purposes allow you to have a separation of concern between the lower-level data owners, who create grants to expose their data products in a single data source, and the purpose owners, who gather data from (potentially) multiple data products/sources together to serve a higher-level purpose.

Just like with grants, access to a purpose can also be pre-approved instead of granted immediately. 

[![Purposes](/assets/images/Purposes.jpg)](/assets/images/Purposes.jpg){:target="_blank"}

### Mask

A (column) mask applies a masking rule on the columns listed in its what-list. Users in the who-list can see the columns unmasked, considering that they receive access to the parent table through a Grant Access Control.

Currently, masks are only imported from the data sources and cannot be edited or created from within Raito.

[![Masks](/assets/images/Masks.jpg)](/assets/images/Masks.jpg){:target="_blank"}

### Filter

A (row-level) filter is applied to tables (what-list) to define which rows should be visible to the users in the who-list.

Currently, filters are only imported from the data sources and cannot be edited or created from within Raito.

[![Filters](/assets/images/Filters.jpg)](/assets/images/Filters.jpg){:target="_blank"}
