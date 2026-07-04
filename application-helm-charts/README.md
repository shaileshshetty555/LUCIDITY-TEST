# Application Helm Charts

## Purpose
Contains Helm charts for application workloads deployed to EKS.

## Components
- `hello-world`: Helm chart for Python Hello World service.

## Deployment Commands
```bash
helm upgrade --install hello-world-dev ./application-helm-charts/hello-world \
  --namespace hello-world-dev --create-namespace \
  -f ./application-helm-charts/hello-world/values.yaml \
  -f ./application-helm-charts/hello-world/values-dev.yaml
```

## Validation Commands
```bash
helm lint ./application-helm-charts/hello-world
helm template hello-world-dev ./application-helm-charts/hello-world \
  -f ./application-helm-charts/hello-world/values.yaml \
  -f ./application-helm-charts/hello-world/values-dev.yaml >/tmp/hello-world-dev.yaml
```

## Status Check Commands
```bash
kubectl get deploy,svc -n hello-world-dev
kubectl get pods -n hello-world-dev
kubectl get servicemonitor -n hello-world-dev
```
