# Testing on Minikube

The configuration in this folder lets you locally test the setup on minikube. Use cmd.sh to set up components and hack a working etcd scrape configuration. Run the commands in the sequence listed in the script to get a local working minikube cluster.

If you're using windows, there's a commented-out section that you should add to the minikube command.

## Deployment Commands

```bash
cd kube-prometheus-helm-charts/kube-prometheus-stack
bash ./hack/minikube/cmd.sh
```

## Validation Commands

```bash
kubectl get pods -n monitoring
helm lint ./
```

## Status Check Commands

```bash
kubectl get svc -n monitoring
kubectl get servicemonitor -A
```
