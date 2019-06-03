#!/bin/bash
DOCKER_TAG="bdaaspython:0_0_1"
PACKAGE_REPO="../packages"

# In the version file are saved all the references to the
source $PACKAGE_REPO/FileVersions.sh

docker build  -t $DOCKER_TAG .

rm -rf packages
