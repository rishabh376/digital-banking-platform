#!/bin/bash
set -euo pipefail
# 1. create clusters
kind create cluster --name dbank-primary || true
kind create cluster --name dbank-dr || true

# 2. build images
docker build -t accounts-api:0.1 ./services/accounts-api

# 3. load into clusters
kind load docker-image accounts-api:0.1 --name dbank-primary
kind load docker-image accounts-api:0.1 --name dbank-dr

# 4. install monitoring
kubectl --context kind-dbank-primary create ns monitoring || true
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --create-namespace || true

# 5. install DB in dbank namespace
kubectl --context kind-dbank-primary create ns dbank || true
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install postgres bitnami/postgresql -n dbank --create-namespace || true

# 6. deploy accounts-api
helm upgrade --install accounts-api charts/base-chart -n dbank --create-namespace --set image.repository=accounts-api --set image.tag=0.1

echo "Bootstrap done. Port-forward Grafana: kubectl --context kind-dbank-primary -n monitoring port-forward svc/prometheus-grafana 3000:80"
