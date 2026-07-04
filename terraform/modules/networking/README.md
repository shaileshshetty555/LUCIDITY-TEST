# Networking Module

## Purpose
Creates VPC, public/private subnets, IGW, NAT gateways, and route tables for EKS.

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
terraform -chdir=terraform/environments/dev output vpc_id
terraform -chdir=terraform/environments/dev output private_subnet_ids
```
