project_name = "lucidity"
environment  = "dev"
owner        = "platform-team"
aws_region   = "us-east-1"

vpc_cidr           = "10.20.0.0/16"
az_count           = 2
single_nat_gateway = true

cluster_version         = "1.30"
endpoint_private_access = true
endpoint_public_access  = true
public_access_cidrs     = ["203.0.113.10/32"]
cluster_ingress_cidrs   = ["203.0.113.10/32"]

log_retention_days = 14

node_groups = {
  system = {
    instance_types = ["m6i.large"]
    desired_size   = 2
    min_size       = 2
    max_size       = 4
    labels = {
      workload = "system"
    }
  }

  apps-spot = {
    instance_types = ["m6i.large"]
    capacity_type  = "SPOT"
    desired_size   = 1
    min_size       = 1
    max_size       = 6
    labels = {
      workload  = "apps"
      lifecycle = "spot"
    }
  }
}

tags = {
  CostCenter = "engineering"
}
