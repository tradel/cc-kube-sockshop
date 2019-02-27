#!/bin/bash

kubectl delete -f weaveworks-service.yaml
helm delete --purge sockshop
