#!/bin/bash

# NOTE: the docker-registry secret named "quayio-datawire" is no longer
# needed to install Ambassador with Connect integration.

# Needed for GKE
kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info --format="value(config.account)")

# Deploy the Ambassador proxy and its Consul connector
kubectl apply -f ambassador-rbac.yaml
kubectl apply -f ambassador-service.yaml
kubectl apply -f ambassador-consul-connector.yaml 

# Deploy the "Quote of the Moment" service for testing
kubectl apply -f qotm.yaml

echo ""
echo "Waiting for Ambassador pod to start..."
while [[ $( kubectl get pods -l service=ambassador -o jsonpath='{.items[0].status.phase}' ) != "Running" ]]
do
    sleep 5
done

echo "Waiting for Ambassador Connect pod to start..."
while [[ $( kubectl get pods -l app=ambassador,component=consul-connect -o jsonpath='{.items[0].status.phase}' ) != "Running" ]]
do
    sleep 5
done

echo "Waiting for Ambassador load balancer to become ready..."
ip=$( kubectl get service ambassador -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )
while [[ "$ip" == "" ]]
do 
    sleep 5 
    ip=$( kubectl get service ambassador -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )
done

echo ""
echo "Ambassador proxy is running at: https://${ip}"
