# Hello World Python Microservice

## Purpose
Python HTTP service for EKS that returns `Hello World` and exposes Prometheus metrics.

## Endpoints
- `GET /` returns `Hello World`
- `GET /healthz` returns JSON health status
- `GET /metrics` returns Prometheus metrics

## Deployment Commands
```bash
cd application-code/services/hello-world-python
docker build -t hello-world-python:1.0.0 .
```

Push to ECR:
```bash
AWS_ACCOUNT_ID="<account-id>"
AWS_REGION="us-east-1"
REPO_NAME="hello-world-python"

aws ecr create-repository --repository-name "$REPO_NAME" --region "$AWS_REGION" || true
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
docker tag hello-world-python:1.0.0 "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:1.0.0"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:1.0.0"
```

## Validation Commands
```bash
cd application-code/services/hello-world-python
python3 -m py_compile src/app.py src/wsgi.py
pytest -q
```

## Status Check Commands
```bash
docker run --rm -p 8080:8080 hello-world-python:1.0.0
curl http://127.0.0.1:8080/
curl http://127.0.0.1:8080/healthz
curl http://127.0.0.1:8080/metrics | head
```
