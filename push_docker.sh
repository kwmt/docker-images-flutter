#!/usr/bin/env bash

set -e

docker login --username $DOCKER_USER_NAME --password $DOCKER_PASSWORD

# docker push kwmt/flutter:base
docker push kwmt/flutter:1.0.0
docker push kwmt/flutter:latest