#!/bin/bash

kubectl apply -f biobank-be-deployment.yaml -n biobank
kubectl apply -f biobank-be-service.yaml -n biobank

kubectl apply -f donor-be-deployment.yaml -n donor
kubectl apply -f donor-be-service.yaml -n donor

kubectl apply -f sample-be-deployment.yaml -n sample
kubectl apply -f sample-be-service.yaml -n sample

kubectl apply -f shipment-be-deployment.yaml -n shipment
kubectl apply -f shipment-be-service.yaml -n shipment

kubectl apply -f sprecsample-be-deployment.yaml -n sprecsample
kubectl apply -f sprecsample-be-service.yaml -n sprecsample

