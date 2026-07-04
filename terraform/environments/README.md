# Terraform Environments

## Purpose
Environment-specific Terraform overlays for EKS: dev, staging, prod.

## Deployment Commands
Dev:
```bash
cd terraform/environments/dev
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Staging:
```bash
cd terraform/environments/staging
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Prod:
```bash
cd terraform/environments/prod
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Validation Commands
```bash
terraform -chdir=terraform/environments/dev validate
terraform -chdir=terraform/environments/staging validate
terraform -chdir=terraform/environments/prod validate
```

## Status Check Commands
```bash
terraform -chdir=terraform/environments/dev output
terraform -chdir=terraform/environments/staging output
terraform -chdir=terraform/environments/prod output
```
