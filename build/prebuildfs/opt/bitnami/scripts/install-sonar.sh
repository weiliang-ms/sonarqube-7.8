#!/bin/bash

# https://github.com/SonarSource/docker-sonarqube/blob/master/7/community/Dockerfile

export SONAR_VERSION=7.8
groupadd -r sonarqube && useradd -r -g sonarqube sonarqube

set -x \
    && cd /opt/bitnami \
    && curl -o sonarqube.zip -fSL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && unzip -q sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && chown -R sonarqube:sonarqube sonarqube \
    && chmod -R 0644 sonarqube \
    && rm sonarqube.zip*

    # todo verify
    # && curl -o sonarqube.zip.asc -fSL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    # && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \