#!/bin/bash

kubectl create ns monitoring

# Deploys Prometheus server, node-exporter, and kube-state-metrics
helm install --name prometheus --namespace monitoring stable/prometheus \
    --set server.enableAdminApi=true \
    --set server.persistentVolume.size=20Gi \
    --set server.global.scrape_interval=10s \
    --set server.global.scrape_timeout=5s 

kubectl -n monitoring port-forward service/prometheus-server 9090:80 &

echo ""
echo -n "Your Consul UI is at: http://localhost:9090"

open http://localhost:9090 

