#!/bin/bash

echo "Installing Consul from Helm chart repo..."
helm repo add consul https://consul-helm-charts.storage.googleapis.com
helm install --wait --name=consul consul/consul -f ./values.yaml

nohup kubectl port-forward service/consul-ui 8500:80 --pod-running-timeout=1m &

echo ""
echo -n "Your Consul UI is at: http://localhost:8500"

open http://localhost:8500 
