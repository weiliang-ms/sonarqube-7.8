FROM docker.io/bitnami/minideb:buster
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux"

ARG JAVA_EXTRA_SECURITY_DIR="/bitnami/java/extra-security"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages.sh acl ca-certificates unzip curl wget gzip gnupg p11-kit libbsd0 libc6 libedit2 libffi6 libgcc1 libgmp10 libgnutls30 libhogweed4 libicu63 libidn2-0 libldap-2.4-2 liblzma5 libnettle6 libp11-kit0 libsasl2-2 libssl1.1 libstdc++6 libtasn1-6 libtinfo6 libunistring2 libuuid1 libxml2 libxslt1.1 procps tar zlib1g

RUN . /opt/bitnami/scripts/libcomponent.sh \
    && component_unpack "postgresql-client" "13.6.0-4" \
      --checksum 10c4c8870775aa837cc37c243b20cde2efd166482aab0df90974c105884ea210
RUN . /opt/bitnami/scripts/install-java.sh
RUN . /opt/bitnami/scripts/install-sonar.sh
RUN . /opt/bitnami/scripts/libcomponent.sh \
    && component_unpack "gosu" "1.14.0-7" \
      --checksum d6280b6f647a62bf6edc74dc8e526bfff63ddd8067dcb8540843f47203d9ccf1 \
    && apt-get update \
    && apt-get upgrade -y \
    && rm -r /var/lib/apt/lists /var/cache/apt/archives \
    && chmod g+rwX /opt/bitnami

COPY rootfs /
RUN /opt/bitnami/scripts/java/postunpack.sh
RUN /opt/bitnami/scripts/sonarqube/postunpack.sh
ENV BITNAMI_APP_NAME="sonarqube" \
    BITNAMI_IMAGE_VERSION="7.8-debian-10-r40" \
    JAVA_HOME="/opt/bitnami/java" \
    PATH="/opt/bitnami/postgresql/bin:/opt/bitnami/java/bin:/opt/bitnami/common/bin:$PATH"

EXPOSE 9000

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/sonarqube/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/sonarqube/run.sh" ]
