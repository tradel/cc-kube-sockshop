#!/bin/bash

helm delete --purge consul

kubectl delete daemonset consul
kubectl delete statefulset consul-server
kubectl delete deployment consul-connect-injector-webhook-deployment
kubectl delete deployment consul-sync-catalog
kubectl delete job consul-license
kubectl delete persistentvolumeclaim data-consul-server-0
kubectl delete persistentvolumeclaim data-consul-server-1
kubectl delete persistentvolumeclaim data-consul-server-2
