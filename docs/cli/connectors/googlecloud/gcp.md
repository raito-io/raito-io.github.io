---
title: Google Cloud Platform
parent: Google Cloud
grand_parent: Connectors
nav_order: 1
permalink: /docs/cli/connectors/googlecloud/platform
---

# Google Cloud

[Google Cloud](https://cloud.google.com){:target="_blank"} is a suite of cloud computing services offered by Google. It contains data storage services like Google Cloud Storage (GCS) and BigQuery. The goal of this connector is to provide an overarching data source when you for example manage multiple BigQuery data sources in Raito. In this way, the users, groups, etc. are shared among those data sources and we generate visibility in organization level access controls.

The connector is available [here](https://github.com/raito-io/cli-plugin-gcp){:target="_blank"} and supports
* Import of the GCP Organization structure (Folders, Projects) as Data Objects into Raito Cloud
* Import users, groups and service accounts from all IAM policies in the organization
* Import of GSuite users, groups and group membership into Raito Cloud
* Import of GCP Service Accounts on all projects as users into Raito Cloud
* Import of existing IAM Role grants on all levels (org, folder, project) as Access Providers  
* Granting/Revoking IAM Role bindings on resources for users, groups and service accounts based on Access Providers defined in Raito Cloud

Currently, during import of IAM bindings into Raito Cloud Access providers will only be created for the following IAM roles:
* roles/owner
* roles/editor
* roles/viewer

IAM bindings for roles other than the ones listed will be skipped unles `skip-unmanaged-iam-roles` is set to `false` in the connector configuration. In this case they will be imported but as not internalizable Access Providers meaning we only report on them but do not allow managing them within Raito Cloud.

## Prerequisites
### IAM Permissions
The Google Cloud connector requires a GCP Service Account that has the necessary permissions to retrieve projects, folders, the GCP organizatop and their respective IAM policies.

The table below describes the IAM permissions needed for the plugin to function. These permissions can be assigned either through a custom IAM role or through existing roles that contain these.

| Permission  | Purpose  |
|---|---|
| resourcemanager.organizations.get | Retrieve the organization |
| resourcemanager.organizations.getIamPolicy | Retreive who has IAM roles on the Organization level |
| resourcemanager.organizations.setIamPolicy | Revoke/Create IAM Role bindings based on Raito Access Providers. |
|---|---|
| resourcemanager.folders.get | To be able to detect folders within the organization and/or a folder. |
| resourcemanager.folders.list | To be able to detect folders within the organization and/or a folder. |
| resourcemanager.folders.getIamPolicy | Retreive who has IAM roles at the Folder level. |
| resourcemanager.folders.setIamPolicy | Revoke/Create IAM Role bindings based on Raito Access Providers. |
|---|---|
| resourcemanager.projects.get| To retrieve projects. |
| resourcemanager.projects.list | To retreive projects. |
| resourcemanager.projects.getIamPolicy | Retreive who has IAM roles at the Project level |
| resourcemanager.projects.setIamPolicy | Revoke/Create IAM Role bindings based on Raito Access Providers. |

Depending on where the role containing these permissions is bound to the serive account used in the CLI Sync, the scope of that sync will be different

| IAM Policy | Sync scope |
|---|---|
| Organization | The organization, all (sub-)folders and projects will be exposed and you will see all role assignments in Raito |
| Folder | Only the folder, its subfolders and their projects will be exposed in Raito |
| Project | Only the individual project will be exposed in Raito |
|---|---|

A detailed step-by-step guide on how to create a service account, IAM role and execute the connector can be found within our [GCP And BigQuery guide](/docs/guide/bigquery).

### GSuite domain-wide delegation
As part of the Identity Store Synchronization, the GCP CLI plugin can leverage GSuite to pull in all your users, groups and group memberships. To achieve this, the service account used during the sync needs to have domain-wide delgation set up. A complete guide on how to do that is provided [here](https://apps.google.com/supportwidget/articlehome?hl=en&article_url=https%3A%2F%2Fsupport.google.com%2Fa%2Fanswer%2F162106%3Fhl%3Den&assistant_id=generic-unu&product_context=162106&product_name=UnuFlow&trigger_context=a){:target="_blank"}.

The following oAuth scopes are required
* https://www.googleapis.com/auth/admin.directory.group.readonly
* https://www.googleapis.com/auth/admin.directory.group.member.readonly
* https://www.googleapis.com/auth/admin.directory.user.readonly

Please take note of your "Customer ID" listed under Account > Account Settings in the admin console as you'll need this to set up the CLI later on.

## GCP-specific CLI parameters

To see all parameters, type 
```bash
$> raito info raito-io/cli-plugin-gcp
```
in a terminal window.

Currently, the following configuration parameters are available:
* **gcp-organization-id** (mandatory): The id of your GCP organization.
* **gcp-serviceaccount-json-location** (optoional): The location of the GCP ServiceAccount Key file (if not set `GOOGLE_APPLICATION_CREDENTIALS` environment variable is used)
* **skip-unmanaged-iam-roles** (optional): If set to `false` (default `true`), we will import all IAM roles even the ones that are `not applicable`. They are then imported as not internalizable and used for observability purpose only. 
* **gsuite-identity-store-sync** (optional): If set to `true` (default `false`), the identity store sync step will also pull information from GSuite.
* **gsuite-customer-id** (optional): When `gsuite-identity-store-sync` is set to `true`, use this parameter to set the GSuite Customer ID.
* **gsuite-impersonate-subject** (optional): When `gsuite-identity-store-sync` is set to `true`, use this parameter to the email address of the Admin Console User to be used for domain wide delegation.
