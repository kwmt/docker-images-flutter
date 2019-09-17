#!/usr/bin/env bash

set -e

# pull to make sure we are not rebuilding for nothing
# docker pull kwmt/flutter:base

# docker build --tag kwmt/flutter:base base
docker build --tag kwmt/flutter:v1.9.1+hotfix.2  --tag kwmt/flutter:latest ./