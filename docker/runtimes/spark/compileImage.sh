#!/bin/bash
DOCKER_TAG="rmuresano/bdaasspark:0_0_4"
PACKAGE_REPO="../packages"

# In the version file are saved all the references to the
source $PACKAGE_REPO/FileVersions.sh

if [ -d packages ]; then
    rm -rf packages
fi

mkdir -p packages

# Copy file to be trasnferred to the Docker instance

echo $PACKAGE_REPO/$HADOOP_PACKAGE
#Installing Hadoop
mkdir packages/hadoop && tar -xzvf $PACKAGE_REPO/$HADOOP_PACKAGE --strip-components 1 -C packages/hadoop

#Installing Spark
mkdir packages/spark  && tar -xzvf $PACKAGE_REPO/$SPARK_PACKAGE --strip-components 1 -C packages/spark
mv packages/spark/conf/spark-env.sh.template packages/spark/conf/spark-env.sh
mv packages/spark/conf/log4j.properties.template packages/spark/conf/log4j.properties
mv packages/spark/conf/spark-defaults.conf.template packages/spark/conf/spark-defaults.conf
echo 'export SPARK_DIST_CLASSPATH=$(/home/legacy/hadoop/bin/hadoop classpath):/home/legacy/hadoop/share/hadoop/tools/lib/*' >> packages/spark/conf/spark-env.sh

#Installing Dependencies JAR SPARK

cp $PACKAGE_REPO/$SPARK_CASSANDRA_CONNECTOR_PACKAGE packages/spark/jars

docker build  -t $DOCKER_TAG .
#rm -rf packages
