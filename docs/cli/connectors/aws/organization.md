---
title: AWS Organization
parent: AWS
grand_parent: Connectors
nav_order: 2
permalink: /docs/cli/connectors/aws/organization
---

# AWS Organization

[AWS](https://aws.amazon.com/){:target="_blank"} is a cloud-based infrastructure provider.
This Raito CLI plugin is used to synchronize the identity store information of an [AWS organization (IAM Identity Center)](https://aws.amazon.com/iam/identity-center/){:target="_blank"}.
This identity store can then be linked to AWS Account data sources (or set as Master Identity Store) so that permission sets can be visualized correctly.


## Prerequisites
### AWS Credentials
The AWS organization connector requires AWS credentials to access the AWS account.
The credentials can be provided by one of the following options:
1. Environment variables: The environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and (optionally) `AWS_SESSION_TOKEN` are used.
2. Shared credentials file. Credentials defined on `~/.aws/credentials` will be used. A profile can be defined with `aws-profile`.
3. If running on an Amazon EC2 instance, IAM role for Amazon EC2.

Ensure the role/user has the following policy document attached:
```json
{
  "Version": "2012-10-17",
  "Statement": [
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

## AWS Organization-specific CLI parameters

To see all parameters, execute
```bash
$> raito info raito-io/cli-plugin-aws-organization
```
in a terminal window.

Currently, the following configuration parameters are available:
- **aws-account-id** (mandatory): The ID of your AWS account.
- **aws-profile** (optional): The AWS SDK profile to use for connecting to your AWS account that managed the organization to synchronize. When not specified, the default profile is used (or what is defined in the AWS_PROFILE environment variable).
- **aws-region** (optional): The AWS region to use for connecting to the AWS account to synchronize. When not specified, the default region as found by the AWS SDK is used.