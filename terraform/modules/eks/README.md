# EKS Module

## Purpose
Creates EKS control plane, logging, add-ons, and optional encryption settings.

## Deployment Commands
```bash
terraform -chdir=terraform/environments/dev plan -var-file=terraform.tfvars
terraform -chdir=terraform/environments/dev apply -var-file=terraform.tfvars
```

## Validation Commands
```bash
terraform -chdir=terraform/environments/dev validate
```

## Status Check Commands
```bash
aws eks describe-cluster --name $(terraform -chdir=terraform/environments/dev output -raw cluster_name) --region us-east-1
kubectl get nodes
```
