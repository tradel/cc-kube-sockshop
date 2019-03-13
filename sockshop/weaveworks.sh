#!/bin/bash

echo "Installing Sock Shop from Helm chart repo..."
helm repo add consul https://consul-helm-charts.storage.googleapis.com
helm install --wait --name=sockshop consul/microservices-demo \
    --set loadtest.enabled=true \
    --set loadtest.replicas=2
kubectl apply -f weaveworks-service.yaml

echo ""
echo "Your sock shop URL is: http://localhost:30001"

nohup kubectl port-forward service/front-end 30001:80 &
open http://localhost:30001
