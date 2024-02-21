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
ENTRYPOINT /raito-cli-runner run -c "$CLI_CRON" --config-file /config/raito.yml --log-output
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

| Environment variable              | Description                                                                                         | Default Value |
|-----------------------------------|-----------------------------------------------------------------------------------------------------|---------------|
| `TZ`                              | Timezone used by the container                                                                      | Etc/UTC       |
| `CLI_CRON`                        | Cron expression that defines when  to execute a sync                                                | `0 2 * * *`   |
| `RAITO_CLI_VERSION`               | If provided, this fixed version of the raito CLI will be used instead of the "latest" CLI version.  |               |
| `RAITO_CLI_UPDATE_CRON`           | The cronjob definition for when the container needs to check if a newer CLI version is available.   | `0 1 * * *`   |
| `RAITO_CLI_CONTAINER_STDOUT_FILE` | Output file stdout of the Raito CLI                                                                 | `/dev/stdout` |
| `RAITO_CLI_CONTAINER_STDERR_FILE` | Output file stderr of the Raito CLI                                                                 | `/dev/stderr` |

Additional environment variables, that could be referred in your Raito configuration file, can be mounted by using the existing docker environment arguments `--env` and `--env-file`.

## Entrypoint override
In some cases it can be useful to override the default entrypoint. This could be required if you want to add the `--debug` or `--sync-at-startup` flag. 
This could easily be done as follows:

```bash
$> docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly --entrypoint /raito-cli-runner ghcr.io/raito-io/raito-cli-runner:latest -c "$CLI_CRON" --config-file /config/raito.yml --log-output --debug --sync-at-startup
```

Note that in most cases, additional config could be set in the configuration file.

## Kubernetes

The provided docker container is basically a long-running process that will do an `exit 1` on an unrecoverable error within in the synchronization process.
Because of this behavior and the fact that our container is never directly called by users/services, there is no benefit for providing a `livenessProbe` and `readinessProbe` within the configuration of this pod.

In an ideal world, a CLI instance is not killed during a sync. To prevent as much as possible that a redeployment/re-balance of the pod has an impact during the sync, we made sure that our container support graceful termination. When a graceful termination is requested during the sync, the CLI (and container) will shut down after the sync is done.
To ensure that the graceful termination is completely respected, the [terminationGracePeriodSeconds](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle) should be equal to the maximum sync time in seconds (+ some buffer). 