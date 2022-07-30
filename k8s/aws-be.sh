#!/bin/bash

# kubectl apply -f biobank-db-config.yaml
# kubectl apply -f biobank-db.yaml

kubectl apply -f donor-be-deployment.yaml -n donor
kubectl apply -f donor-be-service.yaml -n donor

# kubectl apply -f sample-db-config.yaml
# kubectl apply -f sample-db.yaml

# kubectl apply -f shipment-db-config.yaml
# kubectl apply -f shipment-db.yaml

# kubectl apply -f sprecsample-db-config.yaml
# kubectl apply -f sprecsample-db.yaml

