#!/usr/bin/env bash


echo -e "\e[31mSPARK MASTER\e[32m => IP:$IP, MASTER_PORT:$MASTER_PORT, MASTER_WEBUI_PORT:$MASTER_WEBUI_PORT, DRIVER_PORT:$DRIVER_PORT\e[39m"

export RUNTIME_DIR=/home/legacy
export JAVA_HOME="$RUNTIME_DIR/jre"
export SPARK_HOME="$RUNTIME_DIR/spark"
export HADOOP_HOME="$RUNTIME_DIR/hadoop"
export PATH="$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$HADOOP_CONF_DIR:$PATH"


export SPARK_DIST_CLASSPATH=$(hadoop classpath)


if  [[ $HDFS == "YES" ]]; then
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
    <configuration>
        <property><name>fs.defaultFS</name><value>hdfs://$HOSTNAME:$HDFS_NAMENODE_METADATA_PORT</value></property>
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

      <property><name>dfs.namenode.name.dir</name><value>file:///hdfsdata/nameNode/</value></property>
      <property><name>dfs.namenode.checkpoint.dir</name><value>$HADOOP_HOME/data/secondary</value></property>
      <property><name>dfs.namenode.http-adress</name><value>$HOSTNAME:$HDFS_NAMENODE_WEBUI_PORT</value></property>
      <property><name>dfs.namenode.datanode.registration.ip-hostname-check</name><value>false</value></property>

      <property> <name>dfs.replication</name> <value>$HDFS_REPLICATION_FACTOR</value></property>

      <property> <name>dfs.webhdfs.enabled</name><value>true</value></property>

    </configuration>" > $HADOOP_HOME/etc/hadoop/hdfs-site.xml

    echo "Namenode"

    if [ -e /hdfsdata/nameNode/current/VERSION ]
    then
        echo "Using a Previuslly formatted HDFS file system"
    else
      hdfs namenode -format $HDFS_CLUSTER_NAME
    fi

    hdfs namenode &
    sleep 5
    echo "HDFS READY"
fi


echo "$SPARK_HOME/sbin/start-master.sh -h $HOSTNAME -p $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT"

source ~/.bashrc

$SPARK_HOME/sbin/../bin/spark-class org.apache.spark.deploy.master.Master -h $HOSTNAME -p $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT


echo -e "\n\e[32m\n**********************************************\n               SPARKMASTER READY\n**********************************************\n\e[39m"
