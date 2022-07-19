# sistemi-cloud-unict-2022


Requirements:

<ul>
    <li>Docker</li>
</ul>

## Setup Keycloack

Download latest image from docker

`docker pull jboss/keycloak`

By default there is no admin user created so you won't be able to login to the admin console. To create an admin account you need to use environment variables to pass in an initial username and password

`docker run -e KEYCLOAK_USER=<USERNAME> -e KEYCLOAK_PASSWORD=<PASSWORD> jboss/keycloak`

Example

`docker run -p 8180:8080  -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak`

Andando su `localhost:8180` sarà possibile accedere alla console con username e password `admin`

È stato creato un realm chiamato Biobank (inserisci considerazioni su perché ne hai creato uno solo)

Sono stati creati dei client così come dei servizi.

Sono stati creati dei client con i seguenti valid-redirect-uri

http://localhost:9095/*     Donor Service
http://localhost:9092/*     Sample Service
http://localhost:9091/*     Shipment Service
http://localhost:9093/*     Biobank Service
http://localhost:9094/*     Sprec Sample Service

TODO: Conviene inserire un redirect url su Base Url ? 

E si creano i rispettivi ruoli:

role-donor, role-sample, role-shipment, role-biobank, role-sprec ed un 'ruolo composto' amministratore che è composto da i ruoli precedentemente citati.


## Link utili

