---
title: Snowflake - First sync with Raito Cloud
nav_order: 10
parent: Guides
permalink: /docs/guide/cloud
---

# First sync with Raito Cloud

In this guide we'll walk you through an example of how to connect Raito Cloud to a Snowflake data warehouse through the Raito CLI. We'll 
- make sure that Raito CLI is installed and available
- create a role and user in Snowflake to use with the CLI
- create a user in Raito Cloud for the CLI connection
- log into Raito Cloud and create a data source
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

## Create Snowflake role and user
Now we'll make sure to create the necessary Snowflake role and user for the Raito CLI to use.

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

Next, we'll create a user (named `raito`) and assign it to the newly created role. We'll use password authentication here. Alternatively, you can use [public/private key authentication](https://docs.snowflake.com/en/user-guide/key-pair-auth) by setting the `sf-private-key` parameter instead of `sf-password`: 

```sql
CREATE USER raito PASSWORD='abc123' MUST_CHANGE_PASSWORD = false DEFAULT_WAREHOUSE=COMPUTE_WH;
GRANT ROLE RAITO_SYNC TO USER raito;
```

You should, of course, pick a secure password instead of `abc123` to protect the user account. 
As described above, you can also use another warehouse.

## Create a Raito Cloud user for the CLI connection
This step is only needed if this is the first time you connect the Raito CLI to Raito Cloud.

To connect the Raito CLI to Raito Cloud, it is advised to use a dedicated user. To create it, follow the following steps in Raito Cloud as an Admin:

 - In the left navigation pane, go to `User Management` in the Admin section.
 - Click `Add user` at the top right.
 - Provide an email address for the new user. This doesn't have to be an existing email address, but it should be using your company domain name. For example: raito-cli@mycompany.com 
 -  Click `Confirm` to create the actual user. The user should now be created and available in the list. 
 -  Find the newly created user in the list, open the context menu (using the three dots button) and choose `Set new password`.
 -  Enter a new **strong** password.
 -  Again, find the newly created user in the list, open the context menu and choose `Edit Raito roles`.
 -  Make sure to select the `Integrator` role in the list and click the `Update` button. This role allows the user to be used to connect the Raito CLI to Raito Cloud.

You'll need the email address and password later on to set up the Raito CLI connection.

## Create a data source in Raito Cloud

Next, we'll create our Data Source in Raito Cloud.

In the left navigation pane go to `Data Sources` > `All data sources`. You should see a button on the top right, `Add data source`. This will guide you through a short wizard to create a new data source. The main things that you will need to configure are 

* `Data source type`. Select your data warehouse type. We are constantly adding new connectors, and you will be able to create and use your own if needed. 
* `Data source name`. Give your data source a good descriptive name, separating it from other data sources. For this example we'll choose 'Snowflake Test'.
* `Data source description`. Accompany your data source with a meaningful description.
* `Connection method`. Select whether you want to use the Raito hosted cloud version of the CLI or one managed by yourself, which is recommended. In this example we indeed select 'CLI'

Once the data source has been created, you are ready to connect the Raito CLI with it. When you would have selected the Cloud CLI version, you will be prompted for the Snowflake account information, username and password, which will not be stored, and optionally a Snowflake role. This information is all similar to what is listed below.

## Raito CLI Configuration

On the main page of the newly created data source, you will see two options to set up the CLI for this new data source. In this guide, we'll follow the first (recommended) option.

Simply copy the command-line command by clicking the `Copy to clipboard` button under option 1.  
Next, simply paste it in a terminal window.

The Raito CLI `add-target` tool will now guide you through the process to add the data source as a target for the CLI.  
If this is the first time configuring the CLI, you will first be asked for some additional information to connect the Raito CLI to Raito Cloud. In these steps, you'll need the email and password of the user you created in Raito Cloud in a previous step. 

At the end of the flow, you will be asked which optional parameters for the Snowflake connector you would like to set. You can use this helper tool to set this or edit them later on in the generated Raito CLI configuration YAML file.

More information on all the parameters can be found in [Snowflake-specific configuration](/docs/cli/connectors/snowflake#snowflake-specific-cli-parameters). For example, how to find the right value for the `sf-account` parameter. 

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

{% include slack.html %}
