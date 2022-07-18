#!/bin/bash

# ---- pull edits from existing repos ----

for service in biobank biobank-db donor donor-db sample sample-db shipment shipment-db sprecsample sprecsample-db; do
	cd $service
	git pull origin main
	./build.sh
	cd ..
done

# ---- clone main because i want to get the update of keycloak configuration and docker-compose.yml

git clone https://github.com/sistemi-cloud-2022/main 

# ---- delete older imports and docker-compose

rm -rf imports
rm docker-compose.yml

mkdir -p imports

# ---- get updated docker-compose and imports

cp -v main/docker-compose.yml .

cp -r main/keycloak/imports .

for db in biobank-db donor-db sample-db shipment-db sprecsample-db; do
	cp -v $db/$db.sql imports
done

# ---- remove main repository that is not necessary for execution

rm -rf main
