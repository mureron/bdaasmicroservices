#!/usr/bin/env bash
export RUNTIME_DIR=/home/legacy
export JAVA_HOME="$RUNTIME_DIR/jre"
export CASSANDRA_HOME="$RUNTIME_DIR/cassandra"
export PATH="$PATH:$JAVA_HOME/bin:$CASSANDRA_HOME/bin"
export LISTEN_ADDRESS=$(hostname -i)

if [[ -z "$CASSANDRA_SEEDS" ]];
then
    export CASSANDRA_SEEDS=$LISTEN_ADDRESS
fi

# Yaml
echo "cluster_name: $CLUSTER_NAME" >> $CASSANDRA_HOME/conf/cassandra.yaml
echo "listen_address: $LISTEN_ADDRESS" >> $CASSANDRA_HOME/conf/cassandra.yaml
echo "rpc_address: $LISTEN_ADDRESS" >> $CASSANDRA_HOME/conf/cassandra.yaml
echo "native_transport_port: $NATIVE_TRANSPORT_PORT" >> $CASSANDRA_HOME/conf/cassandra.yaml
echo "rpc_port: $RPC_PORT" >> $CASSANDRA_HOME/conf/cassandra.yaml
echo "storage_port: $STORAGE_PORT" >> $CASSANDRA_HOME/conf/cassandra.yaml


echo "seed_provider:" >> $CASSANDRA_HOME/conf/cassandra.yaml
    # Addresses of hosts that are deemed contact points.
    # Cassandra nodes use this list of hosts to find each other and learn
    # the topology of the ring.  You must change this if you are running
    # multiple nodes!
    echo -e "  - class_name: org.apache.cassandra.locator.SimpleSeedProvider" >> $CASSANDRA_HOME/conf/cassandra.yaml
        echo -e "    parameters:" >> $CASSANDRA_HOME/conf/cassandra.yaml
            # seeds is actually a comma-delimited list of addresses.
            # Ex: "<ip1>,<ip2>,<ip3>"
            echo -e "      - seeds: \"$CASSANDRA_SEEDS\"" >> $CASSANDRA_HOME/conf/cassandra.yaml

# CQLSH
echo "[connection]" >> $CASSANDRA_HOME/conf/.cqlshrc
# The host to connect to
echo "hostname = $LISTEN_ADDRESS" >> $CASSANDRA_HOME/conf/.cqlshrc
# The port to connect to (9042 is the native protocol default)
echo "port = $NATIVE_TRANSPORT_PORT" >> $CASSANDRA_HOME/conf/.cqlshrc

echo "Cassandra finished setup."

$CASSANDRA_HOME/bin/cassandra -f -R
