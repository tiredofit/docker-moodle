ARG PHP_BASE=8.2
ARG DISTRO="alpine"

FROM docker.io/tiredofit/nginx-php-fpm:${PHP_BASE}-${DISTRO}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG MOODLE_VERSION

ENV MOODLE_VERSION=${MOODLE_VERSION:-"4.4"} \
    NGINX_WEBROOT="/www/moodle" \
    NGINX_SITE_ENABLED="moodle" \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_SOAP=TRUE \
    PHP_ENABLE_SODIUM=TRUE \
    PHP_ENABLE_XMLRPC=TRUE \
    PHP_ENABLE_ZIP=TRUE \
    IMAGE_NAME="tiredofit/moodle" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-moodle"

RUN source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package install .moodle-run-deps \
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
    package cleanup && \
    rm -rf /root/.composer \
           /var/tmp/*

COPY install /
