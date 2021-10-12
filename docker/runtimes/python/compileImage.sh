#!/bin/bash
DOCKER_TAG="rmuresano/bdaaspythonmini:0_0_4"
PACKAGE_REPO="../packages"

# In the version file are saved all the references to the
source $PACKAGE_REPO/FileVersions.sh

if [ -d packages ]; then
    rm -rf packages
fi
mkdir -p packages

cp $PACKAGE_REPO/$MINICONDA_PACKAGE packages/miniconda-installer.sh

docker build  -t $DOCKER_TAG .

rm -rf packages
