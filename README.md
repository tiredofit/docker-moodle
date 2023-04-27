# github.com/tiredofit/docker-moodle

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-moodle?style=flat-square)](https://github.com/tiredofit/docker-moodle/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-moodle/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-moodle/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/moodle.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/moodle/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/moodle.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/moodle/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)
## About

This will build a Docker Image for [Moodle](https://www.moodle.org/), a learning management system.

* Automatically download latest version of Moodle if not installed
* Install Database
* Includes [Moosh](https://www.github.com/tmuras/moosh/)

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Required Always](#required-always)
    - [First Insall Only](#first-insall-only)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [Maintenance](#maintenance-1)
  - [Shell Access](#shell-access-1)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)

## Installation

### Build from Source
Clone this repository and build the image with `docker build <arguments> (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/moodle)

```bash
docker pull docker.io/tiredofdit/moodle:(imagetag)
```

Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/docker-moodle/pkgs/container/docker-moodle)

```
docker pull ghcr.io/tiredofit/docker-moodle:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| PHP version | OS     | Tag       |
| ----------- | ------ | --------- |
| 8.0.x       | Alpine | `:latest` |
#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`


## Configuration
### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory     | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `/www/moodle` | Root moodle Directory                                         |
| `/www/data`   | Course and other Moodle Data seperate from installation files |
| `/www/logs`   | Nginx and php-fpm logfiles                                    |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                         | Description                            |
| ------------------------------------------------------------- | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/)        | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)           | Nginx webserver                        |
| [PHP-FPM](https://github.com/tiredofit/docker-nginx-php-fpm/) | PHP Interpreter                        |

#### Required Always
| Parameter     | Description                                                         | Default      | `_FILE` |
| ------------- | ------------------------------------------------------------------- | ------------ | ------- |
| `CRON_PERIOD` | Time in minutes to be required to perform inernal maintenance tasks | `15`         |         |
| `DATA_PATH`   | Moodle Data and Course related files                                | `/www/data/` |         |
| `DB_HOST`     | MariaDB external container hostname (e.g. moodle-db)                |              | x       |
| `DB_NAME`     | MariaDB database name i.e. (e.g. moodle)                            |              | x       |
| `DB_USER`     | MariaDB username for database (e.g. moodle)                         |              | x       |
| `DB_PASS`     | MariaDB password for database (e.g. userpassword)                   |              | x       |
| `DB_PORT`     | MariaDB Port                                                        | `3306`       | x       |

#### First Insall Only
| Parameter              | Description                                                         | Default              | `_FILE` |
| ---------------------- | ------------------------------------------------------------------- | -------------------- | ------- |
| `MOODLE_VERSION`       | Used to choose what Moodle Installation to install or Upgrade to    | `Look in Dockerfile` |         |
| `ADMIN_EMAIL`          | Email address for the Administrator                                 |                      | x       |
| `ADMIN_USER`           | Username for the Administrator                                      |                      | x       |
| `ADMIN_PASS`           | Password for the Administrator                                      |                      | x       |
| `ENABLE_REVERSE_PROXY` | Tweak nginx to run behind a reverse proxy for URLs `TRUE` / `FALSE` | `TRUE`               |         |
| `LANGUAGE`             | Site Lanaguage                                                      | `en`                 |         |
| `SITE_PORT`            | What Port does moodle deliver assets to                             | `80`                 |         |
| `SITE_NAME`            | The title of the Website                                            | ``                   |         |
| `SITE_SHORT_NAME`      | The short name of site e.g. `example`                               | ``                   |         |
| `SITE_URL`             | The Full site URL of the installation e.g. `moodle.example.com`     |                      |         |

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for personalized support
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.
## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. moodle) bash
```

## References

* https://www.moodle.org
* https://www.github.com/tmuras/moosh/
