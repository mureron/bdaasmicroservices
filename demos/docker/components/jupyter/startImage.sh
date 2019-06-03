#!/bin/bash
DOCKER_TAG="components/bdaasjupyter:0_0_1"
PACKAGE_REPO="../runtimes/packages"

source $PACKAGE_REPO/versions.sh

if [ -d packages ]; then
    rm -rf packages
fi

mkdir -p packages
cp startup-config.sh packages/startup-config.sh

cp -R examples/ packages/examples

docker build  -t $DOCKER_TAG .

rm -rf packages