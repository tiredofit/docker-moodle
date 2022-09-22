FROM docker.io/tiredofit/nginx-php-fpm:7.4
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

ARG MOODLE_VERSION
ENV MOODLE_VERSION=${MOODLE_VERSION:-"3.11"} \
    NGINX_WEBROOT="/www/moodle" \
    NGINX_SITE_ENABLED="moodle" \
    IMAGE_NAME="tiredofit/moodle" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-moodle"

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .moodle-run-deps \
                aspell \
                email \
                git \
                graphviz \
                python3\
                sassc \
                texlive \
                && \
    \
    ## Install Moosh
    mkdir -p /opt/moosh && \
    git clone https://github.com/tmuras/moosh.git /opt/moosh && \
    cd /opt/moosh && \
    composer install --ignore-platform-reqs && \
    ln -s moosh.php /usr/bin/moosh && \
    rm -rf /usr/src/* /var/tmp/* /var/cache/apk/*

### Configuration Setup
ADD install /
