# Security Module

## Purpose
Creates security groups and rules for EKS control plane and worker nodes.

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
terraform -chdir=terraform/environments/dev output
kubectl get svc -A
```
