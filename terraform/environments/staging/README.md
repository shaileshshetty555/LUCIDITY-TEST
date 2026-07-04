# Staging Environment

## Purpose
Pre-production EKS environment for integration and reliability validation.

## Deployment Commands
```bash
cd terraform/environments/staging
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Validation Commands
```bash
terraform -chdir=terraform/environments/staging validate
```

## Status Check Commands
```bash
terraform -chdir=terraform/environments/staging output
kubectl get nodes
kubectl get pods -A
```
