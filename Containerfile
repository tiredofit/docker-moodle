# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL \
        org.opencontainers.image.title="Moodle" \
        org.opencontainers.image.description="Learning Management System" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/moodle" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/container-moodle/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/container-moodle.git" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"

ARG \
    MOOSH_VERSION="1.27" \
    MOOSH_REPO_URL="https://github.com/tmuras/moosh"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

ENV \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_MODULE_ENABLE_SOAP=TRUE \
    PHP_MODULE_ENABLE_SODIUM=TRUE \
    PHP_MODULE_ENABLE_XMLRPC=TRUE \
    PHP_MODULE_ENABLE_ZIP=TRUE \
    NGINX_WEBROOT="/www/moodle" \
    NGINX_SITE_ENABLED="moodle" \
    IMAGE_NAME="nfrastack/moodle" \
    IMAGE_REPO_URL="https://github.com/nfrastack/container-moodle"

RUN echo "" && \
    MOODLE_RUN_DEPS_ALPINE=" \
                                aspell \
                                email \
                                git \
                                graphviz \
                                python3\
                                sassc \
                                texlive \
                            " \
                            && \
    \
    source /container/base/functions/container/build && \
    container_build_log image && \
    package update && \
    package upgrade && \
    package install \
                    MOODLE_RUN_DEPS \
                    && \
    php-ext prepare && \
    php-ext reset && \
    php-ext enable core && \
    mkdir -p /opt/moosh && \
    clone_git_repo "${MOOSH_REPO_URL}" "${MOOSH_VERSION}" /opt/moosh && \
    cd /opt/moosh && \
    composer install --ignore-platform-reqs && \
    ln -s moosh.php /usr/local/bin/moosh && \
    container_build_log add "Moosh" "${MOOSH_VERSION}" "${MOOSH_REPO_URL}" && \
    rm -rf /opt/moosh/.git && \
    package cleanup

COPY rootfs /
