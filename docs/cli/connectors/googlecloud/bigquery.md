---
title: Google Cloud BigQuery
parent: Google Cloud
grand_parent: Connectors
nav_order: 2
permalink: /docs/cli/connectors/googlecloud/bigquery
---

# BigQuery

[Google Cloud BigQuery](https://cloud.google.com/bigquery){:target="_blank"} is a fully-managed serverless data warehouse, part of the Google Cloud Platform, that enables scalable analysis over petabytes of data.

The connector is available [here](https://github.com/raito-io/cli-plugin-bigquery){:target="_blank"} and supports
* Import of BigQuery Datasets, Tables and Columns as Data Objects into Raito Cloud
* Import users, groups and service accounts access rights from the Project, Dataset and Table IAM policies
* Import of GSuite users, groups and group membership into Raito Cloud (optional)
* Import of GCP Service Accounts from the GCP project
* Granting/Revoking IAM Role bindings on resources for users, groups and service accounts based on Access Providers defined in Raito Cloud

Currently, during import of IAM bindings into Raito Cloud Access providers will only be created for the following IAM roles:
* roles/owner
* roles/editor
* roles/viewer
* roles/bigquery.*

IAM bindings for roles other than the ones listed will be skipped unless `skip-unmanaged-iam-roles` is set to `false` in the connector configuration. In this case they will be imported, but as not-internalizable Access Providers, meaning we only report on them, but do not allow managing them within Raito Cloud.

## Prerequisites
### IAM Permissions
The BigQuery connector requires a GCP Service Account that has the necessary permissions to retrieve the GCP Project IAM policy as well as the IAM policies for all BQ datasets and tables in the project.

The service account needs to have the following roles on the GCP project
* roles/resourcemanager.projectIamAdmin
* roles/bigquery.admin

A detailed step-by-step guide on how to create a service account, IAM role and execute the connector can be found within our [GCP And BigQuery guide](/docs/guide/bigquery).

### GSuite domain-wide delegation (optional)
This prerequisite is optional and only necessary if you are only synchronizing a single BigQuery project. If you use the BigQuery connector in conjunction with the [Google Cloud Platform](/docs/cli/connectors/googlecloud/platform), you can skip this.

As part of the Identity Store Synchronization, the GCP CLI plugin can leverage GSuite to pull in all your users, groups and group memberships. To achieve this, the service account used during the sync needs to have domain-wide delegation set up. A complete guide on how to do that is provided [here](https://apps.google.com/supportwidget/articlehome?hl=en&article_url=https%3A%2F%2Fsupport.google.com%2Fa%2Fanswer%2F162106%3Fhl%3Den&assistant_id=generic-unu&product_context=162106&product_name=UnuFlow&trigger_context=a){:target="_blank"}.

The following oAuth scopes are required
* https://www.googleapis.com/auth/admin.directory.group.readonly
* https://www.googleapis.com/auth/admin.directory.group.member.readonly
* https://www.googleapis.com/auth/admin.directory.user.readonly

Please take note of your `Customer ID` listed under `Account > Account Settings` in the admin console as you'll need this to set up the CLI later on.

## BigQuery-specific CLI parameters

To see all parameters, type 
```bash
$> raito info raito-io/cli-plugin-bigquery
```
in a terminal window.

Currently, the following configuration parameters are available:
* **gcp-project-id** (mandatory): The ID of your GCP project for which you want to sync BigQueryy.
* **gcp-serviceaccount-json-location** (optional): The location of the GCP ServiceAccount Key file (if not set, the `GOOGLE_APPLICATION_CREDENTIALS` environment variable is used)
* **bq-include-hidden-datasets** (optional): when set to `true`, hidden datasets will also be imported into Raito
* **bq-catalog-enabled** (optional): when set to `true`, support for masking would be enabled
* **skip-unmanaged-iam-roles** (optional): If set to `false` (default `true`), we will import all IAM roles even the ones that are `not applicable`. They are then imported as not internalizable and used for observability purpose only. 
* **gsuite-identity-store-sync** (optional): If set to `true` (default `false`), the identity store sync step will also pull information from GSuite.
* **gsuite-customer-id** (optional): When `gsuite-identity-store-sync` is set to `true`, use this parameter to set the GSuite Customer ID.
* **gsuite-impersonate-subject** (optional): When `gsuite-identity-store-sync` is set to `true`, use this parameter to the email address of the Admin Console User to be used for domain wide delegation.

## Enable masking for BigQuery
To enable support for masking in BigQuery, the [Google Cloud Data Catalog AP](https://cloud.google.com/data-catalog/docs) and [BigQuery Data Policy API](https://cloud.google.com/bigquery/docs/reference/bigquerydatapolicy/rest) should be enabled within the GCP project.

Furthermore, the service account should be configured to have the following permissions
```
bigquery.dataPolicies.create
bigquery.dataPolicies.delete
bigquery.dataPolicies.get
bigquery.dataPolicies.getIamPolicy
bigquery.dataPolicies.list
bigquery.dataPolicies.setIamPolicy
bigquery.dataPolicies.update
datacatalog.categories.getIamPolicy
datacatalog.categories.setIamPolicy
datacatalog.entries.create
datacatalog.entries.delete
datacatalog.entries.get
datacatalog.entries.getIamPolicy
datacatalog.entries.list
datacatalog.entries.setIamPolicy
datacatalog.entries.update
datacatalog.entries.updateTag
datacatalog.taxonomies.create
datacatalog.taxonomies.delete
datacatalog.taxonomies.get
datacatalog.taxonomies.getIamPolicy
datacatalog.taxonomies.list
datacatalog.taxonomies.setIamPolicy
datacatalog.taxonomies.update
```

Once the APIs are enabled and the service account has provided the above defined permissions, you can enable masking by setting **bq-catalog-enabled** to `true`.   