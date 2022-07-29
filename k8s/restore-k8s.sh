#!/bin/bash

kubectl delete pods --all
kubectl delete svc --all
kubectl delete deployment --all
kubectl delete configmap --all
kubectl delete secret --all
kubectl get all