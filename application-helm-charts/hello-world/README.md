# Hello World Helm Chart

## Purpose
Deploys the Hello World Python microservice to EKS with secure defaults and Prometheus integration.

## Environment Values
- `values-dev.yaml`
- `values-staging.yaml`
- `values-prod.yaml`

## Deployment Commands
Development:
```bash
helm upgrade --install hello-world-dev ./application-helm-charts/hello-world \
  --namespace hello-world-dev --create-namespace \
  -f ./application-helm-charts/hello-world/values.yaml \
  -f ./application-helm-charts/hello-world/values-dev.yaml \
  --set image.repository=<ecr-repo> \
  --set image.tag=1.0.0
```

Staging:
```bash
helm upgrade --install hello-world-staging ./application-helm-charts/hello-world \
  --namespace hello-world-staging --create-namespace \
  -f ./application-helm-charts/hello-world/values.yaml \
  -f ./application-helm-charts/hello-world/values-staging.yaml \
  --set image.repository=<ecr-repo> \
  --set image.tag=1.0.0
```

Production:
```bash
helm upgrade --install hello-world-prod ./application-helm-charts/hello-world \
  --namespace hello-world-prod --create-namespace \
  -f ./application-helm-charts/hello-world/values.yaml \
  -f ./application-helm-charts/hello-world/values-prod.yaml \
  --set image.repository=<ecr-repo> \
  --set image.tag=1.0.0
```

## Validation Commands
```bash
helm lint ./application-helm-charts/hello-world
helm template hello-world-prod ./application-helm-charts/hello-world \
  -f ./application-helm-charts/hello-world/values.yaml \
  -f ./application-helm-charts/hello-world/values-prod.yaml >/tmp/hello-world-prod.yaml
```

## Status Check Commands
```bash
kubectl get pods -n hello-world-prod
kubectl rollout status deploy -n hello-world-prod -l app.kubernetes.io/instance=hello-world-prod
kubectl get servicemonitor -n hello-world-prod
kubectl port-forward -n hello-world-prod svc/hello-world-prod-hello-world 8080:80
curl http://127.0.0.1:8080/
```
