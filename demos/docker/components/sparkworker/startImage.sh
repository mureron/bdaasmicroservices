#!/bin/bash
DOCKER_TAG="components/bdaassparkworker:0_0_1"
PACKAGE_REPO="../runtimes/packages"


if [ -d packages ]; then
    rm -rf packages
fi

mkdir -p packages
cp startup-config.sh packages/startup-config.sh


docker build  -t $DOCKER_TAG .

rm -rf packages