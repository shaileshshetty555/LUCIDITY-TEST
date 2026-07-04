# Services

## Purpose
Contains deployable microservices for EKS.

## Components
- `hello-world-python`

## Deployment Commands
```bash
cd application-code/services/hello-world-python
docker build -t hello-world-python:1.0.0 .
```

## Validation Commands
```bash
cd application-code/services/hello-world-python
pytest -q
```

## Status Check Commands
```bash
docker run --rm -p 8080:8080 hello-world-python:1.0.0
curl http://127.0.0.1:8080/
```
