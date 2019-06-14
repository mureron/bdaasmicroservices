#!/bin/bash
# This File download all packages needs to create the BDaaS provide. The version are controlled according to the versions defined
# in the file FileVersions.sh

# File Versions
source FileVersions.sh

# Verify the JAVA Installer
if [  ! -f "$JAVA_PACKAGE" ]; then
    echo "[INFO] $JAVA_PACKAGE] does not exist"
    echo "[INFO] Prepare to download it"
    echo "[INFO] You have to download from Oracle JRE "
else
    echo "[INFO] JAVA OK"
fi

if [  ! -f "$MINICONDA_PACKAGE" ]; then
    echo "[INFO] $MINICONDA_PACKAGE does not exist"
    echo "[INFO] Prepare to download it"
    wget -O $MINICONDA_PACKAGE $MINICONDA_URL_DOWNLOAD
else
    echo "[INFO] MINICONDA OK"
fi

if [  ! -f "$SPARK_PACKAGE" ]; then
    echo "[INFO] $SPARK_PACKAGE does not exist"
    echo "[INFO] Prepare to download it"
    wget -O $SPARK_PACKAGE $SPARK_URL_DOWNLOAD
else
    echo "[INFO] SPARK OK"
fi

if [  ! -f "$SHELLINABOX_PACKAGE" ]; then
    echo "[INFO] $SHELLINABOX_PACKAGE does not exist"
    echo "[INFO] Prepare to download it"
    wget -O $SHELLINABOX_PACKAGE $SHELLINABOX_URL_DOWNLOAD
else
    echo "[INFO] SHELLINABOX OK"
fi

if [  ! -f "$HADOOP_PACKAGE" ]; then
    echo "[INFO] $HADOOP_PACKAGE does not exist"
    echo "[INFO] Prepare to download it"
    wget -O $HADOOP_PACKAGE $HADOOP_URL_DOWNLOAD
else
    echo "[INFO] HADOOP OK"
fi

if [  ! -f "$CASSANDRA_PACKAGE" ]; then
    echo "[INFO] $CASSANDRA_PACKAGE does not exist"
    echo "[INFO] Prepare to download it"
    wget -O $CASSANDRA_PACKAGE $CASSANDRA_URL_DOWNLOAD
else
    echo "[INFO] CASSANDRA OK"
fi

if [  ! -f "$SPARK_CASSANDRA_CONNECTOR_PACKAGE" ]; then
    echo "[INFO] $SPARK_CASSANDRA_CONNECTOR_PACKAGE does not exist"
    echo "[INFO] Prepare to download it"
    wget -O $SPARK_CASSANDRA_CONNECTOR_PACKAGE $SPARK_CASSANDRA_CONNECTOR_URL_DOWNLOAD 
else
    echo "[INFO] SPARK CASSANDRA CONNECTOR OK"
fi

# Verify if the image exist
DOCKER_BASE=$(docker images --format "{{.Repository}}:{{.Tag}}" ubuntu:latest)
echo "[INFO] Image to Download $DOCKER_BASE"
if [ -z "${DOCKER_BASE-unset}" ]; then
    echo "[INFO] Download the base image from the DockerHUB"
    docker pull ubuntu
else
    echo "[INFO] The Base Image has been previously downloaded"
fi

echo "[INFO] All dependencies have been downloaded Succesfully"