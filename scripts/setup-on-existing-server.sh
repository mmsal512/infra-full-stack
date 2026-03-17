#!/bin/bash
set -euo pipefail

# ============================================================
#  Setup infra-full-stack on EXISTING server
#  Run this ON your server
#  This deploys into K3s namespace without touching Docker apps
# ============================================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()  { echo -e "${GREEN}[✔]${NC} $1"; }
info() { echo -e "${BLUE}[ℹ]${NC} $1"; }
warn() { echo -e "${YELLOW}[⚠]${NC} $1"; }

PROJECT_DIR="$HOME/infra-full-stack"
KUBECTL="sudo k3s kubectl"

echo ""
echo "══════════════════════════════════════════════"
echo "  infra-full-stack — Setup on Existing Server"
echo "  Target: K3s namespace (isolated from Docker)"
echo "══════════════════════════════════════════════"
echo ""

# ---- Step 1: Verify K3s ----
info "Step 1: Verifying K3s is running..."
$KUBECTL get nodes || { echo "❌ K3s is not running!"; exit 1; }
log "K3s is running!"

# ---- Step 2: Check Resources ----
info "Step 2: Checking available resources..."
RAM_AVAIL=$(free -m | awk '/^Mem:/ {print $7}')
DISK_AVAIL=$(df / | awk 'NR==2 {print int($4/1024)}')

log "Available RAM: ${RAM_AVAIL}MB"
log "Available Disk: ${DISK_AVAIL}MB"

if [ "$RAM_AVAIL" -lt 800 ]; then
    warn "Low RAM! The project needs ~500MB. Proceed with caution."
    read -p "Continue? (y/n): " CONFIRM
    [ "$CONFIRM" != "y" ] && exit 0
fi

# ---- Step 3: Clone/Update Repo ----
info "Step 3: Setting up project directory..."
if [ -d "$PROJECT_DIR/.git" ]; then
    cd "$PROJECT_DIR"
    git pull origin main
    log "Repository updated!"
else
    git clone https://github.com/mmsal512/infra-full-stack.git "$PROJECT_DIR"
    cd "$PROJECT_DIR"
    log "Repository cloned!"
fi

# ---- Step 4: Deploy to K3s ----
info "Step 4: Deploying to K3s..."

$KUBECTL apply -f kubernetes/namespace.yaml
log "Namespace created"

$KUBECTL apply -f kubernetes/monitoring/prometheus/clusterrole.yaml
$KUBECTL apply -f kubernetes/monitoring/prometheus/configmap.yaml
$KUBECTL apply -f kubernetes/monitoring/prometheus/deployment.yaml
log "Prometheus deployed"

$KUBECTL apply -f kubernetes/monitoring/grafana/configmap.yaml
$KUBECTL apply -f kubernetes/monitoring/grafana/deployment.yaml
log "Grafana deployed"

$KUBECTL apply -f kubernetes/app/configmap.yaml
$KUBECTL apply -f kubernetes/app/deployment.yaml
$KUBECTL apply -f kubernetes/app/service.yaml
$KUBECTL apply -f kubernetes/app/hpa.yaml
log "Flask app deployed"

# ---- Step 5: Wait for Pods ----
info "Step 5: Waiting for pods to be ready..."
$KUBECTL wait --for=condition=ready pod -l app=flask-app -n infra-full-stack --timeout=120s
$KUBECTL wait --for=condition=ready pod -l app=prometheus -n infra-full-stack --timeout=120s
$KUBECTL wait --for=condition=ready pod -l app=grafana -n infra-full-stack --timeout=120s

# ---- Step 6: Add UFW rule for NodePorts (Tailscale only) ----
info "Step 6: Configuring firewall for Tailscale access..."
sudo ufw allow in on tailscale0 to any port 30080 comment "infra-full-stack app" 2>/dev/null || true
sudo ufw allow in on tailscale0 to any port 30090 comment "infra-full-stack prometheus" 2>/dev/null || true
sudo ufw allow in on tailscale0 to any port 30030 comment "infra-full-stack grafana" 2>/dev/null || true
log "Firewall rules added (Tailscale only)"

# ---- Done! ----
echo ""
echo "══════════════════════════════════════════════"
echo -e "  ${GREEN}✅ DEPLOYMENT COMPLETE!${NC}"
echo "══════════════════════════════════════════════"
echo ""
$KUBECTL get pods -n infra-full-stack
echo ""
$KUBECTL get svc -n infra-full-stack
echo ""
echo "  🌐 Access via Tailscale (YOUR_TAILSCALE_IP):"
echo "     App:        http://YOUR_TAILSCALE_IP:30080"
echo "     Prometheus: http://YOUR_TAILSCALE_IP:30090"
echo "     Grafana:    http://YOUR_TAILSCALE_IP:30030"
echo "                 (admin / YOUR_PASSWORD)"
echo ""
echo "══════════════════════════════════════════════"
