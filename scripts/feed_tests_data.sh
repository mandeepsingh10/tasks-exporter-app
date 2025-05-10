#!/bin/bash

# Send sample tasks
echo "Sending sample tasks..."
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "upgrader", "task": "healthcheck", "status": "completed", "duration": 120}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "upgrader", "task": "healthcheck", "status": "failed", "duration": 60}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "deployer", "task": "deploy", "status": "succeeded", "duration": 300}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "upgrader", "task": "kernel-upgrade", "status": "completed", "duration": 180}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "deployer", "task": "app-deployment", "status": "failed", "duration": 45}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "healthchecker", "task": "system-check", "status": "succeeded", "duration": 30}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "backup-manager", "task": "db-backup", "status": "completed", "duration": 240}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "security-scanner", "task": "vuln-scan", "status": "failed", "duration": 120}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "upgrader", "task": "package-update", "status": "succeeded", "duration": 90}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "deployer", "task": "config-push", "status": "completed", "duration": 60}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "monitoring", "task": "metrics-collect", "status": "succeeded", "duration": 15}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "backup-manager", "task": "fs-backup", "status": "failed", "duration": 300}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "security-scanner", "task": "compliance-check", "status": "completed", "duration": 150}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "upgrader", "task": "security-patch", "status": "succeeded", "duration": 75}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "deployer", "task": "rollback", "status": "failed", "duration": 25}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "healthchecker", "task": "network-check", "status": "completed", "duration": 40}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "backup-manager", "task": "cloud-sync", "status": "succeeded", "duration": 210}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "security-scanner", "task": "log-analysis", "status": "failed", "duration": 85}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "upgrader", "task": "dependency-update", "status": "completed", "duration": 200}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "deployer", "task": "microservice-deploy", "status": "succeeded", "duration": 95}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "monitoring", "task": "alert-config", "status": "failed", "duration": 50}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "healthchecker", "task": "disk-check", "status": "succeeded", "duration": 20}'
curl -X POST http://localhost:5003/api/tasks -H "Content-Type: application/json" -d '{"tool": "backup-manager", "task": "snapshot-create", "status": "completed", "duration": 270}'

# Fetch metrics
echo -e "\nMetrics:"
curl http://localhost:5003/metrics