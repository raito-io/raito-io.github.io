---
title: Docker
parent: Installation
grand_parent: Raito CLI
nav_order: 23
permalink: /docs/cli/installation/docker
---
# Docker Images
To run the CLI in Docker, two possibilities are provided:
1. Recommended: The `CLI Runner` image contains a small wrapper around the actual Raito CLI to make sure that the latest CLI version is downloaded on a regular basis. This way, you can be sure to always run the latest version. See the `Docker Raito CLI Runner` section below.
2. The `CLI` image directly has a fixed version of the CLI embedded. For each new version of the CLI that is released, a corresponding CLI Docker image is released as well. See the `Docker Raito CLI` section below.

## Docker Raito CLI Runner

### Getting Started
All Raito Docker images of the CLI Runner are registered at our [Github packages](https://github.com/raito-io/cli-runner/pkgs/container/raito-cli-runner){:target="_blank"}.

You can easily pull the latest image by executing:
```bash
$> docker pull ghcr.io/raito-io/raito-cli-runner:latest
```

### Start Docker Raito CLI Runner

To run the Raito CLI [**run** command](/docs/cli/commands) continuously, a docker container can be used.

The image expects a Raito configuration file mounted to `/config/raito.yml`.
Read more about the Raito CLI configuration [here](/docs/cli/configuration).

You can easily start the container using the following command:
```bash
docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly ghcr.io/raito-io/raito-cli-runner:latest
```

The default entrypoint of the container is defined as
```dockerfile
ENTRYPOINT /raito-cli-runner run -c "$CLI_CRON" --config-file /config/raito.yml --log-output
```

See the `Entrypoint override` section to learn how to override this to specify different parameters.

### Logs
By default, the log output of the Raito CLI are forwarded to `/dev/stdout` and `/dev/stderr`. 
If you like to forward to a specific (mounted) file, override the default locations by configuring `RAITO_CLI_CONTAINER_STDOUT_FILE` and `RAITO_CLI_CONTAINER_STDERR_FILE` environment variables.

```bash
docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly -v <Directory to store logs>:/logs/ --env "RAITO_CLI_CONTAINER_STDOUT_FILE=/logs/output.txt" --env "RAITO_CLI_CONTAINER_STDERR_FILE=/logs/err.txt" ghcr.io/raito-io/raito-cli-runner:latest
```

### Environment variables
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

### Entrypoint override
In some cases it can be useful to override the default entrypoint. This could be required if you want to add the `--debug` or `--sync-at-startup` flag. 
This could easily be done as follows:

```bash
docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly --entrypoint /raito-cli-runner ghcr.io/raito-io/raito-cli-runner:latest run -c "$CLI_CRON" --config-file /config/raito.yml --log-output --debug --sync-at-startup 
```

{: .note }
As you can see in the example above, overriding the entrypoint with docker run is done in a very strange way. After the entrypoint flag, only the main command is given ('/raito-cli-runner'), followed by the docker image to use ('ghcr.io/raito-io/raito-cli-runner:latest') and only after that are the parameters for the entrypoint command ('run ...').

Note that in most cases, additional config could be set in the configuration file.

## Docker Raito CLI

### Getting Started
All Raito Docker images of the CLI are registered at our [Github packages](https://github.com/raito-io/cli/pkgs/container/raito-cli){:target="_blank"}.

You can easily pull the latest image by executing:
```bash
$> docker pull ghcr.io/raito-io/raito-cli:latest
```

### Start Docker Raito CLI

To run the Raito CLI [**run** command](/docs/cli/commands) continuously, a docker container can be used.

The image expects a Raito configuration file mounted to `/config/raito.yml`.
Read more about the Raito CLI configuration [here](/docs/cli/configuration).

You can easily start the container using the following command:
```bash
docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly ghcr.io/raito-io/raito-cli:latest
```

The default entrypoint of the container is defined as
```dockerfile
ENTRYPOINT /raito run -c "$CLI_CRON" --config-file /config/raito.yml --log-output
```

See the `Entrypoint override` section to learn how to override this to specify different parameters.

### Environment variables
The following environment variables are used in the default entrypoint:

| Environment variable              | Description                                                                                         | Default Value |
|-----------------------------------|-----------------------------------------------------------------------------------------------------|---------------|
| `TZ`                              | Timezone used by the container                                                                      | Etc/UTC       |
| `CLI_CRON`                        | Cron expression that defines when  to execute a sync                                                | `0 2 * * *`   |

Additional environment variables, that could be referred in your Raito configuration file, can be mounted by using the existing docker environment arguments `--env` and `--env-file`.

### Entrypoint override
In some cases it can be useful to override the default entrypoint. This could be required if you want to add the `--debug` or `--sync-at-startup` flag. 
This could easily be done as follows:

```bash
docker run --mount type=bind,source="<Your local Raito configuration file>",target="/config/raito.yml",readonly --entrypoint /raito ghcr.io/raito-io/raito-cli:latest run -c "$CLI_CRON" --config-file /config/raito.yml --log-output --debug --sync-at-startup
```

{: .note }
As you can see in the example above, overriding the entrypoint with docker run is done in a very strange way. After the entrypoint flag, only the main command is given ('/raito'), followed by the docker image to use ('ghcr.io/raito-io/raito-cli:latest') and only after that are the parameters for the entrypoint command ('run ...').

Note that in most cases, additional config could be set in the configuration file.

# Kubernetes

Both the `CLI Runner` and `CLI` docker images, are basically providing a running CLI which is a long-running process that will do an `exit 1` on an unrecoverable error within in the synchronization process.

As you may know, the Raito CLI can run in 2 modes. From a health-check standpoint, there are some differences between both run modes.

### Single run mode

As the container is only running during a single sync, the container will simply exit after the sync is done or if there was an error during the sync.

In this case, there is little added benefit for adding additional health checks as we just want to keep the container running during that sync.

### Continuous run mode
If there is a [cron](/docs/cli/configuration#global-parameters) defined, the CLI will also continuously listen to a webhook (unless disabled). In this case it makes sense to add an additional health check based on the status of this connection. 

To enable this feature, you need to pass an environment variable `RAITO_CLI_CONTAINER_LIVENESS_FILE` to the container. The value should be a file path in a writable directory.
When this file is available on the file system, it means that the websocket connection is active and running.
When this file is not available on the file system, it means that the websocket connection is closed.

As a `livenessProbe` command, you can use a simple `cat` on the file path passed with the environment variable `RAITO_CLI_CONTAINER_LIVENESS_FILE` to check if the container is healthy or not.

### Termination grace period
In an ideal world, a CLI instance is not killed during a sync. To prevent as much as possible that a redeployment/re-balance of the pod has an impact during the sync, we made sure that our container support graceful termination. When a graceful termination is requested during the sync, the CLI (and container) will shut down after the sync is done.
To ensure that the graceful termination is completely respected, the [terminationGracePeriodSeconds](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle) should be equal to the maximum sync time in seconds (+ some buffer). 