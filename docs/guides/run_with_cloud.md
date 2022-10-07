---
title: Getting started with Raito Cloud
nav_order: 20
parent: Guides
permalink: /docs/guide/cloud
---

# Getting started with Raito Cloud

In this guide we'll walk you through an example of how to connect Raito Cloud to a Snowflake data warehouse through the Raito CLI. We'll 
- make sure that Raito CLI is installed and available
- log into Raito Cloud and create a data source
- configure Raito CLI to connect to Raito Cloud and synchronize with the previously-created data source
- run a first sync
- run the synchronization periodically using GitHb Actions
  
For this guide you will need access to Raito Cloud and you also need access to a Snowflake data warehouse. 
If you don't have the latter, you can request a 30-day free trial. 
If you don't have access to Raito Cloud, [request a trail](https://www.raito.io/trial){:target="_blank"}. 


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

* `Data source type`. Select your data warehouse type. Right now, we only support Snowflake, but we'll create more connectors in the future, and you will be able to create and use your own if needed. 
* `Data source name`. Give your data source a good descriptive name, separating it from other data sources. For this example we'll choose 'Snowflake Test'. 

Once the data source has been created, you are ready to connect the Raito CLI with it. 

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
- `targets` has one Snowflake target defined. You can copy paste this section from the snippet that is shown on the page of the newly created data source in Raito cloud. The first part defines the target, connector and corresponding object ID's in Raito Cloud (i.e. *data-source-id* and *identity-store-id*). The second part is the configuration to connect to your Snowflake instance.

Feel free to customize this configuration further. Remember that you can use double curly brackets to reference environment variables, like we did for the `api-user` field and others in the example.

## Raito run

Now that our data source is set up and we have our Raito CLI configuration file, we can run the Raito CLI with:

```bash
$> raito run
```

This will download all data objects, users, access providers (roles) and data usage information from Snowflake and upload it to Raito Cloud. It will also get the access providers created in Raito Cloud and push them as roles to Snowflake, but since you've started out with an empty instance, this is not relevant at this point. 

See [here](/docs/cli/intro) for more information about what happens exactly. 

## Check results in Raito Cloud

When the `raito run` command finished successfully, go back to 
Raito Cloud. 

On the dashboard you will now some initial insights that we extract from the data that was synchronized. If you go to *Data Sources > Snowflake Test* (i.e. the data source that we've created before), you should be able to see when the last sync was in the *General information*. When you scroll down you can also navigate through the data objects in your Snowflake warehouse.

When you go to *Users* in the navigation bar, you can see all the users of the Snowflake instance under *Identity Store* 'Snowflake Test'. Finally, in *Access Providers* you have an overview of all the roles in your Snowflake instance. If you click on one, you get a detailed view of who belongs to that role, and what they have access to with which permissions. 

## GitHub Actions workflow

There is a [GitHub Action available](https://github.com/raito-io/cli-setup){:target="_blank"} which allows you to easily use the Raito CLI in your own pipelines. 

You can use this GitHub Action to store access information in a repository and automatically deploy it to your data warehouse through the `raito access` command (as explained in [this guide](/docs/guide/access)), but also, for example, to run a nightly sync of your warehouse environment through the `raito run` command.

In the example GitHub Actions workflow yaml file below, we run the `raito run` command every night at 3am.
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


## Feedback 

We welcome any questions or feedback on [Slack](https://raitocommunity.slack.com)