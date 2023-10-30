---
# title: Fine-grained access controls
parent: Raito Cloud
nav_order: 70
has_children: false
has_toc: false
permalink: /docs/cloud/finegrained_access
---

# Fine-grained access

Raito supports this visualization of both masking and filter policies as well as the management of masking policies. Both are access controls within Raito with respectively a mask or filter action. These actions have separated pages accessible under access controls in the main navigation.

## Masking policies

Just like a grant access control, a mask access control has a who and a what-list, but next to those, it also has a masking method. A mask access control belongs to a single data source and the masking methods are dependent on that data source.

The what-list of a mask access control can only consist of columns. The masking method is applied on all columns of the mask access control for everyone but the users in the who-list of the mask. This means that everyone sees masked data, except for those in the who-list. The who-list therefor rather acts as an unmask.

Mask access controls can be created by data owners by adding their own columns to the mask. The who of a mask is managed by the mask owner.

## Filter policies

Filter access controls behave quite similar to mask access controls, with the distinction that the what-list consists of tables and a separate filter condition. Remark that as Raito does not know the content of your data, it can not fully check the impact of a filter access control.
