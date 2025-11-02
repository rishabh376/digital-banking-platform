1. Detect outage: monitoring alerts indicate primary cluster unreachable.
2. Validate: check last successful transactions & DB replication lag.
3. Execute failover:
   - For Azure: call az network traffic-manager endpoint update --resource-group ... --name ... --set-target=secondary
   - For lab: run `python3 dr/failover-scripts/failover.py --to dr`
4. Verify:
   - Synthetic transaction tests succeed against DR.
   - No data loss beyond RPO.
5. Post-failover actions:
   - Reconfigure monitoring to point to DR cluster.
   - Begin recovery of primary cluster; once healthy, fail back as per policy.


