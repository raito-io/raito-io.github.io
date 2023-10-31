---
# title: Audit
parent: Raito Cloud
nav_order: 90
has_children: false
has_toc: false
permalink: /docs/cloud/audit
---

# Audit
Raito preserves a full audit log of changes made on access controls. These changes can be made using Raito cloud or access-as-code, but also directly in the data sources. A full audit trail is available on the audit page, accessible through the main navigation on the left for access managers and admins.  An audit trail per access control is availbe under the audit tab of the access control page, again for access managers and admins, but also for the access control owners themselves.

The audit trail contains the following entries:

- The creation or the import of an access control
- A change in the name or the why of the access control. The new name will be used in every historic audit log of the access control, for consistency reasons in search
- Editing the owners of the access control: a separate entry is created for adding owners and removing owners, even when applied at the same time
- Alterations of the who and/or what-list of the access control; only changed items will be listed in the audit log. Raito both logs a change of data objects or users, as well as a change of permissions or time-bound

Per entry, Raito provides information about who has performed this action when. One can filter on the actor by applying the user-filter on top of the page.
