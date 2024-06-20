---
title: AWS - First sync with Raito Cloud
nav_order: 40
parent: Guides
permalink: /docs/guide/aws
---

# Synchronizing AWS for the first time

In this guide, we'll walk you through an example of how to connect Raito Cloud to your AWS S3 (Glue) warehouse through the Raito CLI. We'll
- make sure that Raito CLI is installed and available
- log into Raito Cloud and create a data source. Optionally we create an organization identity store
- configure Raito CLI to connect to Raito Cloud and synchronize with the previously-created data source
- run a first sync

For this guide, you will need access to Raito Cloud and you also need access to AWS.
We assume that you're able to create an AWS IAM user or AWS IAM role that can be used by the RAITO CLI.

## Raito CLI installation

To install the Raito CLI, simply run the following command in a terminal window:
```bash
$> brew install raito-io/tap/cli
```

Check that everything is correctly installed by running
```bash
$> raito --version
```

If you want more information about the installation process, or you need to troubleshoot an issue, you can find [more information here](/docs/cli/installation).

## Create an organization identity store (optional)

If you are using AWS organization, you may want to sync the users and groups defined in the organization. 
In that case, are required to create a new Identity Store. 

In the left navigation pane, go to `Identities` > `Identity Stores`. You should see a button on the top-right named `Add Identity Store`. This will guide you through a short wizard to create a new identity store. The main things that you will need to configure are:

* `Identity store type`. Select AWS Organization.
* `Identity store name`. Give your identity store a good descriptive name, separating it from other identity stores. For this example, we'll choose 'AWS Organization'.
* `Identity store description`. Accompany your identity store with a meaningful description.

## Create an AWS account Data Source

To create a new Raito Data source, go to `Data Sources` > `All data sources`, in the left navigation pane. You should see a button on the top-right named `Add data source`. This will guide you through a short wizard to create a new data source. The main things that you will need to configure are:

* `Data source type`. Select AWS.
* `Data source name`. Give your data source a good descriptive name, separating it from other data sources. For this example, we'll choose 'AWS Test account'.
* `Data source description`. Accompany your data source with a meaningful description.
* `Connection method`. Select whether you want to use the Raito hosted cloud version of the CLI or one managed by yourself, which is recommended. In this example we indeed select 'CLI'.

When you created an organization identity store, you need to link the previously created IS with the newly created data source.
Navigate to the newly created data source. In the menu you can open on the right top of the page, you should see the ability to `Link to indeitity stores`.
Add the aws organization identity store and apply the changes.

## AWS credentials

To connect to AWS, you need to provide the Raito CLI with the necessary credentials.
The AWS account connector requires at credentials to the account where you want to sync S3/glue. 
Preferably you create a new profile in your `~/.aws/credentials` file. More information can be found [here](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html){:target="_blank"}

