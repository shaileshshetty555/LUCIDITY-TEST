# crds subchart

See: [https://github.com/prometheus-community/helm-charts/issues/3548](https://github.com/prometheus-community/helm-charts/issues/3548)

## Deployment Commands

```bash
helm upgrade --install kube-prometheus-stack ./kube-prometheus-helm-charts/kube-prometheus-stack \
	--namespace monitoring --create-namespace \
	-f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml
```

## Validation Commands

```bash
kubectl get crd | grep monitoring.coreos.com
```

## Status Check Commands

```bash
kubectl describe crd servicemonitors.monitoring.coreos.com
kubectl describe crd prometheuses.monitoring.coreos.com
```
