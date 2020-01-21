#!/usr/bin/env bash

set -e

docker login --username $DOCKER_USER_NAME --password $DOCKER_PASSWORD

# docker push kwmt/flutter:base
export FLUTTER_VERSION="1.12.13+hotfix.5"
docker push kwmt/flutter:$FLUTTER_VERSION
docker push kwmt/flutter:latest