#!/bin/bash
DOCKER_TAG="mydocker_flask:latest"




docker build  -t $DOCKER_TAG .
rm -rf packages
