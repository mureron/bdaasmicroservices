## Eliminar node de ssh-host

ssh-keygen -R <host>

## start the proxy to redirect the dashboard

kubectl proxy --address 0.0.0.0 --accept-hosts='^*$' &

## Create a tunnel to the node

ssh -L 8001:localhost:8001 vagrant@192.168.205.10

## Get Token to user authorization 

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

## Setup Node Vagrant

sudo nano /etc/default/kubelet

Dentro del fichero se debe configurar lo siguiente: 

KUBELET_EXTRA_ARGS=--node-ip=$PRIVATE_IP


sudo systemctl daemon-reload
sudo systemctl restart kubelet

=== Finalmente en el master

sudo systemctl daemon-reload
sudo systemctl restart kubelet


## Acceso a los nodos

He incluido en el fichero de vagrant lo siguiente
echo $IP_ADDR
    # set node-ip
sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet

echo "KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" > /etc/default/kubelet
   

## PORT FORWARD

Doc: https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/


Se debe colocar un port-foward desde el master al puerto donde está levantado el pod


**kubectl port-forward service <servicio> <puertolocal>:<puertoremoto>

kubectl port-forward service/jupyter-service-deployment 8002:8888

Luego se realiza el tunnel ssh.
ssh -L 8001:localhost:8001 vagrant@192.168.205.10

## Set Env variables

spec:
      containers:
      - name: rmuresano-jupyter
        image: rmuresano/bdaasjupyter:0_0_2
        env: 
        - name: STANDALONE
          value: "YES"
        - name: CASSANDRA
          value: "NO"
        - name: HDFS
          value: "NO"
        - name: JUPYTERPORT
          value: "8888"  

Las variables aunque sean numéricas deben estar entre comillas.


## Persistent Local Volumen

Para los volúmenes persistentes se debe colocar un StorageClass que define el volument en el sistema

luego se agregan los parámetros en el manifiesto 