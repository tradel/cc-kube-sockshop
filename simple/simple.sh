#!/bin/bash

# Deploy a simple HTTP echo service
kubectl apply -f echo-server.yaml

# Deploy a client for the echo service
kubectl apply -f echo-client.yaml
