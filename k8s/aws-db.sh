#!/bin/bash

kubectl create namespace biobank
kubectl create namespace donor
kubectl create namespace sample
kubectl create namespace shipment
kubectl create namespace sprecsample

kubectl apply -f biobank-db-config.yaml -n biobank
kubectl apply -f biobank-db.yaml -n biobank

kubectl apply -f donor-db-config.yaml -n donor
kubectl apply -f donor-db.yaml -n donor

kubectl apply -f sample-db-config.yaml -n sample
kubectl apply -f sample-db.yaml -n sample

kubectl apply -f shipment-db-config.yaml -n shipment
kubectl apply -f shipment-db.yaml -n shipment

kubectl apply -f sprecsample-db-config.yaml -n sprecsample
kubectl apply -f sprecsample-db.yaml -n sprecsample

