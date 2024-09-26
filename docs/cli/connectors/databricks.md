---
title: Databricks - Unity Catalog
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /docs/cli/connectors/databricks
---

# Databricks - Unity Catalog

[Databricks](https://www.databricks.com/){:target=_blank} is a cloud-based data analytics platform that integrates data engineering, data science, and machine learning tools to enable seamless processing, analysis, and exploration of large datasets, offering services like Databricks Delta Lake and Databricks Runtime.
[Unity Catalog](https://www.databricks.com/product/unity-catalog){:target=_blank} is a unified governance solution build on top of Databricks.

The connector is available [here](https://github.com/raito-io/cli-plugin-databricks){:target="_blank"} and supports
* Synchronizing Databricks users to an identity store in Raito Cloud.
* Synchronizing Databricks Unity Catalog meta data (data structure, known permissions, ...) to a data source in Raito Cloud.
* Synchronizing Databricks Unity Catalog grants from an to Raito.
* Synchronize the data usage information to Raito Cloud.

## Prerequisites
### Unity Catalog
Databricks Unity Catalog should be enabled on the account and workspaces, as this is essential to the Raito Databricks plugin.

### Authentication
We support the following authentication methods:
- OAuth 
- Personal Access Token
- Azure managed identities
- GCP ID authentication

The associated account should be admin in the Databricks account and on all workspaces.
There are no required permissions within the Databricks Unity catalog.

#### OAuth (Azure, AWS, GCP)
Authentication using OAuth, requires a valid `client_id` and `client_secret`.
The `client_id` and `client_secret` should be provided in the `databricks-client-id` and `databricks-client-secret` parameter respectively.
More information can be found on the following pages: [azure](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/auth/oauth-m2m){:target=_blank}, [aws](https://docs.databricks.com/en/dev-tools/auth/oauth-m2m.html){:target=_blank}, [gcp](https://docs.gcp.databricks.com/en/dev-tools/auth/oauth-m2m.html){:target=_blank}.

#### Personal Access Token (Azure, AWS, GCP)
To authenticate using a personal access token, the token should be provided in the `databricks-token` parameter.
More information can be found on the following pages: [azure](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/auth/pat){:target=_blank}, [aws](https://docs.databricks.com/en/dev-tools/auth/pat.html){:target=_blank}, [gcp](https://docs.gcp.databricks.com/en/dev-tools/auth/pat.html){:target=_blank}.

#### Azure managed identities
A Microsoft Entra ID service principal can be used to authenticate against the Databricks account.
To use this authentication method, `databricks-azure-client-id`, `databricks-azure-client-secret ` and `databricks-azure-tenant-id` should be provided.
More information can be found on the following [here](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/auth/azure-sp){:target=_blank}.

#### GCP ID authentication
To authenticate using GCP ID authentication, the GCP Service Account Credentials JSON or the location of these credentials on the local filesystem should be provided in the `databricks-google-credentials` parameter.
Additionally, a GCP service account e-mail should be provided in the `databricks-google-service-account` parameter.
More information can be found on the following [here](https://docs.gcp.databricks.com/en/dev-tools/google-creds-auth.html){:target=_blank}.

#### Basic Authentication
To authenticate by email and password, email and password can be provided in the `databricks-user` and `databricks-password` parameters respectively.
We recommend to use basic authentication only for testing purposes.

## Databricks-specific CLI parameters

To see all parameters, type
```bash
$> raito info raito-io/cli-plugin-databricks
```
in a terminal window.

Currently, the following configuration parameters are available:

| Configuration name                  | Description                                                                                                                                                                 | Mandatory | Default value |
|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|---------------|
| `databricks-account-id`             | The Databricks account to connect to.                                                                                                                                       | True      |               |
| `databricks-platform`               | The Databricks platform to connect to (AWS/GCP/Azure).                                                                                                                      | True      |               |
| `databricks-client-id`              | The (oauth) client ID to use when authenticating against the Databricks account.                                                                                            | False     |               |
| `databricks-client-secret `         | The (oauth) client Secret to use when authentic against the Databricks account.                                                                                             | False     |               |
| `databricks-token`                  | The Databricks personal access token (PAT) (AWS, Azure, and GCP) or Azure Active Directory (Azure AD) token (Azure).                                                        | False     |               |
| `databricks-azure-use-msi `         | `true` to use Azure Managed Service Identity passwordless authentication flow for service principals. Requires AzureResourceID to be set.                                   | False     | `false`       |
| `databricks-azure-client-id`        | The Azure AD service principal's client secret.                                                                                                                             | False     |               |
| `databricks-azure-client-secret `   | The Azure AD service principal's application ID.                                                                                                                            | False     |               |
| `databricks-azure-tenant-id`        | The Azure AD service principal's tenant ID.                                                                                                                                 | False     |               |
| `databricks-azure-environment`      | The Azure environment type (such as Public, UsGov, China, and Germany) for a specific set of API endpoints.                                                                 | False     | `PUBLIC`      |
| `databricks-google-credentials`     | GCP Service Account Credentials JSON or the location of these credentials on the local filesystem.                                                                          | False     |               |
| `databricks-google-service-account` | The Google Cloud Platform (GCP) service account e-mail used for impersonation in the Default Application Credentials Flow that does not require a password.                 | False     |               |
| `databricks-data-usage-window`      | The maximum number of days of usage data to retrieve. Maximum is 90 days.                                                                                                   | False     | 90            |
| `databricks-sql-warehouses`         | A map of deployment IDs to workspace and warehouse IDs, required to support data object tags, row level filtering and column masking (see [sql-warehouse](#sql-warehouses)) | False     |               |

## SQL Warehouses
To enable row filtering and column masking, the plugin needs access to a SQL warehouse to manage those filters and masks.
The configuration file should be update in such a way that the `databricks-sql-warehouses` parameter is a list that defines the workspace deployment ID and warehouse ID. Note that no duplicate workspace IDs are allowed.

For example:
```yaml
    databricks-sql-warehouses:
      - workspace-id: abc-12345678-fedc
        warehouse-id: 1234567891234567  
      - workspace-id: 123-12345678-fedc
        warehouse-id: 9234567891234567  
```
Where `abc-12345678-fedc` and `123-12345678-fedc` are the workspace IDs and `1234567891234567` and `9234567891234567` are the corresponding SQL warehouse IDs.