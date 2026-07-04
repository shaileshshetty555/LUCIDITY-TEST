# Dev Environment

## Purpose
Development environment for fast iteration and lower-cost EKS testing.

## Deployment Commands
```bash
cd terraform/environments/dev
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Validation Commands
```bash
terraform -chdir=terraform/environments/dev validate
```

## Status Check Commands
```bash
terraform -chdir=terraform/environments/dev output
kubectl get nodes
kubectl get pods -A
```
