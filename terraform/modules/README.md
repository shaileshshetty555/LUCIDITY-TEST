# Terraform Modules

## Purpose
Reusable Terraform modules for EKS infrastructure components.

## Components
- networking
- security
- iam
- eks
- node-group

## Deployment Commands
Modules are deployed through environment overlays:
```bash
terraform -chdir=terraform/environments/dev apply -var-file=terraform.tfvars
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
```
