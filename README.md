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

## Comandi utili

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