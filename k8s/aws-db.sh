#!/bin/bash

kubectl create namespace biobanksprec
# kubectl create namespace donor
# kubectl create namespace sample
# kubectl create namespace shipment
# kubectl create namespace sprecsample

kubectl apply -f biobank-db-config.yaml
kubectl apply -f biobank-db.yaml

kubectl apply -f donor-db-config.yaml
kubectl apply -f donor-db.yaml

kubectl apply -f sample-db-config.yaml
kubectl apply -f sample-db.yaml

kubectl apply -f shipment-db-config.yaml
kubectl apply -f shipment-db.yaml

kubectl apply -f sprecsample-db-config.yaml
kubectl apply -f sprecsample-db.yaml

