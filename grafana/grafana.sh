#!/bin/bash

helm install --name grafana --namespace monitoring stable/grafana \
    --set sidecar.datasources.enabled=true \
    --set sidecar.dashboards.enabled=true \
    --set sidecar.dashboards.searchNamespace=ALL \
    --set sidecar.datasources.label=grafana_datasource \
    --set sidecar.dashboards.label=grafana_dashboard \
    --set sidecar.datasources.searchNamespace=ALL

kubectl -n monitoring apply -f datasources.yaml
kubectl -n monitoring apply -f consul-cluster-health-dashboard.yaml

kubectl -n monitoring port-forward service/grafana 3000:80 &

admin_password=$(kubectl -n monitoring get secret grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

echo ""
echo "Grafana is available at: http://localhost:3000"
echo "Your admin password is: ${admin_password}"

open http://localhost:3000
