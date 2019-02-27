#!/bin/bash

# Deploy a simple HTTP echo service
kubectl create -f echo-server.yaml

# Deploy a client for the echo service
kubectl create -f echo-client.yaml
