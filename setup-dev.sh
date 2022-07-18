#!/bin/bash

# create if not exist all repo
mkdir -p development

git clone https://github.com/sistemi-cloud-2022/sample-db development/sample-db/
git clone https://github.com/sistemi-cloud-2022/sample development/sample/

git clone https://github.com/sistemi-cloud-2022/sprecsample-db development/sprecsample-db/
git clone https://github.com/sistemi-cloud-2022/sprecsample development/sprecsample/

git clone https://github.com/sistemi-cloud-2022/shipment-db development/shipment-db/
git clone https://github.com/sistemi-cloud-2022/shipment development/shipment/

git clone https://github.com/sistemi-cloud-2022/donor-db development/donor-db/
git clone https://github.com/sistemi-cloud-2022/donor development/donor/

git clone https://github.com/sistemi-cloud-2022/biobank-db development/biobank-db/
git clone https://github.com/sistemi-cloud-2022/biobank development/biobank/

# ---- copy script to update all repos ----

cp -v update-repo.sh development/
chmod u+x development/update-repo.sh

# ---- copy keycloak realm configuration to import with docker-compose ----

cp -r keycloak/imports development

cd development

# ---- get data from db's repo -----

for db in biobank-db donor-db sample-db shipment-db sprecsample-db; do
	cp -v $db/$db.sql imports
done

# ---- build all microservices -----

for service in biobank donor sample shipment sprecsample; do
	cd $service
	./build.sh
	cd ..
done

cd ..

# copy docker-compose in dev folder to be executed

cp -v docker-compose.yml development/docker-compose.yml