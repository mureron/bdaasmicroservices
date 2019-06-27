## Orquestación de Servicios

Este repositorio busca agrupar un conjunto de tecnologías para desplegar diferentes orquestadores de servicios con el objetivo de obtener una visión general desde el punto de vista de desarrollo hasta producción.

## ¿Cómo usar este repositorio?

Lo primero que tenemos que crear son las imágenes docker en local, no es un punto necesario porque las mismas están registradas en mi dockerhub personal. Las imagenes se pueden ver aquí [Working Images] (https://cloud.docker.com/u/rmuresano/repository/list).

En caso de querer crear las imágenes en local, se puede hacer aplicando los siguientes pasos:

1) Entrar en el directorio Docker. 
2) Dentro del directorio Docker hay tres directorios "Components, Services, Runtimes". En nuestro caso entraremos en runtime para comenzar el proceso de creación de las imágenes. 
3) Para iniciar el proceso se deben descargar los paquetes. Esto se puede hacer desde el directorio packages y se inicia el proceso [DownloadFiles.sh](https://github.com/mureron/bdaasmicroservices/blob/master/docker/runtimes/packages/DownloadFiles.sh).

En este punto se deben haber descargado todos los ficheros necesarios para hacer las imágenes docker (runtimes) necesarios para la ejecución de los ejemplos. 

4) Luego salimos del directorio packages y desde el directorio de Runtime, podemos ejecutar el fichero [running.sh](https://github.com/mureron/bdaasmicroservices/blob/master/docker/runtimes/running.sh). Este proceso crea las imágenes necesarias para la ejecución de los dockers. 

Nota: En caso de modificar una imagen en concreto, se debe considerar que las mismas tienen una herencia.

Las imágenes parte de una imagen base [Ubuntu:latest](https://hub.docker.com/_/ubuntu) y luego tienen una secuencia de creación. En caso de hacer una imagen en concreto para añadir un paquete, las mismas se deben hacer en este orden. 

Java -> Python -> Spark -> Jupyter.

Si se desea crear una imagen en concreto, se debe entrar en el directorio correspondiente y usar el fichero [compileImage.sh].

## Docker Compose

Para hacer pruebas de desarrollo se ha seleccionado el docker compose, para ejecutar este servicio se deben hacer las diferentes imágenes que usaran los componentes. Los servicios están compuestos por componentes y estos se deben compilar para poder ejecutar. Al compilarlos se crea una imagen docker que será la que se utilizará por el docker-compose. 

En el directorio components hay un fichero [compileComponents.sh](https://github.com/mureron/bdaasmicroservices/blob/master/docker/components/compileComponents.sh). Esto crea la imagen de todos los componentes que se tienen en el repo. En caso de querer añadir alguno y subir el commit por favor mantener el mismo esquema (ayuda al aprendizaje).


### Desplegar Servicios en Docker compose. 

Cada servicio esta compuesto por un fichero yaml, este fichero contiene la información del despliegue (dependencias, puertos, variables de entornos, imagen, etc). Selecciones cualquier servicio entrando en el directorio "services" y dentro puede seleccionar cualquiera de los servicios de ejemplo que se han diseñado para este seminario. Un ejemplo [JupyterSpark](https://github.com/mureron/bdaasmicroservices/blob/master/docker/services/jupyterspark/docker-compose.yml). 

Para ejecutar este servicio, entre en el directorio y use la instrucción
```
    docker-compose up 
```

Para replegar el servicio utilice

```
    docker-compose down
```

Al hacer un docker-compose up, esto levanta el servicio y para acceder se debe usar la IP del contenedor que se asigna y los puertos de las interfaces WebUI. en caso de Spark se ha configurado la 8080 y para el Jupyter la 8900. Es decir se entraría http://IP:8900

Con esto se pueden hacer varias pruebas, instalar librerías, ejecutar algorítmos, etc. 



### Docker Swarm. 










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