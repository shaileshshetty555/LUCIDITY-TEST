# Monitoring Helm Charts

## Purpose
Contains Helm charts for cluster and application observability on EKS.

## Components
- `kube-prometheus-stack`: Prometheus, Alertmanager, Grafana, and exporters.

## Deployment Commands
```bash
helm dependency build ./kube-prometheus-helm-charts/kube-prometheus-stack
helm upgrade --install kube-prometheus-stack ./kube-prometheus-helm-charts/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml
```

## Validation Commands
```bash
helm lint ./kube-prometheus-helm-charts/kube-prometheus-stack \
  -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml
```

## Status Check Commands
```bash
kubectl get pods -n monitoring
kubectl get prometheus,alertmanager -n monitoring
kubectl get svc -n monitoring | grep grafana
```
