---
title: Slack
parent: Integrations
grand_parent: Raito Cloud
nav_order: 10
has_children: false
has_toc: false
permalink: /docs/cloud/integrations/slack
---

# Slack Integration
## Introduction
The Raito Slack integration allow you to:
- Receive notifications from Raito directly in Slack
- Request access to data right from within your Slack workspace

The setup of the Raito Slack integration requires two steps:
1. An administrator needs to connect your Raito instance with your Slack workspace.
2. Each Raito user needs to connect their Raito user account to their Slack user account.

These steps are described in more detail in the following two sections.

## Connecting your Slack Workspace
The first step to start using the Slack Integration is to connect your Raito instance to your Slack workspace. 

To do this, as a user with the global `Admin` role, go to `Administration > Settings` and click the `Slack integration` option.  
Now click the `Install` button on the right.  
You will be redirected to the a Slack page requesting to connect with your Slack workspace. If you are not the owner of the Slack workspace, a request will be sent to the owners of your Slack workspace to approve this.

Once the connection is set up, Raito users will now be able to connect their account to their Slack account.

## Connecting your Slack account
After an admin has connected Raito with your Slack workspace, you can connect your Raito user account to your Slack user account.

To do this, in Slack, go to `Apps` and choose the `Raito` application. On the application overview page, click the `Connect` button. This will open Raito Cloud on the Slack preferences page. Now click `Connect` here as well to fully establish the connection.

And you're all set up now!

## Configuring notifications
After you connected your account with Slack, you will be able to configure which notifications you want to receive in Slack. This is explained in the [Notifications](/docs/cloud/user_profile#notifications) section.

## Requesting access
From now on, you're also able to request access to data by using the `/raito` command in Slack.

In any slack channel, simply type `/raito request` and press Enter. A dialog will pop up guiding you through the process of picking the data your want to request access to, similarly as you would do in Raito itself. 

Note: alternatively to `request` you could also use `ra`, `ar`, `request access` or `access request` to start the access request process.