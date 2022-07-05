#!/bin/bash -x

for service in authentication biobank donor sample shipment sprecsample; do
	cd $service
	./build.sh
	cd ..
done