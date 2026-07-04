# kube-prometheus-stack on EKS

## Purpose
EKS-specific monitoring profiles for development, staging, and production.

## Values Files
- `values-dev.yaml`
- `values-staging.yaml`
- `values-prod.yaml`

## Deployment Commands
Development:
```bash
helm dependency build ./kube-prometheus-helm-charts/kube-prometheus-stack
helm upgrade --install kube-prometheus-stack ./kube-prometheus-helm-charts/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml
```

Staging:
```bash
helm upgrade --install kube-prometheus-stack ./kube-prometheus-helm-charts/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-staging.yaml
```

Production:
```bash
helm upgrade --install kube-prometheus-stack ./kube-prometheus-helm-charts/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-prod.yaml
```

## Validation Commands
```bash
helm lint ./kube-prometheus-helm-charts/kube-prometheus-stack \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml
helm lint ./kube-prometheus-helm-charts/kube-prometheus-stack \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-staging.yaml
helm lint ./kube-prometheus-helm-charts/kube-prometheus-stack \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-prod.yaml
```

## Status Check Commands
```bash
kubectl get pods -n monitoring
kubectl get servicemonitor -A
kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 9090:9090
kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3000:80
```
