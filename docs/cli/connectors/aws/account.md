---
title: AWS Account
parent: AWS
grand_parent: Connectors
nav_order: 2
permalink: /docs/cli/connectors/aws/account
---

# AWS Account

[AWS](https://aws.amazon.com/){:target="_blank"} is a cloud-based infrastructure provider. 
This Raito plugin enables access management for [AWS S3](https://aws.amazon.com/s3/){:target="_blank"}.

The connector is available [here](https://github.com/raito-io/cli-plugin-aws-account){:target="_blank"} and supports
* Import users and groups from IAM in the AWS account to an identity store in Raito Cloud.
* Import AWS S3 meta data (S3 buckets, objects inside those buckets, ...) via S3 itself or via Glue to a data source in Raito Cloud.
* Export access controls from Raito Cloud into IAM/S3 permissions (as IAM roles, IAM policies, S3 Access Points and Permission Sets).
* Import access controls from IAM/S3 permissions Raito Cloud (IAM roles, IAM policies, S3 Access Points and Permission Sets).
* Import the data usage from CloudTrail to Raito Cloud.

## Prerequisites
### AWS Credentials
The AWS account connector requires AWS credentials to access the AWS account.
The credentials can be provided by one of the following options:
1. Environment variables: The environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and (optionally) `AWS_SESSION_TOKEN` are used.
2. Shared credentials file. Credentials defined on `~/.aws/credentials` will be used. A profile can be defined with `aws-profile`.
3. If running on an Amazon EC2 instance, IAM role for Amazon EC2.

Ensure the role/user has the following policy document attached:

{% raw %}
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1718867172297",
      "Action": [
        "iam:GetAccountEmailAddress",
        "iam:GetAccountName",
        "iam:GetAccountSummary",
        "iam:GetGroup",
        "iam:GetGroupPolicy",
        "iam:GetInstanceProfile",
        "iam:GetPolicy",
        "iam:GetPolicyVersion",
        "iam:GetRole",
        "iam:GetRolePolicy",
        "iam:GetUser",
        "iam:GetUserPolicy",
        "iam:ListAccountAliases",
        "iam:ListAttachedGroupPolicies",
        "iam:ListAttachedRolePolicies",
        "iam:ListAttachedUserPolicies",
        "iam:ListEntitiesForPolicy",
        "iam:ListGroupPolicies",
        "iam:ListGroups",
        "iam:ListGroupsForUser",
        "iam:ListPolicies",
        "iam:ListPoliciesGrantingServiceAccess",
        "iam:ListPolicyTags",
        "iam:ListPolicyVersions",
        "iam:ListRolePolicies",
        "iam:ListRoleTags",
        "iam:ListRoles",
        "iam:ListUserPolicies",
        "iam:ListUserTags",
        "iam:ListUsers"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::${Account}:*"
    },
    {
      "Sid": "Stmt1718867335513",
      "Action": [
        "iam:CreatePolicy",
        "iam:CreatePolicyVersion",
        "iam:CreateRole",
        "iam:DeletePolicy",
        "iam:DeletePolicyVersion",
        "iam:DeleteRole",
        "iam:DeleteRolePermissionsBoundary",
        "iam:DeleteRolePolicy",
        "iam:PutGroupPolicy",
        "iam:PutRolePermissionsBoundary",
        "iam:PutRolePolicy",
        "iam:PutUserPermissionsBoundary",
        "iam:PutUserPolicy",
        "iam:TagPolicy",
        "iam:TagRole",
        "iam:UntagPolicy",
        "iam:UntagRole",
        "iam:UpdateAssumeRolePolicy",
        "iam:UpdateRole",
        "iam:UpdateRoleDescription"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::${Account}:*"
    },
    {
      "Sid": "Stmt1718867545031",
      "Action": [
        "s3:CreateAccessPoint",
        "s3:DeleteAccessPoint",
        "s3:DeleteAccessPointPolicy",
        "s3:GetAccessPoint",
        "s3:GetAccessPointPolicy",
        "s3:GetAccessPointPolicyStatus",
        "s3:GetBucketLocation",
        "s3:GetBucketLogging",
        "s3:GetBucketPolicy",
        "s3:GetBucketPolicyStatus",
        "s3:GetBucketPublicAccessBlock",
        "s3:GetBucketTagging",
        "s3:GetBucketVersioning",
        "s3:GetDataAccess",
        "s3:GetMultiRegionAccessPoint",
        "s3:GetMultiRegionAccessPointPolicy",
        "s3:GetMultiRegionAccessPointPolicyStatus",
        "s3:GetMultiRegionAccessPointRoutes",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:GetObjectAttributes",
        "s3:GetObjectTagging",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAttributes",
        "s3:ListAccessPoints",
        "s3:ListAllMyBuckets",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:ListMultiRegionAccessPoints",
        "s3:ListTagsForResource",
        "s3:PutAccessPointPolicy",
        "s3:PutBucketPolicy",
        "s3:TagResource",
        "s3:UntagResource"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Sid": "Stmt1718874249842",
      "Action": [
        "glue:DescribeEntity",
        "glue:GetDatabase",
        "glue:GetDatabases",
        "glue:GetSchema",
        "glue:GetSchemaByDefinition",
        "glue:GetSchemaVersion",
        "glue:GetSchemaVersionsDiff",
        "glue:GetTable",
        "glue:GetTableOptimizer",
        "glue:GetTableVersion",
        "glue:GetTableVersions",
        "glue:GetTables",
        "glue:GetTags",
        "glue:ListEntities",
        "glue:ListSchemas",
        "glue:ListTableOptimizerRuns"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:glue:*:${accountId}:*"
    },
    {
      "Sid": "Stmt1718874927696",
      "Action": [
        "sts:GetAccessKeyInfo",
        "sts:GetCallerIdentity"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::${Account}:*"
    },
    {
      "Sid": "Stmt1718876817685",
      "Action": [
        "s3:GetAccessPoint",
        "s3:GetAccessPointPolicy",
        "s3:GetAccessPointPolicyStatus",
        "s3:GetMultiRegionAccessPoint",
        "s3:GetMultiRegionAccessPointPolicy",
        "s3:GetMultiRegionAccessPointPolicyStatus"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:*:*:accesspoint/*"
    }
  ]
}
```
{% endraw %}

Replace `${Account}` with the AWS account ID.

### AWS Organization (optional)
This prerequisite is optional and only necessary if you use IAM Identity Center and want to use Permission Sets (typically, to manage access across multiple AWS accounts).
You need to set up an [AWS Organization connector](/docs/cli/connectors/aws/organization) first, to import the users and groups into an AWS Organization identity store.
In Raito cloud, this identity store then needs to be linked to each AWS Account data source that you would like to manage access for.

As the AWS account connector should be able to modify permission sets on the master account, the following CLI config parameters are required:
* `aws-organization-profile`: The AWS SDK profile where the organization is defined (i.e. where permission sets are defined in AWS Identity Center).
* `aws-organization-region`: The region where the organization is defined (i.e. where permission sets are defined in AWS Identity Center).
* `aws-organization-identity-center-instance-arn`: The ARN of the AWS IAM Identity Center instance. Required if aws `aws-organization-profile` is defined.
* `aws-organization-identity-store`: The ARN of the AWS Identity Store. Required if aws `aws-organization-profile` is defined.

Note that an additional aws credentials profile is required to access the organization.

The user/role using the credentials should have the following policy document attached:

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
        }
    ]
}
```
{% endraw %}

Replace `${instanceId}` with the available SSO instance ID.

## AWS Account-specific CLI parameters

To see all parameters, execute
```bash
$> raito info raito-io/cli-plugin-aws-account
```
in a terminal window.

Currently, the following configuration parameters are available:

| Configuration name                              | Description                                                                                                                                                                                                                                                                                                                                  | Mandatory | Default value    |
|-------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|------------------|
| `aws-profile`                                   | The AWS SDK profile to use for connecting to the AWS account to synchronize. When not specified, the default profile is used (or what is defined in the AWS_PROFILE environment variable).                                                                                                                                                   | False     | `${AWS_PROFILE}` |
| `aws-regions`                                   | A comma separated list of AWS regions to deal with. When not specified, only the default region as found by the AWS SDK is used. The first region in the list must be the default region.                                                                                                                                                    | False     |                  |
| `aws-organization-profile`                      | The AWS SDK profile where the organization is defined (e.g. where permission sets are defined in AWS Identity Center). This is optional and can be used to get a full access trace in case access is granted through the AWS IAM Identity Center.                                                                                            | False     |                  |
| `aws-organization-region`                       | The AWS region where the organization is defined (e.g. where permission sets are defined in AWS Identity Center). If not set and `aws-organization-profile` is defined, the default region for the profile will be used.                                                                                                                     | False     |                  |
| `aws-organization-identity-center-instance-arn` | The ARN of the AWS IAM Identity Center instance. Required if aws `aws-organization-profile` is defined.                                                                                                                                                                                                                                      | False     |                  |
| `aws-organization-identity-store`               | The ARN of the AWS Identity Store. Required if aws `aws-organization-profile` is defined.                                                                                                                                                                                                                                                    | False     |                  |
| `aws-s3-enabled`                                | If set to true, S3 buckets and objects will be retrieved directly from the S3 API. See all other 'aws-s3-' parameters for more control over what is imported and what not. This cannot be enabled together with the `aws-glue-enabled` parameter.                                                                                            | False     | `true`           |
| `aws-s3-emulate-folder-structure`               | Emulate a folder structure for S3 objects, just like in the AWS UI.                                                                                                                                                                                                                                                                          | False     |                  |
| `aws-s3-max-folder-depth`                       | If `aws-s3-enabled` is set to true, fetch all objects up to a certain folder depth.                                                                                                                                                                                                                                                          | False     | 20               |
| `aws-s3-include-buckets`                        | Comma-separated list of buckets to include. If specified, only these buckets will be handled. Wildcards (*) can be used.                                                                                                                                                                                                                     | False     | `*`              |
| `aws-s3-exclude-buckets`                        | Comma-separated list of buckets to exclude. If specified, these buckets will not be handled. Wildcard (*) can be used. Excludes have preference over includes.                                                                                                                                                                               | False     |                  |
| `aws-concurrency`                               | The number of threads to use for concurrent API calls to AWS.                                                                                                                                                                                                                                                                                | False     | 5                |
| `aws-glue-enabled`                              | If set to true, AWS Glue Catalog will be used to fetch data objects. This approach is recommended instead of using S3 directly, because Glue allows you to define your data on a more logical level. The imported data objects will still be represented as S3 objects. This cannot be enabled together with the `aws-s3-enabled` parameter. | False     | `false`          |
| `aws-s3-cloudtrail-bucket`                      | The name of the bucket where the usage data for S3 is stored by AWS Cloud Trail. This is necessary to fetch usage data. If not set, no usage data is gathered.                                                                                                                                                                               | False     |                  |
| `aws-access-skip-iam`                           | If set to true, all IAM access entities (roles and policies) will not be read to import into Raito Cloud as access controls.                                                                                                                                                                                                                 | False     | `false`          |
| `aws-access-skip-user-inline-policies`          | If set to true, inline policies on users will not be read to import into Raito Cloud as access controls.                                                                                                                                                                                                                                     | False     | `false`          |
| `aws-access-skip-group-inline-policies`         | If set to true, inline policies on groups will not be read to import into Raito Cloud as access controls.                                                                                                                                                                                                                                    | False     | `false`          |
| `aws-access-skip-managed-policies`              | If set to true, managed policies will not be read to import into Raito Cloud as access controls.                                                                                                                                                                                                                                             | False     | `false`          |
| `aws-access-skip-aws-managed-policies`          | If set to true, AWS managed policies are excluded.                                                                                                                                                                                                                                                                                           | False     | `false`          |
| `aws-access-managed-policy-excludes`            | Optional comma-separated list of managed policy names to exclude. Regular expressions can be used (e.g. 'Amazon.+,AWS.+' will exclude all managed policies starting with Amazon or AWS).                                                                                                                                                     | False     |                  |
| `aws-access-skip-s3-access-points`              | If set to true, S3 access points will not be read to import into Raito Cloud as access controls.                                                                                                                                                                                                                                             | False     | `false`          |
| `aws-access-role-excludes`                      | Optional comma-separated list of role names to exclude. Regular expressions can be used (e.g. 'Amazon.+,AWS.+' will exclude all roles starting with Amazon or AWS).                                                                                                                                                                          | False     |                  |


