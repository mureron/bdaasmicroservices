#!/usr/bin/env bash

export RUNTIME_DIR=/home/legacy
export JAVA_HOME="$RUNTIME_DIR/jre"
export SPARK_HOME="$RUNTIME_DIR/spark"
export HADOOP_HOME="$RUNTIME_DIR/hadoop"
export PATH="$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$HADOOP_CONF_DIR:$PATH"

echo "export SPARK_HOME=$SPARK_HOME" >> $HOME/.bashrc


export SPARK_DIST_CLASSPATH=$(hadoop classpath)

mkdir $RUNTIME_DIR/data/nameNode

if  [[ $HDFS == "YES" ]]; then
  # Set up the core-site Xml

  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
  <?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
  <configuration>
      <property><name>fs.defaultFS</name><value>hdfs://$HDFS_NAMENODE_HOSTNAME:$HDFS_NAMENODE_METADATA_PORT</value></property>
      <property><name>hadoop.http.staticuser.user</name><value>root</value></property>
  </configuration>" > $HADOOP_HOME/etc/hadoop/core-site.xml


  # Set path for the HDFS

  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
  <?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
  <configuration>
    <property><name>dfs.permissions.enabled</name><value>false</value></property>
    <property><name>dfs.client.use.datanode.hostname</name><value>false</value></property>
    <property><name>dfs.datanode.use.datanode.hostname</name><value>false</value></property>

    <property><name>dfs.namenode.name.dir</name><value>file:///$RUNTIME_DIR/data/nameNode</value></property>
    <property><name>dfs.namenode.http-adress</name><value>$NAMENODE_HOSTNAME:$HDFS_NAMENODE_WEBUI_PORT</value></property>

    <property><name>dfs.datanode.data.dir</name><value>file:///hdfsdata/dataNode</value></property>
    <property> <name>dfs.replication</name> <value>$HDFS_REPLICATION_FACTOR</value></property>
    <property> <name>dfs.webhdfs.enabled</name><value>true</value></property>
  </configuration>" > $HADOOP_HOME/etc/hadoop/hdfs-site.xml

  echo "Datanode"
  # Start Datanode
  hdfs datanode &
fi


echo "Worker: $HOSTNAME Connected to spark://$SPARK_MASTER_HOSTNAME:$SPARK_MASTER_PORT "

source ~/.bashrc

# Starting the Spark Worker

echo "$SPARK_HOME/sbin/start-master.sh -h $HOSTNAME -p $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT"

$SPARK_HOME/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker spark://$SPARK_MASTER_HOSTNAME:$SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT
