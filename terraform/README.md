# Terraform Infrastructure

## Purpose
Contains Terraform code for production-grade AWS EKS infrastructure.

## Components
- `environments`: Environment overlays (dev, staging, prod)
- `modules`: Reusable infrastructure modules
- `docs`: Supporting Terraform operational documentation

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
terraform -chdir=terraform/environments/dev fmt -recursive
terraform -chdir=terraform/environments/dev validate
terraform -chdir=terraform/environments/staging validate
terraform -chdir=terraform/environments/prod validate
```

## Status Check Commands
```bash
terraform -chdir=terraform/environments/dev output
aws eks list-clusters --region us-east-1
kubectl get nodes
```
