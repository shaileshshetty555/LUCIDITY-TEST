# Deployment Scripts

## Purpose
Automates image build, ECR push, and Helm deployment for the Hello World app.

## Script
- `deploy-hello-world.sh`

## Deployment Commands
Dev:
```bash
AWS_REGION=us-east-1 ENVIRONMENT=dev IMAGE_TAG=1.0.0 ./deploy/deploy-hello-world.sh
```

Staging:
```bash
AWS_REGION=us-east-1 ENVIRONMENT=staging IMAGE_TAG=1.0.0 ./deploy/deploy-hello-world.sh
```

Prod:
```bash
AWS_REGION=us-east-1 ENVIRONMENT=prod IMAGE_TAG=1.0.0 ./deploy/deploy-hello-world.sh
```

## Validation Commands
```bash
bash -n ./deploy/deploy-hello-world.sh
```

## Status Check Commands
```bash
kubectl get pods -n hello-world-dev
kubectl get svc -n hello-world-dev
kubectl rollout status deploy -n hello-world-dev -l app.kubernetes.io/instance=hello-world-dev
```
