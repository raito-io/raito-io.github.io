---
parent: Overview
title: Access Controls
nav_order: 20
permalink: /docs/overview/access_controls
---

# Access Controls

Access Controls are the core concept in Raito. An access control is the link between who (user) has which permissions to access what (data object) for how long. Most access controls are tied to a single data source.

[![Access Controls](/assets/images/Access_Controls.jpg)](/assets/images/Access_Controls.jpg){:target="_blank"}

The definition implies that the link from Access Control to every WHO-element on the left has a duration and the the link from the Access Control to every WHAT-element on the right has a (list of) permission(s).

## Access Control Actions

The action of an Access Control determines what can be linked to it.

### Grant

A grant provides access in a single data source. Its what-list can contain data objects all belonging to the same data source. The grant can also be used in the who-list of other grants and masks.

[![Grants](/assets/images/Grants.jpg)](/assets/images/Grants.jpg){:target="_blank"}

### Purpose

A purpose groups access controls from multiple data sources to be used in combination for a single purpose. A purpose therefor has no what-list, but can be used in the who-list of grants, masks and other purposes.

[![Purposes](/assets/images/Purposes.jpg)](/assets/images/Purposes.jpg){:target="_blank"}

### Mask

A mask applies a masking definition on the columns listed in its what-list. The what-links have no other permissions set. Users (or access controls) from the who-list can see the columns unmasked when having access through another access control.

[![Masks](/assets/images/Masks.jpg)](/assets/images/Masks.jpg){:target="_blank"}

### Filter

A filter filters a single table based on a filter statement.

[![Filters](/assets/images/Filters.jpg)](/assets/images/Filters.jpg){:target="_blank"}
