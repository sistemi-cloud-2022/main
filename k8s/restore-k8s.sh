#!/bin/bash

kubectl delete pods --all -n biobanksprec
kubectl delete svc --all -n biobanksprec
kubectl delete deployment --all -n biobanksprec
kubectl delete configmap --all -n biobanksprec
kubectl delete secret --all -n biobanksprec
kubectl delete ingress --all -n biobanksprec