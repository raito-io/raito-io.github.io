---
title: Audit
parent: Access Management
grand_parent: Raito Cloud
nav_order: 90
has_children: false
has_toc: false
permalink: /docs/cloud/audit
---

# Audit
Raito preserves a full audit log of changes made on access controls, no matter whether these changes were done in Raito cloud itself or directly on the data source. A full audit trail is available on the `Audit` page, accessible through the main navigation on the left for access managers and admins. An audit trail per access control is available under the audit tab of the access control page, again for access managers and admins, but also for the access control owners themselves.

The audit trail contains the following entries:

- The creation or the import of an access control
- A change in the name or the why of the access control. The new name will be used in every historic audit log of the access control, for consistency reasons in search
- Editing the owners of the access control: a separate entry is created for adding owners and removing owners, even when applied at the same time
- Changes to the who and/or what-list of the access control; only changed items will be listed in the audit log.

Per entry, Raito provides information about who has performed this action and when. You can filter on the actor by applying the user-filter on top of the page.
