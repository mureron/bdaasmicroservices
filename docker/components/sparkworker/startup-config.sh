#!/usr/bin/env bash

echo -e "\e[31mSPARK MASTER\e[32m => IP:$IP, MASTER_PORT:$SPARK_MASTER_PORT, MASTER_WEBUI_PORT:$SPARK_MASTER_WEBUI_PORT \e[39m"
export RUNTIME_DIR=/home/legacy
export JAVA_HOME="$RUNTIME_DIR/jre"
export SPARK_HOME="$RUNTIME_DIR/spark"
export HADOOP_HOME="$RUNTIME_DIR/hadoop"
export PATH="$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$HADOOP_CONF_DIR:$PATH"

echo "export SPARK_HOME=$SPARK_HOME" >> $HOME/.bashrc
echo "export PYTHONPATH=$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.10.6-src.zip:$PYTHONPATH" >> $HOME/.bashrc


export SPARK_DIST_CLASSPATH=$(hadoop classpath)

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
      <property><name>dfs.webhdfs.enabled</name><value>true</value></property>
      <property><name>dfs.permissions.enabled</name><value>false</value></property>
      <property><name>dfs.client.use.datanode.hostname</name><value>false</value></property>
      <property><name>dfs.datanode.use.datanode.hostname</name><value>false</value></property>

      <property><name>dfs.namenode.name.dir</name><value>file:///data/nameNode</value></property>
      <property><name>dfs.namenode.http-address</name><value>$HDFS_NAMENODE_HOSTNAME:$HDFS_NAMENODE_WEBUI_PORT</value></property>
      <property><name>dfs.datanode.data.dir</name><value>file:///data/dataNode</value></property>
      <property><name>dfs.namenode.http-adress</name><value>$HOSTNAME:$HDFS_NAMENODE_WEBUI_PORT</value></property>
      <property> <name>dfs.replication</name> <value>$HDFS_REPLICATION_FACTOR</value></property>
  </configuration>" > $HADOOP_HOME/etc/hadoop/hdfs-site.xml

  echo "Datanode"
  # Start Datanode
  hdfs datanode &
fi

echo "Worker: $HOSTNAME Connected to spark://$SPARK_MASTER_HOSTNAME:$SPARK_MASTER_PORT --webui-port $SPARK_WORKER_WEBUI_PORT"

source ~/.bashrc

# Starting the Spark Worker
$SPARK_HOME/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker spark://$SPARK_MASTER_HOSTNAME:$SPARK_MASTER_PORT --webui-port $SPARK_WORKER_WEBUI_PORT
