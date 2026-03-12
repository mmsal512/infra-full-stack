from flask import Flask, jsonify, request
import os
import socket
import datetime
import time

app = Flask(__name__)

# Simple in-memory counter
request_count = 0
start_time = time.time()

@app.route('/')
def home():
    global request_count
    request_count += 1
    return jsonify({
        "app": "infra-full-stack",
        "author": "Mohammed Alefari",
        "version": os.getenv("APP_VERSION", "1.0.0"),
        "hostname": socket.gethostname(),
        "timestamp": datetime.datetime.now().isoformat(),
        "status": "running",
        "uptime_seconds": int(time.time() - start_time),
        "total_requests": request_count,
        "message": "DevOps Portfolio — Terraform + K8s + CI/CD + Monitoring"
    })

@app.route('/health')
def health():
    return jsonify({"status": "healthy", "timestamp": datetime.datetime.now().isoformat()}), 200

@app.route('/ready')
def ready():
    return jsonify({"status": "ready"}), 200

@app.route('/info')
def info():
    return jsonify({
        "app": "infra-full-stack",
        "version": os.getenv("APP_VERSION", "1.0.0"),
        "environment": os.getenv("ENVIRONMENT", "production"),
        "python_version": os.sys.version,
        "hostname": socket.gethostname(),
        "uptime_seconds": int(time.time() - start_time),
        "total_requests": request_count
    })

@app.route('/metrics')
def metrics():
    uptime = int(time.time() - start_time)
    return (
        "# HELP app_requests_total Total number of requests\n"
        "# TYPE app_requests_total counter\n"
        f"app_requests_total {request_count}\n"
        "# HELP app_up Application up status\n"
        "# TYPE app_up gauge\n"
        "app_up 1\n"
        "# HELP app_uptime_seconds Application uptime in seconds\n"
        "# TYPE app_uptime_seconds gauge\n"
        f"app_uptime_seconds {uptime}\n"
        "# HELP app_info Application information\n"
        "# TYPE app_info gauge\n"
        f'app_info{{version="{os.getenv("APP_VERSION", "1.0.0")}",hostname="{socket.gethostname()}"}} 1\n'
    ), 200, {'Content-Type': 'text/plain; charset=utf-8'}

if __name__ == '__main__':
    port = int(os.getenv("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
