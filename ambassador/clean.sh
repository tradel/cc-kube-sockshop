#!/bin/bash

kubectl delete -f ambassador-consul-connector.yaml 
kubectl delete -f ambassador-service.yaml
kubectl delete -f ambassador-rbac.yaml

