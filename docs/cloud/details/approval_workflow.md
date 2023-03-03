---
title: Approval workflow
parent: Raito Cloud
nav_order: 60
has_children: false
has_toc: false
permalink: /docs/cloud/approval_workflow
---

# Approval workflow

The approval process for data access requests is designed to ensure that only authorized users are able to access data. This process involves the submission of a request by a user and the - mostly automated - creation of an implementation proposal, followed by the validation by the owner of the data. Afterwards, the implementation is fully automated.

![approval.png](/assets/images/cloud/approval.png)

## Request access

The request phase of this process can be found in detail on [Request access to data](/docs/cloud/request_access).

## Propose a solution

Where possible, a solution is proposed automatically. If not, a data owner needs to manually create one. Such a proposal can consist of multiple implementation steps of the following types:

- **Add a user to an access provider**: a user is added to the who-list of an access provider and will, as such, obtain access to all data objects in the what-list with their respective permissions.
- **Add a group or access provider to an access provider**: a group or access provider is added to the who-list of an access provider. All users in the group or who-list of the newly added access provider, will obtain access to all data objects in the what-list with their respective permissions.
- **Add a data object to an access provider**: a data object is added to the what-list of an access provider and permissions are set for the data object. As a consequence, all users in the who-list will obtain access to this data object with the permissions.
- **Edit the permission of a data object in an access provider**: the permission from a data object in the what-list of an access provider is updated, resulting in new permissions for all users in the who-list of that access provider for the data object.

## Review and Approval

When a proposal has been created (manually or automatically), it needs to be reviewed by the owners of the involved data objects. For every data object, at least one owner needs to verify that the user has a valid reason for requesting access to the data. In order to do so, an owner:

- Visits the approval task page, using one of these options:
    - The access request
        - Visit the `Access Requests` overview page via the `Access` panel in the sidebar menu.
        - Click the link of the relevant access request
        - Open the approval task at the bottom
    - Clicking the notification “AR-xx needs your approval” in the notification menu in the upper-right corner.
    - Open the `My tasks` page via the sidebar menu.
- At the bottom of the page, an owner approves or rejects all subtasks with respect to the data objects he or she owns. The `Approve all` or `Reject all` options are available to users that are owner on all the data objects involved in the request.
- Send approval via the button in the upper-right corner. The owner will be prompted to validate this action, as this is the final action before an automated implementation.