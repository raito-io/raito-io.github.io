---
title: Docker
parent: Raito CLI
nav_order: 23
permalink: /docs/cli/docker
---
# Docker Raito CLI Runner

## Raito Docker Registery
All Raito Docker images are registered at our [Github packages](https://github.com/raito-io/cli-runner/pkgs/container/raito-cli-runner){:target="_blank"}.
You can find images for `linux/386`, `linux/amd64` and `linux/arm64` architectures.

You can easily pull the latest image by executing:
```bash
$> docker pull ghcr.io/raito-io/raito-cli-runner:latest
```

## Start Docker Raito CLI Runner

To run the Raito CLI [**run** command](/docs/cli/commands) continuously, a docker container can be used.

The image expects a Raito configuration file mounted to `/config/raito.yml`.
Read more about the Raito CLI configuration [here](/docs/cli/configuration).

You can easily start the container using the following command:
```bash
$> docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly ghcr.io/raito-io/raito-cli-runner:latest
```

The default entrypoint of the container is defined as
```dockerfile
ENTRYPOINT /raito-cli-runner run -f $CLI_FREQUENCY --config-file /config/raito.yml --log-output
```

You can override the default entrypoint by using the `--entrypoint` option when execution `docker run`

## Environment variables
The following environment variables are used in the default entrypoint:

| Environment variable    | Description                                                                              | Default Value   |
|-------------------------|------------------------------------------------------------------------------------------|-----------------|
| `TZ`                    | Timezone used by the container                                                           | Etc/UTC         |
| `CLI_FREQUENCY`         | The frequency used to do the sync (in minutes).                                          | 60              |
| `RAITO_CLI_UPDATE_CRON` | The cronjob definition for when the container needs to check if a newer CLI version is available. | `0 2 * * *`     |

Additional environment variables, that could be referred in your Raito configuration file, can be mounted by using the existing docker environment arguments `--env` and `--env-file`.
