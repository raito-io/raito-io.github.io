---
title: Azure
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /docs/cli/connectors/azure
nav_exclude: true
---

# Azure

[Microsoft Azure](https://azure.microsoft.com){:target="_blank"}, often referred to as Azure, is a cloud computing platform run by Microsoft, which offers access, management, and development of applications and services through global data centers. It can be used as a cloud data lake/warehouse or lakehouse using services like Azure Data Lake Storage, Azure Databricks etc.

The connector is available [here](https://github.com/raito-io/cli-plugin-azure){:target="_blank"} and supports
* Import of storage accounts (Gen2) turning their containers and blobs into Raito Data Objects
* Import users and groups from Azure Active Directory
* Granting/Revoking IAM Roles on resources for users and groups based on Access Providers defined in Raito Cloud

## Azure Service compatibility

| Service | Supported |
| ------- | --------- |
| [Azure Data Lake Storage Gen2](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction){:target="_blank"} | RBAC for containers (no ACL support) |

## Prerequisites
### Azure Active Directory App Registration
For the Raito CLI to authenticate to your Azure environment and get the necesarry authorizations to perform its various tasks, you will need to register a client application in Azure Active Directory as explained [here](https://learn.microsoft.com/en-us/azure/healthcare-apis/register-application){:target="_blank}. Once you have finished creating the App registration, take note of the following properties as you will need them later on to set up the Raito CLI
* Application (client) ID
* Directory (tenant) ID

In addition, you will need a client secret to conclude the CLI configuration. To obtain this value, navigate to "client credentials" found on the App registration detail page and then add a client secret. Make sure to take note of the secret value as you can not retrieve it later on  Now that the app registration is set up, we need to configure its authorization scope. In the app registration go to Manage >> API permissions and verify/set up the following permissions

| API | Type | Permission |
| --- | ---- | ---------- |
| Microsoft Graph | Application | Group.Read.All |
| | | User.Read.All |
| | | User.Export.All |
| | | RoleAssignmentSchedule.Read.Directory |
| --- | ---- | ---------- |
| Azure Storage | Delegated | user_impersonation |
| --- | ---- | ---------- |

### Subscription IAM
Next to the app registration and API permissions, you need to give the application the necessary roles on your Azure Subscription to perform the sync with Raito. To do so go to your azure portal and select Subscriptions then select the one from the list you want to sync. It is also a good time to take note of the subscription Id as this is the final parameter you will need to configure the azure plugin. In the Access Control (IAM) section you should assign the following roles to the application you created in the previous step.

| Role | Purpose |
| ---- | ------- |
| Reader | List resources like Resource Groups/Storage accounts/containers |
| Storage Blob Data Reader | List folders and Files in storage containers, this is used to sync Azure Storage with raito |
| Role Based Access Control Administrator (Preview) | This role allows the CLI to materialise Access Controls defined in Raito into Azure IAM roles |
| Log Analytics Reader | Grant the app the rights to query the Log Analytics API for data usage synchronisation |
| ---- | ------- |

Note that you can also define these roles on Resource group or even the Storage Account level if you do not wish to synchronise your full Azure subscription with raito.

## Azure-specific CLI parameters

To see all parameters, type 
```bash
$> raito info raito-io/cli-plugin-azure
```
in a terminal window.

Currently, the following configuration parameters are available:
* **ad-tenantid** (mandatory): The ID of your Azure ActiveDirectory tenant.
* **ad-clientid** (mandatory): The Application (client) ID of the Azure AD App registration to be used.
* **ad-secret** (mandatory): The client secret of the Azure AD application.
* **azure-subscription-id** (mandatory): The ID of the Azure Subscription which will be synced with Raito. 
