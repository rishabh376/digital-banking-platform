#!/usr/bin/env python3
"""
Simple DR failover script for lab:
  - Accepts --to primary|dr to switch target context for deployments
  - In prod this would call Azure Traffic Manager API to change endpoint priority.
"""
import argparse, subprocess, sys

def run(cmd):
    print(">", cmd)
    res = subprocess.run(cmd, shell=True)
    if res.returncode != 0:
        print("Command failed:", cmd)
        sys.exit(res.returncode)

parser = argparse.ArgumentParser()
parser.add_argument("--to", required=True, choices=["primary","dr"])
args = parser.parse_args()
if args.to == "dr":
    # in real infra: update Traffic Manager; here switch kube context to DR and deploy
    run("kubectl config use-context kind-dbank-dr")
    run("helm upgrade --install accounts-api charts/base-chart -n dbank --create-namespace --set image.tag=0.1")
    print("Failover to DR complete.")
else:
    run("kubectl config use-context kind-dbank-primary")
    run("helm upgrade --install accounts-api charts/base-chart -n dbank --create-namespace --set image.tag=0.1")
    print("Switched back to Primary.")
