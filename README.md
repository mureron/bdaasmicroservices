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

Para el uso del docker swarm se ha creado un fichero de configuración que permite levantar un pequeño cluster en local utilizando Virtual Box. Este fichero está dentro del directorio Swarm y se llama [ConfigFile.sh](https://github.com/mureron/bdaasmicroservices/blob/master/swarm/configFile.sh)

En este fichero puede cambiar el número de workers, así como el nombre y la cantidad de recursos. 

```
    WORKER_NAME="worker-bdaas"
    MANAGER_NAME="manager-bdaas"
    NUM_WORKERS=3
    WORKER_MEMORY=2048
    MANAGER_MEMORY=4096
```

Finalmente para crear el cluster, se debe llamar el fichero [create-VMCluster.sh](https://github.com/mureron/bdaasmicroservices/blob/master/swarm/create_VMcluster.sh). Con esto se debe crear un cluster de 3 nodos y un master. 

El siguiente paso es crear el entorno de Docker Swarm. Para esto use el fichero [create-swarmEnv.sh](https://github.com/mureron/bdaasmicroservices/blob/master/swarm/create_swarmEnv.sh). Con esto se inicializa el master y se asocian los worker con el token que da el master.

Finalmente, se puede iniciar el cluster haciendo [DeploySwarm.sh](https://github.com/mureron/bdaasmicroservices/blob/master/swarm/deploySwarm.sh)


#### Algunos comandos de Docker Swarm

Entrar en el nodo Master

```
    docker-machine ssh manager-bdaas
```

Obtener la información del cluster. Dentro del nodo máster se puede hacer el siguiente comando y se puede visualizar el leader y los workers

```
    docker node ls
```

Para desplegar un servicio, 

```
    docker stack deploy -c compose-file.yaml

```
Algunos ejemplo se encuentran en el directorio services.

Para activar la interfaz gráfica (SwarmPit), se debe en el nodo máster hacer los siguientes pasos:

```
    git clone https://github.com/swarmpit/swarmpit
    docker stack deploy -c swarmpit/docker-compose.yml swarmpit
```

Esto levanta la interfaz gráfica en el puerto 888, si se desea modificar, hay que modificarlo en el yaml descargado que está en el directorio swarmpit dentro del manager. 


### Kubernetes

Para hacer las pruebas en local con kubernetes, se ha instalado vagrant que es una herramienta para la creación y configuración de entornos de desarrollo virtualizados. Por eso dentro del directorio Kubernetes/cluster, se encuentra un fichero llamado [VagranFile](https://github.com/mureron/bdaasmicroservices/blob/master/kubernetes/cluster/Vagrantfile). Este fichero permite crear un entorno que instala todas las dependencias para usar kubernetes, además configura e inicializa el cluster. Para este proceso se debe hacer. 

```
    vagrant up
```

Aquí nos podemos tomar un café, mientras el sistema se configura prácticamente solo. 

Una vez finalizado ya tendríamos un cluster de kubernetes configurado y listo para usar. Entonces los siguientes pasos nos permitirán levantar el dashboard para tener una visión de los despliegues de Kubernetes: 

1) En el directorio de Configuración hay un directorio llamado Dashboard. Este directorio contiene los fichero yaml que permiten hacer el despliegue del dashboard. Copie ambos ficheros a un directorio dentro del máster o cree dos ficheros yaml con el contenido. 

2) Despliegue  un usuario de la siguiente forma: 

```
 kubectl apply -f dashboard-user.yaml
```

3) Despliegue  el dashboard de la siguiente forma.

```
  kubectl apply -f kubernetes-dashboard.yaml
```

4) A este punto lo tenemos visible en el clúster pero no se puede visualizar desde el host. Para visualizarlo desde el host se debe hacer lo siguiente: 

```
  kubectl proxy --address 0.0.0.0 --accept-hosts='^*$' &
```
Esto levanta un proxy en el puerto 8001 que es donde escucha el sistema. El dashboard por seguridad permite acceso a través de localhost y no desde una IP en concreto por lo tanto, abra un nuevo terminal y haga un tunel ssh de la siguiente manera: 

```
    ssh -L 8001:localhost:8001 vagrant@192.168.205.10
```
Este comando pedirá un password, ese password es "vagrant", se ha puesto por defecto por temas didáctivos. 

Si todo a ido bien se podría ver desde el navegador el dashboard. 

URL: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login 


Para acceder al clúster pide un token de seguridad, este token se puede requerir de la siguiente forma: 

```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

```
Copie e token y en teoría debería tener acceso al clúster :)



