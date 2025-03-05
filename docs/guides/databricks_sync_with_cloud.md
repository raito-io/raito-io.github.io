---
title: Databricks - First sync with Raito Cloud
nav_order: 30
parent: Guides
permalink: /docs/guide/databricks
---

# First sync with Raito Cloud

In this guide we'll walk you through an example of how to connect Raito Cloud to a Databricks data warehouse with the Raito CLI.
We'll
- make sure that Raito CLI is installed and available
- create a service principal in Databricks to use with the CLI
- create a user in Raito Cloud for the CLI connection
- create a new Data Source in Raito Cloud
- configure the Raito CLI to connect to Raito Cloud and synchronize with the previously-created Data Source
- run a first sync

For this guide you will need access to Raito Cloud and to a Databricks account.

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

## Create a Databricks Service principal

While it is possible to use user credentials to execute a Raito sync, it is highly recommended to create a dedicated Databricks service principal to be used by the Raito CLI connector.

Therefor, we'll create a Service Principal (named `RaitoSync`) and provide it with the necessary permissions. 
- Navigate to the `User management` page in your Databricks account admin page. 
    Under the tab `Service principals`, click `Add Service Principal`. 
- Fill in the name (in our example `RaitoSync`). Click on the newly created service principal to create a new `OAuth secret`. 
- A client ID and secret will be generated, save those credentials for later use. 
- Ensure the service principal is configured as account admin (so it can read all the users and groups within the account).
- Add the service principal as admin of all workspaces you want to sync to Raito.
- Additionally, create an `owner_group` (containing the service principal) that can be assigned to all catalogs in all workspaces.
- Assign the new `owner_group` as owner of all catalogs in every workspace. The following Python script can be used (in each workspace) to achieve this:

```python
principal = "owner_group" #REPLACE THIS WITH THE ACTUAL GROUPNAME

catalogsDf = spark.sql("SHOW CATALOGS")
it = catalogsDf.toLocalIterator()

for catalog in it:
    # spark.sql("ALTER CATALOG " + catalog['catalog'] + " OWNER TO master_catalog_owner;")
    r = spark.sql("DESCRIBE CATALOG EXTENDED " + catalog['catalog'] + ";")
    
    updateCatalog = False
    
    for infoRow in r.toLocalIterator():
        if infoRow['info_name'] == "Catalog Type" and infoRow["info_value"] == "Regular":
            updateCatalog = True

    if updateCatalog:
        spark.sql("ALTER CATALOG " + catalog['catalog'] + " OWNER TO " + principal + ";")
 
```

## Create a Raito Cloud user for the CLI connection
This step is only needed if this is the first time you connect the Raito CLI to Raito Cloud.

To do this, check out the section in the [Snowflake guide](/docs/guide/cloud#create-a-raito-cloud-user-for-the-cli-connection).

## Create a Data Source in Raito Cloud

Now that the CLI is working, sign in to your Raito Cloud instance.

In the left navigation pane go to `Data Sources` > `All data sources`. You should see a button on the top right, `Add Data Source`. This will guide you through a short wizard to create a new Data Source. The main things that you will need to configure are

* `Data source type`. Select your data warehouse type. We are constantly adding new connectors, and you will be able to create and use your own if needed.
* `Data source name`. Give your Data Source a good descriptive name, separating it from other data sources. For this example we'll choose 'Databricks Test'.
* `Data source description`. Accompany your Data Source with a meaningful description.

Once the Data Source has been created, you are ready to connect the Raito CLI with it.

## Raito CLI Configuration

On the main page of the newly created Data Source, you will see two options to set up the CLI for this new Data Source. In this guide, we'll follow the first (recommended) option.

Simply copy the command presented in the first option by clicking the `Copy to clipboard` button.  
Next, simply paste it in a terminal window and press Enter.

The Raito CLI `add-target` command will now guide you through the process to add your newly created Data Source as a target in the Raito CLI configuration.

If this is the first time configuring the CLI, you will first be asked for some additional information to connect the Raito CLI to Raito Cloud. In these steps, you'll need the email and password of the user you created in Raito Cloud in a previous step. 

At the end of the flow, you will be asked which optional parameters for the Databricks connector you would like to set. You can use this helper tool to set them or edit them later in the generated Raito CLI configuration YAML file.

To enable row filtering and column masking, the plugin need access to a SQL warehouse to manage those filters and masks.
This can be configured by adding the following parameter to the target configuration. Simply edit the created configuration YML file and set this parameter for each meta store you have:

{% raw %}
```yaml
    databricks-sql-warehouses:
      <metastore-ID>:
        workspace: <workspace-id>
        warehouse: <sql-warehouse-id>
```
{% endraw %}

## Raito run

Now that our Data Source is set up and we have our Raito CLI configuration file, we can run the Raito CLI with:

```bash
$> raito run
```

This will download all data objects, users, access controls (roles) and data usage information from Databricks and upload it to Raito Cloud. It will also get the access controls created in Raito Cloud and push them as roles to Databricks, but since you've started out with an empty instance, this is not relevant at this point.

See [here](/docs/cli/intro) for more information about what happens exactly.

## Check results in Raito Cloud

When the `raito run` command finished successfully, go back to
Raito Cloud.

On the dashboard you will now see some initial insights that we extract from the data that was synchronized. If you go to `Data Sources > Databricks Test` (i.e. the Data Source that you have created before), you should be able to see when the last sync was done in the `General information` section. When you scroll down you can also navigate through the data objects in your Databricks warehouse.

When you go to `Identities` in the navigation bar, you can see all the users of the Databricks instance under `Identity Store` 'Databricks Test'. Finally, in `Access Controls` under grants, you have an overview of all the roles in your Databricks instance. If you click on one, you get a detailed view of who belongs to that role, and what they have access to with which permissions.

{% include slack.html %}