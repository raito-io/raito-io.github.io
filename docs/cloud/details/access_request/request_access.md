---
title: Request Access
parent: Access Requests
grand_parent: Raito Cloud
nav_order: 1
has_children: false
permalink: /docs/cloud/requests/request_access
---

# Request access to data

Raito enables collaboration in data access management. This starts from the request to access data. Every user, regardless of its role in Raito, can request access to data. An access request is initiated by clicking the button “Request access” on the dashboard or on the access request page or by shopping for data directly on a data object or access control page.

Requesting access to data can be done in 5 easy steps:

## The type of request

To start a request, you need to select which type of request you want to raise. It is up to your Raito admin to determine which types of requests can be raised. Possible types of requests are:

- **Access to an access control**: you know to which access control(s) you want to be added
- **Access to a data object:** you know to which data object(s) you want to obtain access to

This step is ignored when you shop for data directly, as the type of the request (access control or data object) will already be preselected for you.

## What

Now you will be selecting what data you want access to. Depending on the type of request, this step will be slightly different:

- **Access to an access control**: select 1 or more access controls. You can combine multiple actions (grants and purposes) from multiple data sources at once
- **Access to a data object:** select 1 or more data objects from one or more data sources and define the permissions you want to obtain.

## Who

Next, you have to select the beneficiaries for whom you are requesting access. Raito allows to request access for:

- Users:  By default, Raito pre-selects your name. You can however raise a request on behalf of anyone and you can even remove yourself from this who-list.
- Groups: You can select groups from Identity stores which are linked to the Data Sources you are asking access to.

*Note* The beneficiary of an access request, can also be an access control. This option is not available when directly creating an access request, but is automatically created when you add an access control, that you don't own yourself, in the what-list of another access control.

Raito also allows you to define a validity period. Access will be revoked automatically after expiration of this time period which is the same for all users, groups and access controls in the request.

## Why

Here, you should explain the reason why you require access to the data. This is important for the data owners or access control owners to be able to make an informed decision about the approval and implementation of your request.

## Review

Before your access request is sent to the next stage in the process, you are presented with a final overview of your request so you can do a final review.
