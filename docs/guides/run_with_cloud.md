---
title: CLI with Cloud
nav_order: 20
parent: Guides
permalink: /docs/guide/run
---

In this guide we'll walk you through an example of how to connect Raito Cloud to a Snowflake data warehouse through the Raito CLI. We'll 
- make sure that Raito CLI is installed and available
- log into Raito Cloud and create a data source
- configure Raito CLI to connect to Raito Cloud and synchronize with the previously-create data source
- run a first sync
- run the synchronization periodically on GitHb Actions
  
For this guide you will need access to Raito Cloud and you also need access to a Snowflake data warehouse. 
If you don't have the latter, you can request a 30-day free trial. To get trial access to Raito Cloud, [contact us](https://www.raito.io). 


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

In the left navigation pane go to `Data Sources` > `All data sources`. You should see a button on the top right, `Add data source`. This will guide you through a wizard to create a new data source. The main things that you will need to do configure are 

* `Data source type`. Select your data warehouse type. Right now we only support Snowflake, but we'll create more connectors in the future, and you will be able to create your own if needed. 
* `Data source name`. Give your data source a good descriptive name, separating it from other data sources. For this example we'll choose 'Snowflake Test'. 

After this the data source will be created. You will see a configuration snippet will all necessary information to connect to the new data source, see next section. 

## Raito CLI Configuration

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


## Raito run

## GitHub Actions workflow

There is a [GitHub Action available](https://github.com/raito-io/cli-setup){:target="_blank"} which allows you to easily use the Raito CLI in your own pipelines. You can use this GitHub Action to
store access information in a repository and automatically deploy it to your data warehouse through the `raito access` command, but also e.g. to run a nightly sync of your warehouse environment through the `raito run` command). See [this guide](/docs/guide/run) for `raito run`. 

In the example GitHub workflow yaml file below the version of the Raito CLI can be specified with `with: version` in the `Setup Raito CLI` step, but if not specified, it will use the latest available version. We show it, but commented it out, for completeness. 

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
        // with:
        //   version: "v${{ steps.raito_version.outputs.CLI_VERSION }}"

      - name: warehouse sync 
        run: raito run --config-file raito.yml
``` 
{% endraw %}

Now that all files have been created, you can commit them and push them to a remote branch. You can test if everything that has been tested locally is also working in the GitHub environment. Merge your changes to the `main` branch, and you should see a successful run of the Raito CLI in the GitHub Actions environment. 

## Feedback 

We welcome any questions or feedback on [Slack](https://raitocommunity.slack.com)