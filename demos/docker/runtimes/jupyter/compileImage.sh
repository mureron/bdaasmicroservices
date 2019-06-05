#!/bin/bash
DOCKER_TAG="rmuresano/bdaasjupyter:0_0_1"
PACKAGE_REPO="../packages"

# In the version file are saved all the references to the
source $PACKAGE_REPO/FileVersions.sh

if [ -d packages ]; then
    rm -rf packages
fi

mkdir -p packages

docker build  -t $DOCKER_TAG .

rm -rf packages
