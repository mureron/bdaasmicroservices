#!/bin/bash
DOCKER_TAG="rmuresano/bdaascassandra:0_0_4"
PACKAGE_REPO="../../runtimes/packages"
source $PACKAGE_REPO/FileVersions.sh


if [ -d packages ]; then
    rm -rf packages
fi

mkdir -p packages

mkdir packages/cassandra  && tar -xzf $PACKAGE_REPO/$CASSANDRA_PACKAGE --strip-components 1 -C packages/cassandra
cp startup-config.sh packages/startup-config.sh

docker build  -t $DOCKER_TAG .

rm -rf packages