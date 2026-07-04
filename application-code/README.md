# Application Code

## Purpose
Contains application source code and container build assets.

## Components
- `services/hello-world-python`: Python microservice and Dockerfile.

## Deployment Commands
```bash
cd application-code/services/hello-world-python
docker build -t hello-world-python:1.0.0 .
```

## Validation Commands
```bash
cd application-code/services/hello-world-python
python3 -m py_compile src/app.py src/wsgi.py
pytest -q
```

## Status Check Commands
```bash
curl http://127.0.0.1:8080/
curl http://127.0.0.1:8080/healthz
curl http://127.0.0.1:8080/metrics | head
```
