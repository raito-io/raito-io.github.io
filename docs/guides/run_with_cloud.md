---
title: CLI with Cloud
nav_order: 20
parent: Guides
permalink: /docs/guide/cloud
---

In this guide we'll walk you through an example of how to connect Raito Cloud to a Snowflake data warehouse through the Raito CLI. We'll 
- make sure that Raito CLI is installed and available
- log into Raito Cloud and create a data source
- configure Raito CLI to connect to Raito Cloud and synchronize with the previously-created data source
- run a first sync
- run the synchronization periodically using GitHb Actions
  
For this guide you will need access to Raito Cloud and you also need access to a Snowflake data warehouse. 
If you don't have the latter, you can request a 30-day free trial. If you don't have access to Raito Cloud, [request a trail](https://www.raito.io/trial){:target="_blank"}. 


## Raito CLI installation

Installation of the Raito CLI is straightforward, run the following command in a terminal window.
```bash
$> brew install raito-io/tap/cli
```

Check that everything is correctly installed by running
```bash
$> raito --version
```

If you want more information about the installation process, or you need to troubleshoot an issue, you can find [more information here](/docs/cli/installation). Also make sure that you have the Snowflake connector installed, [see here](/docs/cli/installation#-to-a-data-source). 

## Create a data source in Raito Cloud

Now that the CLI is working, go to Raito Cloud. 

In the left navigation pane go to `Data Sources` > `All data sources`. You should see a button on the top right, `Add data source`. This will guide you through a short wizard to create a new data source. The main things that you will need to configure are 

* `Data source type`. Select your data warehouse type. Right now we only support Snowflake, but we'll create more connectors in the future, and you will be able to create and use your own if needed. 
* `Data source name`. Give your data source a good descriptive name, separating it from other data sources. For this example we'll choose 'Snowflake Test'. 

After this the data source will be created. You will see a configuration snippet will all necessary information to connect to the new data source, see next section. 

## Raito CLI Configuration

A full, minimal configuration example looks like this:

{% raw %}
```yaml
api-user: "{{RAITO_USER}}"
api-secret: "{{RAITO_API_KEY}}"
domain: "{{DOMAIN}}"

repositories:
  - name: raito-io
    token: "{{GITHUB_PERSONAL_ACCESS_TOKEN}}"

targets:
  # snippet from Raito Cloud (watch the indentation)
  - name: Snowflake Test 
    connector-name: raito-io/cli-plugin-snowflake
    connector-version: latest
    data-source-id: <data-source-id>
    identity-store-id: <identity-store-id>
    
    # Specifying the Snowflake specific config parameters
    sf-account: <account-name>
    sf-user: <user-name>
    sf-password: <password>
```
{% endraw %}

It contains
- a section to configure the connection to Raito Cloud: `api-user`, `api-secret`, and `domain`. `domain` is the part of the URL from your Raito Cloud instance (e.g. https://`domain`.raito.cloud).
- `repositories` contains a personal access token to download the Snowflake plugin. 
- `targets` has one Snowflake target defined. The first part defines the target, connector and corresponding object ID's in Raito Cloud (i.e. *data-source-id* and *identity-store-id*). The second part of is the configuration to connect to your Snowflake instance.

## Raito run

Feel free to customize this configuration further. Remember that you can use double curly brackets to reference environment variables, as is the case of e.g. `api-user` in the example. Save your configuration to a file called `raito.yml`, and then you can do the synchronization with 

```bash
$> raito run
```

This will download all data objects, users, access providers (roles) and data usage information from Snowflake it and upload it to Raito Cloud. It will also synchronize the access providers (roles), but since you've started out with an empty instance, this is not relevant. See [here](/docs/cli/intro) for more information about what happens exactly. 

## Check results in Raito Cloud

Go back to Raito Cloud. You should see all sections populated now. On the dashboard you have a general overview of all everything that's inside your Snowflake warehouse. If you go to *Data Sources > Snowflake Test* (i.e. the data source that we've created before), you should see when the last sync was in the *General information*. When you scroll down you can also navigate through the data objects in your Snowflake warehouse.

When you go to *Users* in the navigation bar, you can see all the users of the Snowflake instance under *Identity Store* 'Snowflake Test'. Finally, in *Access Providers* you have an overview of all the roles in your Snowflake instance. If you click on one, you get a detailed view of who belongs to that role, and what they have access to with which permissions. 

## GitHub Actions workflow

There is a [GitHub Action available](https://github.com/raito-io/cli-setup){:target="_blank"} which allows you to easily use the Raito CLI in your own pipelines. You can use this GitHub Action to
store access information in a repository and automatically deploy it to your data warehouse through the `raito access` command, but also e.g. to run a nightly sync of your warehouse environment through the `raito run` command). See [this guide](/docs/guide/access) for `raito access`. 

See the [Versioned Access Guide](/docs/guide/access) if you want more information on how to run the sync with Github Actions. The only different is that you'll have to use a different command of the Raito CLI (i.e. `run` instead of `access`).

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
        run: raito run --config-file raito.yml
``` 
{% endraw %}


## Feedback 

We welcome any questions or feedback on [Slack](https://raitocommunity.slack.com)