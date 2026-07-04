# EKS Platform Monorepo

## Repository Layout

```text
.
├── application-code/
│   ├── README.md
│   └── services/
│       ├── README.md
│       └── hello-world-python/
├── application-helm-charts/
│   ├── README.md
│   └── hello-world/
├── kube-prometheus-helm-charts/
│   ├── README.md
│   └── kube-prometheus-stack/
├── terraform/
│   ├── README.md
│   ├── environments/
│   ├── modules/
│   └── docs/
└── deploy/
    ├── README.md
    └── deploy-hello-world.sh
```

## Component Purpose
- `application-code`: Python application source code and Docker assets.
- `application-helm-charts`: Application Helm charts and environment values.
- `kube-prometheus-helm-charts`: Monitoring Helm charts and EKS monitoring values.
- `terraform`: EKS infrastructure as code.
- `deploy`: End-to-end deployment automation script.

## Deployment Commands
1. Provision EKS infrastructure.

    terraform -chdir=./terraform/environments/dev init -backend=false
    terraform -chdir=./terraform/environments/dev apply -var-file=terraform.tfvars

2. Deploy monitoring stack.

    helm dependency build ./kube-prometheus-helm-charts/kube-prometheus-stack
    helm upgrade --install kube-prometheus-stack ./kube-prometheus-helm-charts/kube-prometheus-stack -n monitoring --create-namespace -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml

3. Deploy application stack.

    AWS_REGION=us-east-1 ENVIRONMENT=dev IMAGE_TAG=1.0.0 ./deploy/deploy-hello-world.sh

## Validation Commands
```bash
helm lint ./application-helm-charts/hello-world
helm lint ./kube-prometheus-helm-charts/kube-prometheus-stack -f ./kube-prometheus-helm-charts/kube-prometheus-stack/values-dev.yaml
terraform -chdir=./terraform/environments/dev validate
```

## Status Check Commands
```bash
kubectl get nodes
kubectl get pods -A
kubectl get servicemonitor -A
kubectl get prometheus -n monitoring
```
