# IAM Module

## Purpose
Creates IAM roles and policy attachments for EKS cluster and node groups.

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
aws iam list-roles | grep eks
```
