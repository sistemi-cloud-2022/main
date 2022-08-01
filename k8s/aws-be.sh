#!/bin/bash

# kubectl apply -f biobank-be-deployment.yaml
# kubectl apply -f biobank-be-service.yaml 

kubectl apply -f donor-be-deployment.yaml 
kubectl apply -f donor-be-service.yaml

# kubectl apply -f sample-be-deployment.yaml
# kubectl apply -f sample-be-service.yaml

# kubectl apply -f shipment-be-deployment.yaml
# kubectl apply -f shipment-be-service.yaml

# kubectl apply -f sprecsample-be-deployment.yaml
# kubectl apply -f sprecsample-be-service.yaml