Ensure the policy defined on the [AWS Account connector](/docs/cli/connectors/aws/account#AWS-Credentials) is attached to the role/user.

When using the optional AWS organization sync, credentials to the master account are required. 
Those credentials should be available by using another profile
The following policy should be attached to the user/role connecting to the master account:

{% raw %}
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ssoInstanceReadWrite",
      "Effect": "Allow",
      "Action": [
        "sso:CreatePermissionSet",
        "sso:DescribePermissionSet",
        "sso:DescribePermissionSetProvisioningStatus",
        "sso:GetInlinePolicyForPermissionSet",
        "sso:GetPermissionsBoundaryForPermissionSet",
        "sso:GetPermissionSet",
        "sso:ListAccountsForProvisionedPermissionSet",
        "sso:ListCustomerManagedPolicyReferencesInPermissionSet",
        "sso:ListManagedPoliciesInPermissionSet",
        "sso:ListPermissionSetProvisioningStatus",
        "sso:ListPermissionSets",
        "sso:ListPermissionSetsProvisionedToAccount",
        "sso:DeleteInlinePolicyFromPermissionSet",
        "sso:DeletePermissionSet",
        "sso:ProvisionPermissionSet",
        "sso:PutInlinePolicyToPermissionSet",
        "sso:AttachCustomerManagedPolicyReferenceToPermissionSet",
        "sso:AttachManagedPolicyToPermissionSet",
        "sso:DeletePermissionsBoundaryFromPermissionSet",
        "sso:DetachCustomerManagedPolicyReferenceFromPermissionSet",
        "sso:DetachManagedPolicyFromPermissionSet",
        "sso:PutPermissionsBoundaryToPermissionSet",
        "sso:UpdatePermissionSet",
        "sso:TagResource",
        "sso:ListAccountAssignments",
        "sso:ListAccountAssignmentsForPrincipal",
        "sso:CreateAccountAssignment",
        "sso:DeleteAccountAssignment"
      ],
      "Resource": [
        "arn:aws:sso:::instance/ssoins-${instanceId}"
      ]
    },
    {
      "Sid": "ssoPermissionSetReadWrite",
      "Effect": "Allow",
      "Action": [
        "sso:ListAccountAssignments",
        "sso:ListAccountsForProvisionedPermissionSet",
        "sso:ListManagedPoliciesInPermissionSet",
        "sso:ListTagsForResource",
        "sso:DescribePermissionSet",
        "sso:GetInlinePolicyForPermissionSet",
        "sso:GetPermissionsBoundaryForPermissionSet",
        "sso:GetPermissionSet",
        "sso:CreateAccountAssignment",
        "sso:DeleteAccountAssignment",
        "sso:DeletePermissionSet",
        "sso:ProvisionPermissionSet",
        "sso:AttachCustomerManagedPolicyReferenceToPermissionSet",
        "sso:AttachManagedPolicyToPermissionSet",
        "sso:DeletePermissionsBoundaryFromPermissionSet",
        "sso:DeletePermissionsPolicy",
        "sso:DetachCustomerManagedPolicyReferenceFromPermissionSet",
        "sso:DetachManagedPolicyFromPermissionSet",
        "sso:PutPermissionsBoundaryToPermissionSet",
        "sso:PutPermissionsPolicy",
        "sso:UpdatePermissionSet",
        "sso:TagResource",
        "sso:DeleteInlinePolicyFromPermissionSet",
        "sso:ListCustomerManagedPolicyReferencesInPermissionSet",
        "sso:PutInlinePolicyToPermissionSet",
        "sso:ListPermissionSetProvisioningStatus",
        "sso:ListPermissionSets",
        "sso:ListPermissionSetsProvisionedToAccount",
        "sso:DescribePermissionSetProvisioningStatus"
      ],
      "Resource": [
        "arn:aws:sso:::permissionSet/ssoins-${instanceId}/*"
      ],
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/creator": "RAITO"
        }
      }
    },
    {
      "Sid": "ssoPermissionSetCreate",
      "Effect": "Allow",
      "Action": [
        "sso:CreatePermissionSet"
      ],
      "Resource": [
        "arn:aws:sso:::permissionSet/ssoins-${instanceId}/*"
      ],
      "Condition": {
        "StringEquals": {
          "aws:RequestTag/creator": "RAITO"
        }
      }
    },
    {
      "Sid": "ssoPermissionSetTag",
      "Effect": "Allow",
      "Action": [
        "sso:TagResource"
      ],
      "Resource": [
        "arn:aws:sso:::permissionSet/ssoins-${instanceId}/*"
      ],
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/creator": "RAITO",
          "aws:RequestTag/creator": "RAITO"
        }
      }
    },
    {
      "Sid": "ssoListTags",
      "Effect": "Allow",
      "Action": [
        "sso:ListTagsForResource"
      ],
      "Resource": [
        "arn:aws:sso:::permissionSet/ssoins-${instanceId}/*",
        "arn:aws:sso:::instance/ssoins-${instanceId}"
      ]
    },
    {
      "Sid": "accountAssignment",
      "Effect": "Allow",
      "Action": [
        "sso:CreateAccountAssignment",
        "sso:DeleteAccountAssignment",
        "sso:ProvisionPermissionSet",
        "sso:ListAccountAssignments"
      ],
      "Resource": [
        "arn:aws:sso:::account/*"
      ]
    },
    {
      "Sid": "identitystoreRead",
      "Effect": "Allow",
      "Action": [
        "identitystore:ListGroupMemberships",
        "identitystore:ListGroupMembershipsForMember",
        "identitystore:ListGroups",
        "identitystore:ListUsers",
        "identitystore:DescribeGroup",
        "identitystore:DescribeGroupMembership",
        "identitystore:DescribeUser",
        "identitystore:GetGroupId",
        "identitystore:GetGroupMembershipId",
        "identitystore:GetUserId",
        "identitystore:IsMemberInGroups"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "enrichRoles",
      "Effect": "Allow",
      "Action": [
        "sso:ListInstances",
        "sso:ListPermissionSets",
        "sso:DescribePermissionSet",
        "sso:ListAccountAssignments"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "identitycenter",
      "Effect": "Allow",
      "Action": [
        "sso:ListInstances",
        "sso:DescribeInstance"
      ],
      "Resource": [
        "arn:aws:sso:::instance/*"
      ]
    },
    {
      "Sid": "identitystore",
      "Effect": "Allow",
      "Action": [
        "identitystore:ListGroups",
        "identitystore:ListUsers",
        "identitystore:ListGroupMemberships",
        "identitystore:ListGroupMembershipsForMember",
        "identitystore:DescribeGroup",
        "identitystore:DescribeGroupMembership",
        "identitystore:DescribeUser",
        "identitystore:GetGroupId",
        "identitystore:GetGroupMembershipId",
        "identitystore:GetUserId",
        "identitystore:IsMemberInGroups"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
```
{% endraw %}

# Raito CLI Configuration

To configure the Raito CLI to synchronize your AWS S3 (Glue) warehouse, start by creating a file with the name `raito.yml` and edit it to look like this:

{% raw %}
```yaml
api-user: "{{RAITO_USER}}"
api-secret: "{{RAITO_API_KEY}}"
domain: "{{DOMAIN}}"

targets:
  
  # Optional aws organization identity store sync if organization is enabled
  - name: aws-organization
    connector-name: raito-io/cli-plugin-aws-organization
    identity-store-id: "<identity-store-id-of-organization-identity-store>"
    
    aws-account-id: "<master account id>"
    aws-profile: "<aws-profile connecting to the master account>"
    aws-region: "<aws region of the identity center>"
  # End optional config

  - name: aws-account
    connector-name: raito-io/cli-plugin-aws-account
    data-source-id: "<data-source-id>"
    identity-store-id: "<identity-store-id>"

    aws-profile: "<aws-profile connecting to the account to sync>"
    aws-account-id: "<account id>"
    aws-regions: "<comma separated list of regions to sync>"

    # Optional configuration if organization is enabled
    aws-organization-profile: "<master account id>"
    aws-organization-region: "<aws region of the identity center>"
    aws-organization-identity-center-instance-arn: "<arn of the identity-center instance>"
    aws-organization-identity-store: "<identity store id of the organization identity store>"
    # End optional config

    aws-s3-cloudtrail-bucket: "raito-cloudtrail"
    aws-s3-exclude-buckets: "raito-cloudtrail,cdk-hnb659fds-assets-077954824694-eu-central-1"
    aws-s3-enabled: false
    aws-glue-enabled: true
    aws-access-managed-policy-excludes: Amazon.+,AWS.+,cdk.+,AdministratorAccess,AccessAnalyzer.+
    aws-access-role-excludes: AWS.+,aws.+,cdk.+,AccessAnalyzer.+
```
{% endraw %}

It contains
- a section to configure the connection to Raito Cloud: `api-user`, `api-secret`, and `domain`. `domain` is the part of the URL from your Raito Cloud instance (e.g. https://`domain`.raito.cloud). `api-user` and `api-secret` are the login credentials for your Raito Cloud instance.
- `targets` has one optional target defined for the AWS organization connector and one for AWS account connector. You can copy paste this section from the snippet that is shown on the page of the respective newly created data source in Raito cloud. The first part defines the target, connector and corresponding object ID's in Raito Cloud (i.e. `data-source-id` and `identity-store-id`). The second part is the configuration specific to the connectors.

Feel free to customize this configuration further. Find more information in the sections about [general configuration](/docs/cli/configuration#command-specific-parameters),  [AWS organization-specific configuration](/docs/cli/connectors/aws/organization#AWS-Organization-specific-CLI-parameters) and [AWS account-specific configuration](/docs/cli/connectors/aws/account#AWS-Account-specific-CLI-parameters).
Remember that you can use double curly brackets to reference environment variables, like we did for the `api-user` field and others in the example.

## Raito run

Now that our data source is set up and we have our Raito CLI configuration file, we can run the Raito CLI with:

```bash
$> raito run
```

This will download all data objects, users, access controls (nameless bindings) and data usage information from BigQuery and GCP and upload it to Raito Cloud. It will also get the access controls created in Raito Cloud and push them as nameless bindings to BigQuery and GCP, but since you've started out with an empty instance, this is not relevant at this point.

See [here](/docs/cli/intro) for more information about what happens exactly. 

## Check results in Raito Cloud

When the `raito run` command finished successfully, go back to Raito Cloud.

On the dashboard you will now see some initial insights that we extract from the data that was synchronized. If you go to `Data Sources` and visit the data sources that you have created before, you should be able to see when the last sync was done in the `General information` section. When you scroll down, you can also navigate through the data objects in your BigQuery warehouse.

When you go to `Identities` in the navigation bar, you can see all the users imported from GSuite. Under `Access Controls`, under grants, you have an overview of all the IAM Role grants both on GCP organization level as well as your BigQuery tables and datasets. If you click on one, you get a detailed view of who belongs to that access control, and what they have access to with which permissions.

Now that you have synchronized your GCP organization and the first BigQuery project, you can repeat the steps to connect all your other BigQuery projects to the same GCP data source by creating new BigQuery data sources in Raito and configuring them using the same steps as before.

{% include slack.html %}