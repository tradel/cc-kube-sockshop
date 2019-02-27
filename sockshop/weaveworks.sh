#!/bin/bash

helm install --name=sockshop $HOME/Code/microservices-demo/deploy/kubernetes/helm-chart \
    --set loadtest.enabled=true \
    --set loadtest.replicas=2

kubectl create -f weaveworks-service.yaml
kubectl port-forward service/front-end 30001:80 &

echo ""
echo -n "Your sock shop URL is: http://localhost:30001"

open http://localhost:30001
