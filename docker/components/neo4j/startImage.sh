#!/bin/bash
DOCKER_TAG="rmuresano/bdaasneo4j:0_0_4"
PACKAGE_REPO="../runtimes/packages"

if [ -d packages ]; then
    rm -rf packages
fi

mkdir -p packages
cp startup-config.sh packages/startup-config.sh

mkdir packages/neo4j && tar -xzvf $PACKAGE_REPO/$NEO4J_PACKAGE  --strip-components 1 -C packages/neo4j 
docker build  -t $DOCKER_TAG .
rm -rf packages