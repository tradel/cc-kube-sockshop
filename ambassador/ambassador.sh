#!/bin/bash

# NOTE: the docker-registry secret named "quayio-datawire" is no longer
# needed to install Ambassador with Connect integration.

# Needed for GKE
kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info --format="value(config.account)")

# Deploy the Ambassador proxy and its Consul connector
kubectl create -f ambassador-rbac-prometheus.yaml
kubectl create -f ambassador-service.yaml
kubectl create -f ambassador-consul-connector.yaml 

# Deploy the "Quote of the Moment" service for testing
kubectl create -f qotm.yaml

ip=$(kubectl get svc ambassador -o json | jq -r ".status.loadBalancer.ingress[0].ip")
port=$(kubectl get svc ambassador -o json | jq -r ".spec.ports[0].port")

echo ""
echo -n "Ambassador proxy is running at: ${ip}:${port}"
