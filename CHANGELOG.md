## 4.4.0pre 2025-10-08 <code at nfrastack dot com>

   ### Changed
      - Switch to nfrastack/nginx-php-fpm
      - MOODLE_VERSION non existence on first boot grabs latest git tag from repository
      - ENABLE_AUTO_UPGRADE works if MOODLE_VERSION differs from original version
      - Change variables and boot logic

## 4.3.99 2025-10-08 <dave at tiredofit dot ca>

Add EOL Notice and deprecate image

## 4.3.2 2024-07-09 <fermion2020@github>

   ### Changed
      - Update nginx configuration for better security


## 4.3.1 2024-04-23 <dave at tiredofit dot ca>

   ### Changed
      - Rerelease of 4.3.0


## 4.3.0 2024-04-23 <dave at tiredofit dot ca>

   ### Added
      - Install Moodle 4.4 release on first install
      - PHP 8.2 base


## 4.2.0 2023-04-26 <dave at tiredofit dot ca>

   ### Added
      - Introduce support for '_FILE' environment variables


## 4.1.0 2022-11-30 <dave at tiredofit dot ca>

   ### Changed
      - Rework Dockerfile to solve installation issues and add optimizations


## 4.0.13 2022-10-05 <dave at tiredofit dot ca>

   ### Changed
      - Migrate legacy nginx configuration


## 4.0.12 2022-09-23 <dave at tiredofit dot ca>

   ### Changed
      - Introduce escaping environment variable for $


## 4.0.11 2022-09-23 <dave at tiredofit dot ca>

   ### Changed
      - Fix changing permissiosn for data path if already created


## 4.0.10 2022-09-23 <dave at tiredofit dot ca>

   ### Changed
      - Fix install for 4 character stable bases


## 4.0.9 2022-09-22 <dave at tiredofit dot ca>

   ### Changed
      - Remove extra curly brace


## 4.0.8 2022-09-22 <dave at tiredofit dot ca>

   ### Added
      - Add PHP Modules for: SOAP, Sodium, XMLRPC, ZIP as per Server environment check page


## 4.0.7 2022-09-22 <dave at tiredofit dot ca>

   ### Changed
      - Update nginx configuration as per https://docs.moodle.org/34/en/Nginx#Nginx


## 4.0.6 2022-09-22 <dave at tiredofit dot ca>

   ### Added
      - Fix Dockerfile build


## 4.0.5 2022-09-22 <dave at tiredofit dot ca>

   ### Added
      - Add alias for 'moosh' in console to automatically populate Moodle directory


## 4.0.4 2022-09-22 <dave at tiredofit dot ca>

   ### Changed
      - Revert to PHP 7.4


## 4.0.3 2022-08-01 <dave at tiredofit dot ca>

   ### Changed
      - Drop cron period to 1 minute


## 4.0.2 2022-07-27 <dave at tiredofit dot ca>

   ### Changed
      - Properly read defaults


## 4.0.1 2022-07-27 <dave at tiredofit dot ca>

   ### Added
      - Support updated tiredofit/nginx and tiredofit/nginx-php-fpm images
      - Dynamically create Crontabs
      - Set additional missing defaults
      - General cleanup of code


## 4.0.0 2021-10-06 <dave at tiredofit dot ca>

   ### Added
      - Refactor Image to support latest base container updates

## 3.51 2018-08-19 <dave at redacted>

* Repair Permissions for /www/moodle

## 3.5 2018-06-10 <dave at redacted>

* Add Graphviz
* Add Aspell

## 3.41 2017-12-11 <dave at redacted>

* Remove Cron Email Script to not blast our email providers

## 3.4 2017-11-30 <dave at redacted>

* Switch to Moodle edge
* Use Alpine Edge as a Base
* Texlive Included

## 3.3 2017-07-06 <dave at redacted>

* Added PHP_TIMEOUT

## 3.2 2017-07-04 <dave at redacted>

* Added TexLive and Glibc

## 3.1 2017-07-03 <dave at redacted>

* Fix S6 Issues and add logrotate

## 3.0 2017-07-01 <dave at redacted>

* Rebase from nginx-php-fpm 5.6 with s6
* Added email apk
*

## 2.1 2017-04-12 <dave at redacted>

* Rebase - Alpine 3.5
* Moodle 2.9.9
* Php5.6-FPM

## 2.0 2017-02-21 <dave at redacted>

* Update to support Zabbix Monitoring

## 1.1 2017-01-26 <dave at redacted>

* Rework to Build in Reverse and SSL Proxy Support
* Pull this repository and update the run.sh and edit the commented field to support downloading a new version (presently it is using 3.2, but it can use 3.1)

## 1.0 2017-01-03 <dave at redacted>

* Alpine:edge
* PHP7
* PHP Composer
