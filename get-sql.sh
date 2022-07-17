#!/bin/bash

for db in biobank-db donor-db sample-db shipment-db sprecsample-db; do
	cp -v $db/$db.sql $db.sql
done
