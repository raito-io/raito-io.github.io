---
title: Approval workflow
parent: Raito Cloud
nav_order: 60
has_children: false
has_toc: false
permalink: /docs/cloud/approval_workflow
---

# Approval workflow

The approval process for data access requests is designed to ensure that only authorized users are able to access data. This process involves the submission of a request by a user and the implementation by the owner of the data or the access control. Raito aims to assist as much as possible during the implementation.

![approval.png](/assets/images/cloud/approval.png)

## Request access

The request phase of this process can be found in detail on [Request access to data](/docs/cloud/request_access).

## Review and Approval

When a request has been created, it needs to be reviewed by the owners of the involved data objects or access controls. For every requested element, at least one owner needs to verify that the beneficiaries have a valid reason for requesting access to it. In order to do so, an owner visits the implementation task page, using one of these options:

- Visit the `Access Requests` overview page via the `Access` panel in the sidebar menu and open the implementation task
- Clicking the notification “AR-xx needs your approval” in the notification menu in the upper-right corner.
- Open the `My tasks` page via the sidebar menu.
- Use the shortcuts to  `My tasks` or  `My Access Requests` on the dashboard

### Access controls

An access control owner can hit the implement button next to the access control which will automatically add all beneficiaries to the WHO-list of the access control.

### Data object

A data object owner needs to manually implement the requested access by editing existing or creating new access controls. This is the reason why the request to access controls is recommended. Raito offers suggested access controls to implement the request to the data object owner. An access control is selected as a suggestion when he covers all data object-permission combinations of the request. Raito will also show the side-effects which would be implemented when selecting one of the suggestions.

## Statuses

An element (data object or access control) of the request can have one of the following statuses:

- Not implemented: none of the beneficiaries has access to the element
- Partially implemented: only a few beneficiaries have access to the element or beneficiaries have access for a timeframe which is shorter than the one that has been requested (*)
- Implemented: all beneficiaries have access to the element for the timeframe requested

(*) Note that in the case of a request to an access control, Raito only looks to this access control and not to access of data objects belonging to the WHAT-list of the access control.

## Close implementation task

At all times, involved users can close the task, which will result in:

- Close as cancelled: when the requestor closes the task
- Close as rejected: when nothing has been implemented yet
- Close as partially implemented: when at least one element has been partially implemented
- Close as implemented: when all elements have been implemented

When implementing the last access control from a request, you will be prompted to close the request.
