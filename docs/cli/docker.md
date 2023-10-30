---
title: Docker
parent: Installation
grand_parent: Raito CLI
nav_order: 23
permalink: /docs/cli/installation/docker
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
ENTRYPOINT /raito-cli-runner run -f $CLI_FREQUENCY -c $CLI_CRON --config-file /config/raito.yml --log-output
```

You can override the default entrypoint by using the `--entrypoint` option when executing `docker run`

## Logs
By default, the log output of the Raito CLI are forwarded to `/dev/stdout` and `/dev/stderr`. 
If you like to forward to a specific (mounted) file, override the default locations by configuring `RAITO_CLI_CONTAINER_STDOUT_FILE` and `RAITO_CLI_CONTAINER_STDERR_FILE` environment variables.

```bash
$> docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly -v <Directory to store logs>:/logs/ --env "RAITO_CLI_CONTAINER_STDOUT_FILE=/logs/output.txt" --env "RAITO_CLI_CONTAINER_STDERR_FILE=/logs/err.txt" raito-cli-runner:latest
```

## Environment variables
The following environment variables are used in the default entrypoint:

| Environment variable              | Description                                                                                       | Default Value |
|-----------------------------------|---------------------------------------------------------------------------------------------------|---------------|
| `TZ`                              | Timezone used by the container                                                                    | Etc/UTC       |
| `CLI_FREQUENCY`                   | The frequency used to do the sync (in minutes).                                                   | 1440          |
| `CLI_CRON`                        | Cron expression that defines when  to execute a sync (overwrite `CLI_FREQ`)                       |               |
| `RAITO_CLI_UPDATE_CRON`           | The cronjob definition for when the container needs to check if a newer CLI version is available. | `0 2 * * *`   |
| `RAITO_CLI_CONTAINER_STDOUT_FILE` | Output file stdout of the Raito CLI                                                               | `/dev/stdout` |
| `RAITO_CLI_CONTAINER_STDERR_FILE` | Output file stderr of the Raito CLI                                                               | `/dev/stderr` |

Additional environment variables, that could be referred in your Raito configuration file, can be mounted by using the existing docker environment arguments `--env` and `--env-file`.
