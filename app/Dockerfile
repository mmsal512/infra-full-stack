# ============================================
#  Multi-stage build for minimal image size
#  Author: Mohammed Alefari
# ============================================

# ---- Stage 1: Builder ----
FROM python:3.12-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---- Stage 2: Production ----
FROM python:3.12-slim

LABEL maintainer="Mohammed Alefari <mmsal20902012@gmail.com>"
LABEL description="Infra Full Stack — DevOps Portfolio App"

# Security: non-root user
RUN groupadd -r appuser && \
    useradd -r -g appuser -d /app -s /sbin/nologin appuser

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Copy application
COPY app.py .

# Set ownership
RUN chown -R appuser:appuser /app

USER appuser

ENV PORT=5000 \
    APP_VERSION=1.0.0 \
    ENVIRONMENT=production

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--threads", "2", "--timeout", "120", "app:app"]
