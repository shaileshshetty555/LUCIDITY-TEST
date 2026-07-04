# Terraform Docs

## Purpose
Contains Terraform operational documentation and runbook placeholders.

## Deployment Commands
```bash
cd terraform/environments/prod
terraform apply -var-file=terraform.tfvars
```

## Validation Commands
```bash
terraform -chdir=terraform/environments/prod validate
```

## Status Check Commands
```bash
terraform -chdir=terraform/environments/prod output
kubectl get nodes
```
