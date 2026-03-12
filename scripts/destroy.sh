#!/bin/bash
set -euo pipefail

KUBECTL="sudo k3s kubectl"

echo "⚠️  This will remove infra-full-stack from K3s"
echo "   Your Docker apps will NOT be affected"
read -p "Type 'destroy' to confirm: " CONFIRM

if [ "$CONFIRM" != "destroy" ]; then
    echo "Aborted."
    exit 0
fi

$KUBECTL delete namespace infra-full-stack --ignore-not-found
$KUBECTL delete clusterrole prometheus-infra --ignore-not-found
$KUBECTL delete clusterrolebinding prometheus-infra --ignore-not-found

# Remove UFW rules
sudo ufw delete allow in on tailscale0 to any port 30080 2>/dev/null || true
sudo ufw delete allow in on tailscale0 to any port 30090 2>/dev/null || true
sudo ufw delete allow in on tailscale0 to any port 30030 2>/dev/null || true

echo "✅ infra-full-stack completely removed."
echo "   Your Docker apps are untouched."
