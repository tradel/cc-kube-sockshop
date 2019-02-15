#!/bin/bash

helm repo add consul https://consul-helm-charts.storage.googleapis.com
helm install --name=consul consul/consul -f ./values.yaml

kubectl port-forward service/consul-ui 8500:80 &

echo ""
echo -n "Your Consul UI is at: http://localhost:8500"

open http://localhost:8500 
