#!/usr/bin/env bash

set -e

# pull to make sure we are not rebuilding for nothing
# docker pull marekchen/flutter:base

# docker build --tag marekchen/flutter:base base
docker build --tag marekchen/flutter:0.5.7 --tag marekchen/flutter:latest ./