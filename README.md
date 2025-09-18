# Digital Banking Platform — DevOps Lab

## Overview
Production-oriented digital banking platform with microservices, Kubernetes, CI/CD, monitoring, security, and DR.

## Quickstart (local)
1. Prereqs: docker, kind, kubectl, helm, python3
2. Create clusters:
   - kind create cluster --name dbank-primary
   - kind create cluster --name dbank-dr
3. Build images and load into clusters:
   - docker build -t accounts-api:0.1 ./services/accounts-api
   - kind load docker-image accounts-api:0.1 --name dbank-primary
   - kind load docker-image accounts-api:0.1 --name dbank-dr
4. Deploy monitoring and services (see bootstrap script)

## How to run full demo
- Run `scripts/bootstrap-local.sh` (or execute steps manually)
- Visit Grafana: http://localhost:3000 (port-forward)
- Run DR failover: `python3 dr/failover-scripts/failover.py --to dr`

## Artifacts
- Terraform modules for AKS/ACR/SQL/KeyVault
- Helm charts for services
- GitHub Actions CI pipeline with Trivy scanning
- Prometheus rules + Grafana dashboards
- OPA Gatekeeper policies
- DR runbook and failover script

## Security notes
- DO NOT commit secrets. Use SealedSecrets or HashiCorp Vault for lab secrets; use Azure Key Vault for prod.
