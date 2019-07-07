#!/bin/bash
DOCKER_TAG="rmuresano/bdaasjava:0_0_4"
PACKAGE_REPO="../packages"

# In the version file are saved all the references to the
source $PACKAGE_REPO/FileVersions.sh

if [ -d packages ]; then
    rm -rf packages
fi
mkdir -p packages

# Copy file to be trasnferred to the Docker instance
mkdir packages/jre  && tar -xzvf $PACKAGE_REPO/$JAVA_PACKAGE --strip-components 1 -C packages/jre
unzip -d packages/ $PACKAGE_REPO/$SHELLINABOX_PACKAGE && mv packages/shellinabox-2.20 packages/shellinabox

docker build  -t $DOCKER_TAG .
rm -rf packages
