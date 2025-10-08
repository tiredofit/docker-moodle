# nfrastack/container-moodle

## About

This repository will build a container image for building [Moodle](https://www.moodle.org/). A Learning management System.

## Maintainer

* [Nfrastack](https://www.nfrastack.com)

## Table of Contents

* [About](#about)
* [Maintainer](#maintainer)
* [Table of Contents](#table-of-contents)
* [Installation](#installation)
  * [Prebuilt Images](#prebuilt-images)
  * [Quick Start](#quick-start)
  * [Persistent Storage](#persistent-storage)
* [Configuration](#configuration)
  * [Environment Variables](#environment-variables)
    * [Base Images used](#base-images-used)
    * [Core Configuration](#core-configuration)
  * [Users and Groups](#users-and-groups)
  * [Networking](#networking)
* [Maintenance](#maintenance)
  * [Shell Access](#shell-access)
* [Support & Maintenance](#support--maintenance)
* [License](#license)
* [References](#references)

## Installation

### Prebuilt Images

Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-moodle/pkgs/container/container-moodle) and [Docker Hub](https://hub.docker.com/r/nfrastack/moodle).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-moodle:(image_tag)
docker.io/nfrastack/moodle:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>-<optional phpversion>`

Example:

`docker.io/nfrastack/container-moodle:latest` or

`ghcr.io/nfrastack/container-moodle:1.0-php84`

* `latest` will be the most recent commit

* An optional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest

* There may be an optional `phpversion` if there are mutiple builds using different PHP interpreters you may use those
Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map [persistent storage](#persistent-storage) for access to configuration and data files for backup.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image.

### Persistent Storage

The following directories/files should be mapped for persistent storage in order to utilize the container effectively.

| Directory     | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `/www/moodle` | Root moodle Directory                                         |
| `/data`       | Course and other Moodle Data seperate from installation files |

### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                                 | Description         |
| --------------------------------------------------------------------- | ------------------- |
| [OS Base](https://github.com/nfrastack/container-base/)               | Base Image          |
| [Nginx](https://github.com/nfrastack/container-nginx/)                | Nginx Webserver     |
| [Nginx PHP-FPM](https://github.com/nfrastack/container-nginx-php-fpm) | PHP-FPM Interpreter |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

### Required Always

| Parameter              | Description                                                         | Default  | `_FILE` |
| ---------------------- | ------------------------------------------------------------------- | -------- | ------- |
| `DATA_PATH`            | Moodle Data and Course related files                                | `/data/` |         |
| `CRON_INTERVAL`        | Time in minutes to be required to perform inernal maintenance tasks | `1`      |         |
| `ENABLE_REVERSE_PROXY` | Tweak nginx to run behind a reverse proxy for URLs `TRUE` / `FALSE` | `TRUE`   |         |

#### First Insall Only or Upgrades

| Parameter             | Description                                                                         | Default       | `_FILE` |
| --------------------- | ----------------------------------------------------------------------------------- | ------------- | ------- |
| `MOODLE_VERSION`      | Used to choose what Moodle Installation to install or Upgrade to                    | (most recent) |         |
| `ENABLE_AUTO_UPGRADE` | `TRUE` / `FALSE` if you pass a different `MOODLE_VERSION` than originally installed |               |         |
| `ADMIN_EMAIL`         | Email address for the Administrator                                                 |               | x       |
| `ADMIN_USER`          | Username for the Administrator                                                      |               | x       |
| `ADMIN_PASS`          | Password for the Administrator                                                      |               | x       |
| `DB_HOST`             | MariaDB external container hostname (e.g. moodle-db)                                |               | x       |
| `DB_NAME`             | MariaDB database name i.e. (e.g. moodle)                                            |               | x       |
| `DB_USER`             | MariaDB username for database (e.g. moodle)                                         |               | x       |
| `DB_PASS`             | MariaDB password for database (e.g. userpassword)                                   |               | x       |
| `DB_PORT`             | MariaDB Port                                                                        | `3306`        | x       |
| `LANGUAGE`            | Site Lanaguage                                                                      | `en`          |         |
| `SITE_PORT`           | What Port does moodle deliver assets to                                             | `80`          |         |
| `SITE_NAME`           | The title of the Website                                                            |               |         |
| `SITE_SHORT_NAME`     | The short name of site e.g. `example`                                               |               |         |
| `SITE_URL`            | The Full site URL of the installation                                               |               |         |
|                       | e.g. `moodle.example.com`                                                           |               |         |

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.

## Support & Maintenance

* For community help, tips, and community discussions, visit the [Discussions board](/discussions).
* For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
* To report bugs, submit a [Bug Report](issues/new). Usage questions will be closed as not-a-bug.
* Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
* Updates are best-effort, with priority given to active production use and support agreements.

## References

* https://www.moodle.org
* https://www.github.com/tmuras/moosh/

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

