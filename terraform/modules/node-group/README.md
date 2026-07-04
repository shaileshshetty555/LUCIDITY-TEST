# Node Group Module

## Purpose
Creates EKS managed node groups and underlying autoscaling groups.

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
terraform -chdir=terraform/environments/dev output node_group_asgs
kubectl get nodes -o wide
```
