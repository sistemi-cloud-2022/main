#!/bin/bash

# for service in biobank donor sample shipment sprecsample; do
# 	cd $service
# 	./build.sh
# 	cd ..
# done

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

cp -v extract-sql.sh development/
chmod u+x development/extract-sql.sh

cp -v build-all.sh development/
chmoud u+x development/build-all.sh

# copy all import keycloak



cd development

./extract-sql.sh

./build-all.sh

cd ..

cp -v docker-compose.yml development/docker-compose.yml