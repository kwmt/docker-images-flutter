#!/usr/bin/env bash

set -e

docker login --username $DOCKER_USER_NAME --password $DOCKER_PASSWORD

# docker push kwmt/flutter:base
export FLUTTER_VERSION="v1.9.1+hotfix.2"
docker push kwmt/flutter:$FLUTTER_VERSION
docker push kwmt/flutter:latest