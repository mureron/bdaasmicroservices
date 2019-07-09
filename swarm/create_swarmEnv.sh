#!/bin/bash

source ./configFile.sh

MANAGER_IP=$(docker-machine ls | grep manager-bdaas | awk '{print $5}' | awk -F"[/:]" '{print $4}')

# Creating the Swarm Manager
docker-machine ssh $MANAGER_NAME "docker swarm leave --force"

docker-machine ssh $MANAGER_NAME "docker swarm init --advertise-addr $MANAGER_IP"

#Getting the manager Token to link the Workers.

SWARM_TOKEN=$(docker-machine ssh manager-bdaas "docker swarm join-token worker -q")

for WORKER in  $(seq 1 $NUM_WORKERS) 
do
    docker-machine ssh $WORKER_NAME-$WORKER "docker swarm join --token $SWARM_TOKEN $MANAGER_IP:2377"
    docker-machine ssh $WORKER_NAME-$WORKER "sudo sysctl -w vm.max_map_count=262144"
    docker-machine ssh $WORKER_NAME-$WORKER "sudo echo 'vm.max_map_count=262144' >> /etc/sysctl.conf"
done
