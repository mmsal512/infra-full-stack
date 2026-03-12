#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

TAILSCALE_IP="100.126.131.64"

echo "══════════════════════════════════"
echo "  infra-full-stack Health Check"
echo "══════════════════════════════════"

check() {
    local name=$1 url=$2
    if curl -sf --max-time 5 "$url" > /dev/null 2>&1; then
        echo -e "  ${GREEN}✔${NC} $name — OK"
    else
        echo -e "  ${RED}✘${NC} $name — FAILED"
    fi
}

check "Flask App" "http://${TAILSCALE_IP}:30080/health"
check "App Metrics" "http://${TAILSCALE_IP}:30080/metrics"
check "Prometheus" "http://${TAILSCALE_IP}:30090/-/ready"
check "Grafana" "http://${TAILSCALE_IP}:30030/api/health"

echo ""
echo "Pods Status:"
sudo k3s kubectl get pods -n infra-full-stack 2>/dev/null || echo "  Cannot access K3s"
echo ""