### Desplegar un servicio de forma manual en kubernetes. 

En caso de que queramos jugar un poco, he incluido un ejemplo que permite levantar el jupyter. Este se encuentra dentro del directorio de Configuracion, en el directorio services/jupyter. Este servicio lo he diseñado con un volumen persistente local, por lo que se deben copiar ambos ficheros Storage-class.yaml, persistent-volumen.yaml y JupyterServiceDepl.yaml. El primero crea una Storage class que es una referencia de volumen, el persistent-volumen.yaml crea el volumen  de tipo local y el segundo hace el proceso de despliegue del servicio. 

Primero creamos el volumen: 

```
    kubectl apply -f StorageClass.yaml
    kubectl apply -f persisten-volumen.yaml
```
Luego lo verificamos con: 

```
    kubectl get pv
```

Deberíamos ver un volumen con el nombre "task-pv-volume" y con un tamaño de 2Gb.

Luego hacemos el despliegue con: 
```
 kubectl apply -f JupyterServiceDepl.yaml
```
Este fichero contiene, el servicio con la redirección del puerto en este caso se usará el puerto 8888, el volumen claim que es el request del disco y finalmente el deployment que tiene las características del despliegue, puertos, variables de entornos y la asociación con el volumen persistente. 

La primera vez puede tardar un poco en desplegar el pod, esto debido a que la imagen la debe descargar de mi repositorio de DockerHub. En caso se querer agilizar, podrían hacer un docker registry dentro del clúster (Por desarrollar).

Para verificar el estado del despliegue puede hacer los siguientes comandos: 

```
  kubectl get pods -o wide
  kubectl get deployments -o wide
  kubectl get services -o wide
```

Al tener desplegado el servicio el jupyter no se podrá ver desde el exterior por que lo kube-proxy no se le pueden asignar loadbalancer que asignen una IP externa (Esto se haría en el Cloud) pero no en local).

Para tener acceso al servicio se puede hacer un port-forward desde el máster de la siguiente manera

```
  kubectl port-forward service <servicio> <puertolocal>:<puertoremoto>
  
```
El nombre del servicio se puede obtener con kubectl ger services

Un ejemplo: 

```
    kubectl port-forward service/jupyter-service-deployment 8002:8888
```
Aquí se está redirigiendo el tráfico del puerto 8888 del servicio al puerto local del máster 8002. 

**Nota: Recuerden que el 8001 se usó para el dashboard**

Luego al hacer el port-forward se debe hacer un tunel ssh para el puerto 8002. Este proceso se puede realmente automatizar. 

Para el tunel ssh, abra un nuevo terminal y haga un tunel ssh de la siguiente manera: 

```
    ssh -L 8002:localhost:8002 vagrant@192.168.205.10
```
Recuerde que el password es vagrant

Finalmente ya tenemos un jupyter ejecutando, en localhost:8002


### Desplegar un servicio de kubernetes con helm. 

Helm es un administador de aplicaciones de Kubernetes. Este trabaja con recetas que son complejas de hacer pero una vez hechas muy fácil de desplegar. 

Para esto se debe instalar helm. Siga las siguientes instrucciones [Helm Instalation](https://helm.sh/docs/using_helm/#installing-helm)

Para desplegar es muy sencillo, se debe buscar el chart que se quiere desplegar y luego se hace 

```
    helm install --name my-release stable/spark
```
Este despliegue levantará un Zeppelin, más un máster y 3 workers. En el directorio de services tengo dos ejemplos con un fichero [values](https://github.com/mureron/bdaasmicroservices/blob/master/kubernetes/Configuration/services/zeppelinspark/values.yaml)

En este fichero se puede modificar el número de worker para ejecutar en local, en mi caso lo he dejado en un worker. Para desplegar con un fichero value propio se debe ejecutar.

```
    helm install --name spark –f values.yaml stable/spark
```

Luego para ver las interfaces se debe hacer el mismo proceso del tunel ssh.

Para cualquier dudad o información, escribir a rmuresano@gmail.com








Algunos puntos técnicos:



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