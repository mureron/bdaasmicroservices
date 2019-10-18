#!/bin/bash

source ./configFile.sh

 # Se debe configurar primero el virtual switch 

# Verify if a node is in the docker-machine list
MACHINE_LIST=$(docker-machine ls | awk '{if(NR>1)print $1}')
MASTERFLAG=false
for MACHINE_MEMBERS in ${MACHINE_LIST[@]}; do 

    if [ "$MANAGER_NAME" = "$MACHINE_MEMBERS" ]; then
        MASTERFLAG=true
        echo "[ÌNFO] There is a previusly Manager created"
        echo "[INFO] Delete in case to create a new cluster"
    fi
done 

if [ "$MASTERFLAG" =  false ]; then
    echo "[ÌNFO] Creating Manager Image"
    docker-machine create --driver hyperv --hyperv-virtual-switch seminario --hyperv-memory $MANAGER_MEMORY $MANAGER_NAME &
fi

# Creating workers

for WORKERS in $(seq 1 $NUM_WORKERS) 
do 
    echo "[INFO] Creating Image "$WORKER_NAME-${WORKERS}
    docker-machine create --driver hyperv --hyperv-virtual-switch seminario --hyperv-memory  $WORKER_MEMORY  "$WORKER_NAME-${WORKERS}" &
done