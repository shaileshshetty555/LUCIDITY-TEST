# Production Environment

## Purpose
Production-grade EKS environment with resilient and secure defaults.

## Deployment Commands
```bash
cd terraform/environments/prod
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
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
kubectl get pods -A
```
