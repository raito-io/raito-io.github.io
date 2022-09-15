---
title: CI/CD integration
nav_order: 10
parent: Guides
permalink: /guide/access
---

<div class="wip" style="text-align: center">
  <img src="/assets/images/logo-wait-128.png" alt="Work in Progress"/>
  <br/>
  Work in Progress
</div>


In this guide we'll guide you through a complete end-to-end example of 

- set up repository in Github, project structure
- access.yml
- Github action file
- end




There is a [Github Action available](https://github.com/raito-io/cli-setup){:target="_blank"} which allows you to easily use the Raito CLI in your own pipelines. You can use this to
store access information in a repository and automatically deploy it to your data warehouse through the `raito access` command, but also e.g. to run a nightly sync of your warehouse environment through the `raito run` command.

In the example Github workflow yaml file below
* versions of the Raito CLI and Snowflake plugin are stored in `./.github/workflow/raito.env` containing 
```bash
CLI_VERSION=<cli_version, e.g. 0.19.0>
SF_PLUGIN_VERSION=<sf_plugin_version, e.g. 0.6.0>
```
* The version of the Raito CLI can be specified with `with: version` in the `Setup Raito CLI` step, but if not specified, it will use the latest available version. 

{% raw %}
```js
name: cli-on-demand
on: 
  workflow_dispatch:

jobs:
  cli-sync:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository code
        uses: actions/checkout@v3

      - name: Raito versions
        id: raito_version
        run: |
          source ./.github/workflows/raito.env
          echo "Raito CLI version: ${CLI_VERSION}"
          echo "Raito Snowflake plugin version: ${SF_PLUGIN_VERSION}"
          echo "::set-output name=CLI_VERSION::${CLI_VERSION}"
          echo "::set-output name=SF_PLUGIN_VERSION::${SF_PLUGIN_VERSION}"

      - name: Setup Raito CLI
        uses: raito-io/cli-setup@v1.0.3
        with:
          version: "v${{ steps.raito_version.outputs.CLI_VERSION }}"

      - name: CLI sync
        env:
          SNOWFLAKE_PLUGIN_VERSION: $'{{' steps.raito_version.outputs.SF_PLUGIN_VERSION '}}'      
        run: |
          raito --version
``` 
{% endraw %}