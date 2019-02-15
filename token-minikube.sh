#!/bin/bash

token=$(kubectl -n kube-system get secrets -o json | jq -r '.items[] | select(.metadata.annotations."kubernetes.io/service-account.name"=="tiller") | .data.token')
echo $token | base64 -D | pbcopy

echo 'The auth token for the Kubernetes dashboard is now on the clipboard.'
