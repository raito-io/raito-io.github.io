---
title: Okta
parent: Connectors
grand_parent: Raito CLI
nav_order: 1
permalink: /docs/cli/connectors/okta
---

# Okta

[Okta](https://www.okta.com/){:target="_blank"} is a cloud-based identity store. 

Because Okta is not a data source, the connector is limited to only importing users and groups into Raito Cloud.

The connector is available [here](https://github.com/raito-io/cli-plugin-okta){:target="_blank"}.

## Okta-specific parameters

To see all parameters, type 
```bash
$> raito info raito-io/cli-plugin-okta
```
in a terminal window.

Currently, the following configuration parameters are available:
* **okta-domain** (mandatory): The full okta domain to connect to. For example, mydomain.okta.com
* **okta-token** (mandatory): The secret okta token to use to authenticate against the okta domain.
