---
title: Snowflake - First sync with Raito Cloud
nav_order: 10
parent: Guides
permalink: /docs/guide/cloud
---

# First sync with Raito Cloud

In this guide we'll walk you through an example of how to connect Raito Cloud to a Snowflake data warehouse through the Raito CLI. We'll 
- make sure that Raito CLI is installed and available
- log into Raito Cloud and create a data source
- create a role and user in Snowflake to use with the CLI
- configure Raito CLI to connect to Raito Cloud and synchronize with the previously-created data source
- run a first sync
- run the synchronization periodically using GitHb Actions
  
For this guide you will need access to Raito Cloud and you also need access to a Snowflake data warehouse. 
If you don't have the latter, you can request a 30-day free trial. 
If you don't have access to Raito Cloud, [request a trial](https://www.raito.io/trial){:target="_blank"}. 


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

## Create a data source in Raito Cloud

Now that the CLI is working, sign in to your Raito Cloud instance. 

In the left navigation pane go to `Data Sources` > `All data sources`. You should see a button on the top right, `Add data source`. This will guide you through a short wizard to create a new data source. The main things that you will need to configure are 

* `Data source type`. Select your data warehouse type. We are constantly adding new connectors, and you will be able to create and use your own if needed. 
* `Data source name`. Give your data source a good descriptive name, separating it from other data sources. For this example we'll choose 'Snowflake Test'.
* `Data source description`. Accompany your data source with a meaningful description.
* `Connection method`. Select whether you want to use the Raito hosted cloud version of the CLI or one managed by yourself, which is recommended. In this example we indeed select 'CLI'

Once the data source has been created, you are ready to connect the Raito CLI with it. When you would have selected the Cloud CLI version, you will be prompted for the Snowflake account information, username and password, which will not be stored, and optionally a Snowflake role. This information is all similar to what is listed below.

## Create Snowflake role and user

While it is possible (and the default) to use the `ACCOUNTADMIN` role, it is highly recommended to create a custom role and accompanying user in Snowflake to be used by the Snowflake CLI connector.

Therfore, we'll create a role (named `RAITO_SYNC`) and provide it with the necessary permissions. To do this, execute the following queries in your Snowflake account:

```sql
CREATE OR REPLACE ROLE RAITO_SYNC;
GRANT CREATE ROLE ON ACCOUNT TO ROLE RAITO_SYNC;
GRANT MANAGE GRANTS ON ACCOUNT TO ROLE RAITO_SYNC;
GRANT APPLY MASKING POLICY ON ACCOUNT TO ROLE RAITO_SYNC;
GRANT APPLY ROW ACCESS POLICY ON ACCOUNT TO ROLE RAITO_SYNC;
GRANT IMPORT SHARE ON ACCOUNT TO ROLE RAITO_SYNC;
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE RAITO_SYNC;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE RAITO_SYNC;
```

Note: we're using the `COMPUTE_WH` warehouse here. You can use another warehouse as long as this is the default warehouse for the user.

Next, we'll create a user (named `raito`) and assign it to the newly created role:

```sql
CREATE USER raito PASSWORD='abc123' MUST_CHANGE_PASSWORD = false DEFAULT_WAREHOUSE=COMPUTE_WH;
GRANT ROLE RAITO_SYNC TO USER raito;
```

You should, of course, pick a secure password instead of `abc123` to protect the user account. 
As described above, you can also use another warehouse.

## Raito CLI Configuration

On the main page of the newly created data source, you will see a configuration snippet with the necessary information to connect the Raito CLI to this data source.

To do this, create a file with the name `raito.yml` and edit it to look like this:

{% raw %}
```yaml
api-user: "{{RAITO_USER}}"
api-secret: "{{RAITO_API_KEY}}"
domain: "{{DOMAIN}}"

targets:
  # snippet from Raito Cloud (watch the indentation)
  - name: Snowflake Test 
    connector-name: raito-io/cli-plugin-snowflake
    connector-version: latest
    data-source-id: "<data-source-id>"
    identity-store-id: "<identity-store-id>"
    
    # Specifying the Snowflake specific config parameters
    sf-account: "{{SF_ACCOUNT}}"
    sf-user: "raito"
    sf-password: "{{SF_PASSWORD}}"
    sf-role: "RAITO_SYNC"
```
{% endraw %}

It contains
- a section to configure the connection to Raito Cloud: `api-user`, `api-secret`, and `domain`. `domain` is the part of the URL from your Raito Cloud instance (e.g. https://`domain`.raito.cloud). `api-user` and `api-secret` are the login credentials for your Raito Cloud instance.
- `targets` has one Snowflake target defined. You can copy paste this section from the snippet that is shown on the page of the newly created data source in Raito cloud. The first part defines the target, connector and corresponding object ID's in Raito Cloud (i.e. `data-source-id` and `identity-store-id`). The second part is the configuration to connect to your Snowflake instance. We're using the newly created `raito` user and `RAITO_SYNC` role.

Feel free to customize this configuration further. Find more information in the sections about [general configuration](/docs/cli/configuration#command-specific-parameters) and [Snowflake-specific configuration](/docs/cli/connectors/snowflake#snowflake-specific-parameters). 
Remember that you can use double curly brackets to reference environment variables, like we did for the `api-user` field and others in the example.

## Raito run

Now that our data source is set up and we have our Raito CLI configuration file, we can run the Raito CLI with:

```bash
$> raito run
```

This will download all data objects, users, access controls (roles) and data usage information from Snowflake and upload it to Raito Cloud. It will also get the access controls created in Raito Cloud and push them as roles to Snowflake, but since you've started out with an empty instance, this is not relevant at this point. 

See [here](/docs/cli/intro) for more information about what happens exactly. 

## Check results in Raito Cloud

When the `raito run` command finished successfully, go back to 
Raito Cloud. 

On the dashboard you will now see some initial insights that we extract from the data that was synchronized. If you go to `Data Sources > Snowflake Test` (i.e. the data source that you have created before), you should be able to see when the last sync was done in the `General information` section. When you scroll down you can also navigate through the data objects in your Snowflake warehouse.

When you go to `Identities` in the navigation bar, you can see all the users of the Snowflake instance under `Identity Store` 'Snowflake Test'. Finally, in `Access Controls` under grants, you have an overview of all the roles in your Snowflake instance. If you click on one, you get a detailed view of who belongs to that role, and what they have access to with which permissions. 

## GitHub Actions workflow

There is a [GitHub Action available](https://github.com/raito-io/cli-setup){:target="_blank"} which allows you to easily use the Raito CLI in your own pipelines. 

You can use this GitHub Action to store access information in a repository and automatically deploy it to your data warehouse through the `raito access` command (as explained in [this guide](/docs/guide/access)), but also for example, to run a nightly sync of your warehouse environment through the `raito run` command.

In this case, the near real-time sync (using websockets) will not be active as the CLI will only run one full synchronization.

In the example GitHub Actions workflow YAML file below, we run the `raito run` command every night at 3am.
The version of the Raito CLI can be specified with `with: version` in the `Setup Raito CLI` step, but if not specified, it will use the latest available version. We show it, but commented it out, for completeness.

{% raw %}
```yaml
name: cli-on-demand
on: 
  schedule:    
    - cron: '0 3 * * *'
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

      - name: warehouse sync 
        run: raito run
``` 
{% endraw %}


{% include slack.html %}
