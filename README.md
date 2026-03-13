<div align="center">

# 🏗️ Infra Full Stack

### Production-Grade DevOps Infrastructure — From Code to Deployment

[![CI — Test, Build & Push](https://github.com/mmsal512/infra-full-stack/actions/workflows/ci.yaml/badge.svg)](https://github.com/mmsal512/infra-full-stack/actions/workflows/ci.yaml)
[![CD — Deploy to Kubernetes](https://github.com/mmsal512/infra-full-stack/actions/workflows/cd.yaml/badge.svg)](https://github.com/mmsal512/infra-full-stack/actions/workflows/cd.yaml)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=flat-square&logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=flat-square&logo=docker&logoColor=white)
![K3s](https://img.shields.io/badge/K3s-Kubernetes-FFC61C?style=flat-square&logo=k3s&logoColor=black)
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?style=flat-square&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?style=flat-square&logo=ansible&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

<br>

<img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=20&pause=1000&color=00D4FF&center=true&vCenter=true&random=false&width=550&lines=Terraform+%E2%86%92+Ansible+%E2%86%92+Docker+%E2%86%92+K3s+%E2%86%92+CI%2FCD;Prometheus+%2B+Grafana+Monitoring;Automated+Deployments+via+GitHub+Actions;Security+First+%7C+Infrastructure+as+Code" alt="Typing SVG" />

</div>

---

<div align="center">
<table>
<tr>
<td width="50%">

### 🇺🇸 English
A **complete production-grade DevOps portfolio** showcasing end-to-end infrastructure automation — from **Infrastructure as Code** (Terraform) → **Configuration Management** (Ansible) → **Containerization** (Docker) → **Orchestration** (K3s/Kubernetes) → **CI/CD** (GitHub Actions) → **Monitoring** (Prometheus + Grafana). Everything is automated, secure, and production-ready.

</td>
<td width="50%">

### 🇾🇪 عربي
**مشروع بنية تحتية متكامل وجاهز للإنتاج** يعرض أتمتة البنية التحتية من البداية للنهاية — بدءاً من **البنية التحتية كرمز** (Terraform) ← **إدارة التكوين** (Ansible) ← **الحاويات** (Docker) ← **التنسيق** (K3s/Kubernetes) ← **التكامل والنشر المستمر** (GitHub Actions) ← **المراقبة** (Prometheus + Grafana). كل شيء مؤتمت وآمن وجاهز للإنتاج.

</td>
</tr>
</table>
</div>

---

## 📐 Architecture / الهيكلية

```
┌──────────────────────────────────────────────────────────────────────┐
│                        GitHub Repository                             │
│  ┌─────────┐    ┌──────────┐    ┌───────────┐    ┌───────────────┐  │
│  │ app/    │    │terraform/│    │  ansible/  │    │  kubernetes/  │  │
│  │ Flask   │    │ Hetzner  │    │ Playbooks  │    │  Manifests    │  │
│  │ Docker  │    │   IaC    │    │  Inventory │    │  App + Mon.   │  │
│  └────┬────┘    └──────────┘    └────────────┘    └───────┬───────┘  │
│       │                                                    │         │
│  ─────┴────────── CI/CD (GitHub Actions) ─────────────────┴─────    │
│       │                                                    │         │
│  ┌────▼────┐    ┌──────────┐    ┌────────────┐    ┌───────▼───────┐ │
│  │  Test   │───▶│  Build   │───▶│   Push to   │───▶│  Deploy to   │ │
│  │ pytest  │    │ Docker   │    │  DockerHub  │    │  K3s (SSH)   │ │
│  └─────────┘    └──────────┘    └────────────┘    └───────┬───────┘ │
└───────────────────────────────────────────────────────────┼─────────┘
                                                            │
┌───────────────────────────────────────────────────────────▼──────────┐
│                    K3s Server (Production)                            │
│                                                                      │
│  ┌─── Namespace: infra-full-stack ────────────────────────────────┐  │
│  │                                                                │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐ │  │
│  │  │  Flask App   │  │  Flask App   │  │   HPA (2-4 Pods)     │ │  │
│  │  │  Pod #1      │  │  Pod #2      │  │   Auto-Scaling       │ │  │
│  │  │  :5000       │  │  :5000       │  └──────────────────────┘ │  │
│  │  └──────┬───────┘  └──────┬───────┘                           │  │
│  │         └────────┬────────┘                                   │  │
│  │           ┌──────▼───────┐                                    │  │
│  │           │   Service    │                                    │  │
│  │           │  NodePort    │                                    │  │
│  │           │  :30080      │                                    │  │
│  │           └──────────────┘                                    │  │
│  │                                                                │  │
│  │  ┌─── Monitoring ──────────────────────────────────────────┐  │  │
│  │  │  ┌──────────────┐         ┌──────────────┐             │  │  │
│  │  │  │  Prometheus  │────────▶│   Grafana    │             │  │  │
│  │  │  │  :30090      │ scrape  │   :30030     │             │  │  │
│  │  │  │  Metrics     │         │  Dashboards  │             │  │  │
│  │  │  └──────────────┘         └──────────────┘             │  │  │
│  │  └────────────────────────────────────────────────────────┘  │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                      │
│  Telegram Bot ◄─── Deployment Notifications                          │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure / هيكل المشروع

```
infra-full-stack/
│
├── 📂 app/                          # Application Layer / طبقة التطبيق
│   ├── app.py                       # Flask REST API (5 endpoints)
│   ├── Dockerfile                   # Multi-stage build (Python 3.12-slim)
│   ├── requirements.txt             # Dependencies (Flask, Gunicorn, Pytest)
│   └── tests/
│       └── test_app.py              # Unit tests (7 test cases)
│
├── 📂 terraform/                    # Infrastructure as Code / البنية التحتية كرمز
│   ├── provider.tf                  # Hetzner Cloud provider
│   ├── main.tf                      # Server, Firewall, SSH Key
│   ├── variables.tf                 # Input variables (sensitive marked)
│   ├── outputs.tf                   # Server IP, SSH command, Ansible entry
│   └── terraform.tfvars.example     # Example values (copy & fill)
│
├── 📂 ansible/                      # Configuration Management / إدارة التكوين
│   ├── playbook.yml                 # Deploy to K3s (15 tasks)
│   └── inventory/
│       └── hosts.ini                # Server inventory (template)
│
├── 📂 kubernetes/                   # Orchestration / التنسيق
│   ├── namespace.yaml               # Isolated namespace
│   ├── app/
│   │   ├── deployment.yaml          # 2 replicas, rolling update, probes
│   │   ├── service.yaml             # NodePort :30080
│   │   ├── configmap.yaml           # App configuration
│   │   └── hpa.yaml                 # Auto-scaling (2→4 pods, CPU/Memory)
│   └── monitoring/
│       ├── prometheus/
│       │   ├── deployment.yaml      # Prometheus v2.51 + Service :30090
│       │   ├── configmap.yaml       # Scrape configs + Alert rules
│       │   └── clusterrole.yaml     # RBAC for pod discovery
│       └── grafana/
│           ├── deployment.yaml      # Grafana 10.4 + Service :30030
│           └── configmap.yaml       # Auto-provisioned datasource + dashboard
│
├── 📂 scripts/                      # Automation Scripts / سكربتات الأتمتة
│   ├── setup-on-existing-server.sh  # One-command deployment
│   ├── health-check.sh              # Service health verification
│   └── destroy.sh                   # Clean uninstall
│
├── 📂 .github/workflows/           # CI/CD Pipelines
│   ├── ci.yaml                      # Test → Build → Push to DockerHub
│   └── cd.yaml                      # Deploy to K3s → Health Check → Telegram
│
└── .gitignore                       # Security-aware ignores
```

---

## 🚀 Features / المميزات

<div align="center">
<table>
<tr>
<td align="center" width="25%">

### 🐳 Containerization
Multi-stage Docker build<br>
Non-root user<br>
Health checks<br>
Gunicorn WSGI

</td>
<td align="center" width="25%">

### ☸️ Orchestration
K3s (Kubernetes)<br>
Rolling updates<br>
HPA auto-scaling<br>
Liveness & Readiness probes

</td>
<td align="center" width="25%">

### 🔄 CI/CD
GitHub Actions<br>
Automated testing<br>
Docker build & push<br>
SSH deployment

</td>
<td align="center" width="25%">

### 📊 Monitoring
Prometheus metrics<br>
Grafana dashboards<br>
Alert rules<br>
Telegram notifications

</td>
</tr>
</table>
</div>

---

## ⚡ Quick Start / البدء السريع

### Prerequisites / المتطلبات

| Tool | Version | Purpose |
|:-----|:--------|:--------|
| Docker | 24+ | Container runtime |
| K3s | v1.28+ | Kubernetes distribution |
| Terraform | 1.5+ | Infrastructure provisioning |
| Ansible | 2.15+ | Configuration management |
| Python | 3.12 | Application runtime |

### 1️⃣ Clone & Run Locally / تشغيل محلي

```bash
# Clone the repository / استنساخ المشروع
git clone https://github.com/mmsal512/infra-full-stack.git
cd infra-full-stack

# Run the Flask app locally / تشغيل التطبيق محلياً
cd app
pip install -r requirements.txt
python app.py
# → http://localhost:5000
```

### 2️⃣ Run with Docker / تشغيل عبر Docker

```bash
# Build & run / بناء وتشغيل
docker build -t infra-full-stack ./app
docker run -p 5000:5000 infra-full-stack
# → http://localhost:5000
```

### 3️⃣ Deploy to K3s / النشر على K3s

```bash
# Option A: One-command setup / إعداد بأمر واحد
bash scripts/setup-on-existing-server.sh

# Option B: Manual deployment / نشر يدوي
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/app/
kubectl apply -f kubernetes/monitoring/prometheus/
kubectl apply -f kubernetes/monitoring/grafana/
```

### 4️⃣ Provision with Terraform (Optional) / إنشاء سيرفر بـ Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values / عدّل القيم حسب إعداداتك
terraform init
terraform plan
terraform apply
```

---

## 🌐 API Endpoints / نقاط الوصول

| Endpoint | Method | Description | الوصف |
|:---------|:------:|:------------|:------|
| `/` | GET | App info, version, uptime, request count | معلومات التطبيق |
| `/health` | GET | Health check (for K8s liveness probe) | فحص الصحة |
| `/ready` | GET | Readiness check (for K8s readiness probe) | فحص الجاهزية |
| `/info` | GET | Detailed system information | معلومات النظام |
| `/metrics` | GET | Prometheus-compatible metrics | مقاييس Prometheus |

**Example Response** / مثال على الاستجابة:
```json
{
  "app": "infra-full-stack",
  "author": "Mohammed Alefari",
  "version": "1.1.0",
  "hostname": "flask-app-7d4b8c6f9-x2k4m",
  "timestamp": "2026-03-13T12:00:00.000000",
  "status": "running",
  "uptime_seconds": 86400,
  "total_requests": 1542,
  "message": "DevOps Portfolio — Terraform + K8s + CI/CD + Monitoring",
  "last_updated": "2026-03-13"
}
```

---

## 🔄 CI/CD Pipeline / خط أنابيب CI/CD

### CI — Test, Build & Push

```
Push to main (app/**)
    │
    ├── 🧪 Run Tests (pytest — 7 test cases)
    │
    ├── 🐳 Build Docker Image (multi-stage)
    │
    └── 📦 Push to DockerHub
         ├── mohammed512/infra-full-stack:latest
         ├── mohammed512/infra-full-stack:<short-sha>
         └── mohammed512/infra-full-stack:build-<run-number>
```

### CD — Deploy to Kubernetes

```
CI Success (workflow_run)
    │
    ├── 🔑 SSH to Server (via Tailscale)
    │
    ├── 🔐 Create/Update K8s Secrets
    │
    ├── 📋 Apply K8s Manifests
    │
    ├── 🔄 Rolling Restart (zero-downtime)
    │
    ├── ✅ Health Check (6 attempts × 10s)
    │
    └── 📱 Telegram Notification (Success/Failure)
```

### Required GitHub Secrets / الأسرار المطلوبة

| Secret | Description | الوصف |
|:-------|:------------|:------|
| `DOCKER_USERNAME` | DockerHub username | اسم مستخدم DockerHub |
| `DOCKER_TOKEN` | DockerHub access token | رمز وصول DockerHub |
| `SERVER_TAILSCALE_IP` | Server Tailscale IP | عنوان IP الخاص بـ Tailscale |
| `SSH_PRIVATE_KEY` | SSH private key | المفتاح الخاص SSH |
| `GRAFANA_ADMIN_PASSWORD` | Grafana admin password | كلمة مرور Grafana |
| `TELEGRAM_TOKEN` | Telegram Bot token | رمز بوت Telegram |
| `TELEGRAM_CHAT_ID` | Telegram Chat ID | معرف محادثة Telegram |

---

## 📊 Monitoring Stack / حزمة المراقبة

### Prometheus
- **Auto-discovery** of pods via Kubernetes SD
- **Custom metrics** from Flask app (`app_requests_total`, `app_up`, `app_uptime_seconds`)
- **Alert rules**: AppDown, HighRequestCount, PodRestart
- **Retention**: 3 days with 2Gi storage limit

### Grafana
- **Pre-configured datasource** (Prometheus — auto-provisioned)
- **Custom dashboard** with 6 panels:
  - App Status (UP/DOWN)
  - Total Requests
  - Running Pods count
  - App Uptime
  - App Up/Down Over Time (timeseries)
  - Requests Rate Over Time (timeseries)
- **Auto-refresh** every 10 seconds
- **Secure access** via Kubernetes Secrets

### Access Points / نقاط الوصول

| Service | Port | Access |
|:--------|:----:|:-------|
| Flask App | `30080` | `http://<server-ip>:30080` |
| Prometheus | `30090` | `http://<server-ip>:30090` |
| Grafana | `30030` | `http://<server-ip>:30030` |

---

## 🔒 Security / الأمان

- ✅ **Non-root Docker container** — Application runs as `appuser`
- ✅ **Multi-stage build** — Minimal attack surface
- ✅ **Kubernetes Secrets** — Sensitive data stored securely
- ✅ **GitHub Actions Secrets** — No credentials in code
- ✅ **Tailscale VPN** — Private network access
- ✅ **Custom SSH port** — Hardened access
- ✅ **RBAC** — Least-privilege Prometheus access
- ✅ **Resource limits** — CPU/Memory quotas on all pods
- ✅ **`.gitignore`** — Protects `terraform.tfvars`, `.env`, `*.tfstate`
- ✅ **No secrets in repository** — All sensitive data via environment/secrets

---

## 🧪 Testing / الاختبارات

```bash
cd app
python -m pytest tests/ -v --tb=short
```

**Test Coverage** / تغطية الاختبارات:
| Test | What it validates | ماذا يختبر |
|:-----|:-----------------|:-----------|
| `test_home_status` | HTTP 200 on `/` | حالة الاستجابة |
| `test_home_json_structure` | JSON fields validation | بنية JSON |
| `test_health` | Health endpoint works | نقطة الصحة |
| `test_ready` | Readiness endpoint works | نقطة الجاهزية |
| `test_info` | Info endpoint fields | نقطة المعلومات |
| `test_metrics` | Prometheus metrics format | تنسيق المقاييس |
| `test_request_counter` | Counter increments correctly | عداد الطلبات |

---

## 🛠️ Tech Stack / التقنيات المستخدمة

<div align="center">

![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-3.1-000000?style=for-the-badge&logo=flask&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/K3s-Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-1.5+-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![Gunicorn](https://img.shields.io/badge/Gunicorn-WSGI-499848?style=for-the-badge&logo=gunicorn&logoColor=white)

</div>

---

## 👤 Author / المؤلف

<div align="center">

**Mohammed Alefari** — DevOps Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mohammed-alefari-283211306/)
[![GitHub](https://img.shields.io/badge/GitHub-mmsal512-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/mmsal512)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:mmsal20902012@gmail.com)

</div>

---

<div align="center">

**⭐ If you found this project useful, please give it a star!**

**⭐ إذا أعجبك المشروع، لا تنسى تعطيه نجمة!**

</div>
