#!/usr/bin/env bash

set -e

# pull to make sure we are not rebuilding for nothing
# docker pull kwmt/flutter:base

# docker build --tag kwmt/flutter:base base
export FLUTTER_VERSION="1.12.13+hotfix.5"
docker build --tag kwmt/flutter:$FLUTTER_VERSION  --tag kwmt/flutter:latest ./