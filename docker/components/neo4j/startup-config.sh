#!/bin/bash

echo -e "\e[32mNEO4J => IP=$HOSTNAME, NEO4J_BOLT_PORT:$NEO4J_BOLT_PORT, NEO4J_WEBUI_PORT:$NEO4J_WEBUI_PORT, PERSISTENT_VOLUME:$PERSISTENT_VOLUME\e[39m"

export INSTALL_DIR="/home/legacy"
export JAVA_HOME="/home/legacy/jre"
export NEO4J_HOME="$INSTALL_DIR/neo4j"
export PATH="$PATH:$JAVA_HOME/bin:$NEO4J_HOME/bin"

echo "Setting configurations for Neo4j..."

echo "
dbms.directories.data=$PERSISTENT_VOLUME
dbms.connectors.default_listen_address=$HOSTNAME
dbms.directories.import=import
dbms.connector.bolt.enabled=true
dbms.connector.bolt.listen_address=$HOSTNAME:$NEO4J_BOLT_PORT
dbms.connector.http.enabled=true
dbms.connector.http.listen_address=$HOSTNAME:$NEO4J_WEBUI_PORT
dbms.connector.https.enabled=false
dbms.tx_log.rotation.retention_policy=1 days
dbms.jvm.additional=-XX:+UseG1GC
dbms.jvm.additional=-XX:-OmitStackTraceInFastThrow
dbms.jvm.additional=-XX:+AlwaysPreTouch
dbms.jvm.additional=-XX:+UnlockExperimentalVMOptions
dbms.jvm.additional=-XX:+TrustFinalNonStaticFields
dbms.jvm.additional=-XX:+DisableExplicitGC
dbms.jvm.additional=-Djdk.tls.ephemeralDHKeySize=2048
dbms.jvm.additional=-Djdk.tls.rejectClientInitiatedRenegotiation=true
dbms.windows_service_name=neo4j
dbms.security.allow_csv_import_from_file_urls=true
dbms.jvm.additional=-Dunsupported.dbms.udc.source=tarball" > $NEO4J_HOME/conf/neo4j.conf

#mv $INSTALL_DIR/*.csv $NEO4J_HOME/import

# Start Neo4j
$NEO4J_HOME/bin/neo4j start

echo -e "\n\e[32m\nNeo4j instance $HOSTNAME deployment finished\n\e[39m" 

while true
do
	sleep 1
done
