#!/bin/bash

# Create an account for Tiller and grant it permissions.
# NOTE: I took the lazy way and granted it "cluster-admin" role. 
# You should probably not do this in a real cluster.
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

# Let Helm deploy and configure the Tiller service.
helm init --service-account tiller