<ul>
    <li>[Getting started with Keycloack](https://www.keycloak.org/getting-started/getting-started-docker
) (Procedura per creazione utente, realm e client)</li>
    <li>[Setup spring-boot keycloack](https://www.baeldung.com/spring-boot-keycloak )</li>
</ul>

In caso di errori frequenti nell'imagine `docker-compose down --rmi all`

## Docker

Enter inside docker container db

`docker exec -it CONTAINER_ID mysql -u admin -p`

See all db

`SHOW DATABASES;`

Use some DB

`USE DB_NAME;`

Effettuare un dump dal database da un container docker 

```
docker exec CONTAINER_ID /usr/bin/mysqldump -u admin --password=admin DATABASE_NAME > backup.sql --no-tablespaces -y 
```

Copia il file di backup in una directory locale

```
cp backup.sql DIR_DEST | docker exec -i CONTAINER_ID /usr/bin/mysql -u admin --password=admin DATABASE
```


Sostituisci questo il docker docker-compose di development se si vogliono avviare i microservizi utilizzando le build delle immagini in locale (TODO: verificare se può essere utile inserire dentro il docker-compose.yml del developement questo di seguito piuttosto che quello utilizzato prendendo le immagini da docker hub)

`````
version: '3.9'

volumes:
  mysql_data:
      driver: local

services:
  keycloak_db:
      image: mysql:5.7
      volumes:
        - mysql_data:/var/lib/keycloak_db
      environment:
        MYSQL_ROOT_PASSWORD: root
        MYSQL_DATABASE: keycloak
        MYSQL_USER: keycloak
        MYSQL_PASSWORD: password
  keycloak:
      image: jboss/keycloak:16.1.1
      # build:
      #   context: services/keycloak
      volumes:
        - ./imports:/opt/jboss/keycloak/imports
      command: 
        - "-b 0.0.0.0 -Dkeycloak.import=/opt/jboss/keycloak/imports/realm-export.json"

      environment:
        DB_VENDOR: MYSQL
        DB_ADDR: keycloak_db
        DB_DATABASE: keycloak
        DB_USER: keycloak
        DB_PASSWORD: password
        KEYCLOAK_USER: admin
        KEYCLOAK_PASSWORD: admin
        # Uncomment the line below if you want to specify JDBC parameters. The parameter below is just an example, and it shouldn't be used in production without knowledge. It is highly recommended that you read the MySQL JDBC driver documentation in order to use it.
        #JDBC_PARAMS: "connectTimeout=30000"
      ports:
        - 8180:8080
      depends_on:
        - keycloak_db

  shipmentService:
    depends_on:
      - shipment_db
    image: shipment:latest
    restart: unless-stopped
    ports:
      - 9091:9091
    environment:
      SERVER_PORT: 9091
      MYSQL_HOST: shipment_db
      APP_SAMPLESERVICE: "http://sampleService:9092"
      APP_BIOBANKSERVICE: "http://biobankService:9093"
  
  shipment_db:
    image: mysql:5.7
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: shipment_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
      volumes:
    volumes:
      - "./imports/shipment-db.sql:/docker-entrypoint-initdb.d/1.sql"
    container_name: shipment_db
  sampleService:
    depends_on:
      - sample_db
    image: sample:latest
    restart: unless-stopped
    ports:
      - 9092:9092
    environment:
      SERVER_PORT: 9092
      MYSQL_HOST: sample_db
      # APP_USERSERVICE: "http://authenticationService:9090" TODO: Sostituire con keycloack?
      APP_SHIPMENTSERVICE: "http://shipmentService:9091"
      APP_BIOBANKSERVICE: "http://biobankService:9093"
      APP_DONORSERVICE: "http://donorService:9095"
  
  sample_db:
    image: mysql:5.7
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: sample_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
    volumes:
      - "./imports/sample-db.sql:/docker-entrypoint-initdb.d/1.sql"
    container_name: sample_db

  biobankService:
    depends_on:
      - biobank_db
    image: biobank:latest
    restart: unless-stopped
    ports:
      - 9093:9093
    environment:
      SERVER_PORT: 9093
      MYSQL_HOST: biobank_db

  biobank_db:
    image: mysql:5.7
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: biobank_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
    volumes:
      - "./imports/biobank-db.sql:/docker-entrypoint-initdb.d/1.sql"
    container_name: biobank_db

  donorService:
    depends_on:
      - donor_db
    image: donor:latest
    restart: unless-stopped
    ports:
      - 9095:9095
    environment:
      SERVER_PORT: 9095
      MYSQL_HOST: donor_db

  donor_db:
    image: mysql:5.7
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: donor_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
    volumes:
      - "./imports/donor-db.sql:/docker-entrypoint-initdb.d/1.sql"
    container_name: donor_db

  sprecsampleService:
    depends_on:
      - sprecsample_db
    image: sprecsample:latest
    restart: unless-stopped
    ports:
      - 9094:9094
    environment:
      SERVER_PORT: 9094
      MYSQL_HOST: sprecsample_db

  sprecsample_db:
    image: mysql:5.7
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: sprecsample_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
    volumes:
      - "./imports/sprecsample-db.sql:/docker-entrypoint-initdb.d/1.sql"
    container_name: sprecsample_db
`````


## Kubernetes

Create and start the cluster 

`minikube start --driver docker`

See if everything is running properly

`minikube status`

Display all nodes in cluster

`kubectl get node`

Inside folder `k8s-demo`, four configuration files:

<ul>
  <li>Mysql Endopoint</li>
  <li>Secret Mysql user & pswd</li>
  <li>Deployment & Service: </li> mysqlApplication with internal service
  <li>Deployment & Service: </li> some microservice config files
</ul>

Create secret first (do for config and secret, first database after be)

`kubectl apply -f CONFIG_FILE.yaml`

Get info:

`kubectl get all`

`kubectl describe NAME_OF_SERVICE NAME_OF_SPECIFIC_SERVICE`

examples:

`kubectl describe service donor-service`

`kubectl describe pod donor-deployment-756b467d4d-2g7xk`

`kubectl logs POD_NAME -f`

How to access service from browser?

`kubectl get svc -o wide`

`minikube ip`

How to get internal IP:

`kubectl get node -o wide` 

Get minikube IP and listen to that port


Entrare in bash all'interno di un pod DB mysql:

`kubectl exec --stdin --tty POD_NAME -- /bin/bash` 

`mysql -p` com password `root`