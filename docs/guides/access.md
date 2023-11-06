---
title: Access-as-code
nav_order: 30
parent: Guides
permalink: /docs/guide/access
---

# Access-as-code

In this guide we'll walk you through an end-to-end example of how to use the Raito CLI to implement an access-as-code system with your Snowflake data warehouse using continuous integration. We will
- set up a new repository in GitHub
- set up the configuration of the Raito CLI
- test and bring everything together locally
- synchronize the defined access controls using GitHub Actions
  
We will assume some familiarity with Git and GitHub. These steps, except for the GitHub Actions step, can easily be reproduced using another version control system (or no version control system at all). You also need access to a Snowflake data warehouse. 
If you don't have that, you can request a 30-day free trial. For this access-as-code usecase, you don't need access to Raito Cloud.


## Raito installation

Installation of the Raito CLI is straightforward, run the following command in a terminal window.
```bash
$> brew install raito-io/tap/cli
```

Check that everything is correctly installed by running
```bash
$> raito --version
```

If you want more information about the installation process, or you need to troubleshoot an issue, you can find [more information here](/docs/cli/installation). 


## Repository setup

Create a new repository in GitHub, clone it to your local machine and create the following folder structure and files
```js
.github/
  workflows/
    sync-access.yml
raito.yml
access.yml
```

- `raito.yml` contains the configuration for the Raito CLI.
- `access.yml` contains the roles that will be pushed to Snowflake.
- `sync-access.yml` contains the continuous integration workflow that will be used by GitHub Actions.



## Raito configuration

{% raw %}
Copy/paste the following configuration into `raito.yml`:
```yaml
targets:
  - name: snowflake1
    connector-name: raito-io/cli-plugin-snowflake
    connector-version: latest
    sf-account: "{{SF_ACCOUNT}}"
    sf-user: "{{SF_USER}}"
    sf-password: "{{SF_PASSWORD}}"
    sf-role: ACCOUNTADMIN
```
{% endraw %}

This is a minimal configuration needed for this tutorial, extra [general parameters](/docs/cli/configuration) and [Snowflake-specific](/docs/cli/connectors/snowflake) ones are in their respective sections. 

Note: `sf-role` is not required as 'ACCOUNTADMIN' is the default role if none is specified. Also `connector-version` will default to latest if not specified.


## Raito access file

Copy/paste the following configuration into `access.yml`:
```yaml
accessProviders:
  -
    name: DATA_SCIENTIST
    description: A role used for testing raito access
    access:
      - 
        who:
          users:
            - <user>
        what:
          - dataObject:
              type: table
              fullName: <existing full table name, e.g. DATABASE.SCHEMA.TABLE>
            permissions:
              - select
```

The access file contains a list of access controls. You can give it a *name* and *description*. They are purely for documentation reasons and will be used to generate a comment on the created role. 
The *namingHint* will help determine the name of the role that will be created in Snowflake.
Every access control defines *who* has access to *what*, with which permissions. The *who list* can be a list of users, groups, or other access controls.
 <!-- (TODO: these can't be groups, right?).  -->
 The *what list* is a list of data objects with their full name, and associated permissions. 

In the Snowflake connector 'boilerplate permissions' don't need to be specified. E.g. if you want to give SELECT permissions on a table, you don't need to specify USAGE on the schema or database, this is handled by the Snowflake connector internally. This can, however, vary by connector.


## Test Raito access synchronization

Now it's time to check if the integration with Snowflake works. We'll check which roles are available in Snowflake, synchronize the roles we've configured with the Raito CLI and then check again if they're actually created in Snowflake. 

Go to the Snowflake UI, create a new worksheet and execute `SHOW ROLES;` You should see a list, probably containing built-in roles like

| created_on        | name         | is_default | ... |
|:-------------|:------------------|:------|:-----|
|            | ACCOUNTADMIN | Y  | ... |
|  | ORGADMIN   | N  | ... |
|            | PUBLIC      | N   | ... |
|            | SECURITYADMIN | N  | ... |
|            | SYSADMIN | N  | ... |
|            | USERADMIN | N  | ... |
| ... | ... | ... | ... |

In the Snowflake UI, make sure that the user you will be using, i.e. `SF_USER`, has a default warehouse configured. In the left naviagation bar, go to *Admin* > *Users & Roles*, then click on the user.  Otherwise you will get an error along the lines of 
`No active warehouse selected in the current session. Select an active warehouse with the 'use warehouse' command.`

Now in a terminal on your local machine, 
* make sure the environment variables specified in the configuration file are available (i.e. `SF_ACCOUNT`, `SF_USER` and `SF_PASSWORD`), and
* run the Raito CLI
```bash
$> raito access
```

Note: you can specify the `--config-file` and/or `--access-file` parameters to use different file names than `raito.yml` and/or `access.yml`.

Now go back to Snowflake and try `SHOW ROLES;` again. In the list you should see the role we've specified in the `access.yml` configuration. Roles coming from the Raito CLI *access* command will have the `R_` prefix. Therefore, the `DATA_SCIENTIST` *namingHint* specified will translate to the Snowflake role name `R_DATA_SCIENTIST`. 

Beware that the `access.yml` file acts as a single source of truth; if you remove everything from the `access.yml` file except for the first line, `accessProviders:` all roles that Raito CLI provisioned through the *access* command in Snowflake will be removed (i.e. all roles with prefix `R_`). The advantage of this is that your Snowflake roles configuration will not get cluttered with unused roles. 

## GitHub Actions workflow

There is a [GitHub Action available](https://github.com/raito-io/cli-setup){:target="_blank"} which allows you to easily use the Raito CLI in your own pipelines. You can use this GitHub Action to
store access information in a repository and automatically deploy it to your data warehouse through the `raito access` command, but also e.g. to run a nightly sync of your warehouse environment through the `raito run` command). See [this guide](/docs/guide/cloud) for `raito run`. 

In the example GitHub workflow yaml file below, the version of the Raito CLI can be specified with `with: version` in the `Setup Raito CLI` step, but if not specified, it will use the latest available version. We show it, but commented it out, for completeness. 

{% raw %}
```yaml
name: cli-on-demand
on: 
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  cli-sync:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository code
        uses: actions/checkout@v3

      - name: Setup Raito CLI
        uses: raito-io/cli-setup@v1.0.3

      - name: access sync 
        run: raito access
``` 
{% endraw %}

Now that all files have been created, you can commit them and push them to a remote branch. Once you merge your changes into the `main` branch of your repository, the workflow will start and call the Raito CLI to update the roles in Snowflake. You should be able to see the Github Actions workflow run and the logs of the Raito CLI under the 'Actions' tab on the Github page of your repository. 

{% include slack.html %}
