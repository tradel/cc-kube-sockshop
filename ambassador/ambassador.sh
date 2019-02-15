#!/bin/bash

# NOTE: a docker-registry secret named "quayio-datawire" must already exist
# in the cluster to successfully deploy the consul connector

# Needed for GKE
kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info --format="value(config.account)")

# Deploy the Ambassador proxy and its Consul connector
kubectl apply -f ambassador-rbac-prometheus.yaml
kubectl apply -f ambassador-service.yaml
kubectl apply -f ambassador-consul-connector.yaml 

# Deploy the "Quote of the Moment" service for testing
kubectl apply -f qotm.yaml

ip=$(kubectl get svc ambassador -o json | jq -r ".status.loadBalancer.ingress[0].ip")
port=$(kubectl get svc ambassador -o json | jq -r ".spec.ports[0].port")

echo ""
echo -n "Ambassador proxy is running at: ${ip}:${port}"
