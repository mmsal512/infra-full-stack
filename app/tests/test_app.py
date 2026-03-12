import pytest
import json
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from app import app as flask_app

@pytest.fixture
def client():
    flask_app.config['TESTING'] = True
    with flask_app.test_client() as client:
        yield client

def test_home_status(client):
    response = client.get('/')
    assert response.status_code == 200

def test_home_json_structure(client):
    response = client.get('/')
    data = response.get_json()
    assert data['app'] == 'infra-full-stack'
    assert data['status'] == 'running'
    assert 'hostname' in data
    assert 'version' in data
    assert 'timestamp' in data

def test_health(client):
    response = client.get('/health')
    assert response.status_code == 200
    data = response.get_json()
    assert data['status'] == 'healthy'

def test_ready(client):
    response = client.get('/ready')
    assert response.status_code == 200
    data = response.get_json()
    assert data['status'] == 'ready'

def test_info(client):
    response = client.get('/info')
    assert response.status_code == 200
    data = response.get_json()
    assert 'python_version' in data
    assert 'uptime_seconds' in data

def test_metrics(client):
    response = client.get('/metrics')
    assert response.status_code == 200
    assert b'app_requests_total' in response.data
    assert b'app_up 1' in response.data
    assert b'app_uptime_seconds' in response.data

def test_request_counter_increments(client):
    client.get('/')
    client.get('/')
    response = client.get('/')
    data = response.get_json()
    assert data['total_requests'] >= 3
