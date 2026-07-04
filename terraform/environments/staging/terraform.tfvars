project_name = "lucidity"
environment  = "staging"
owner        = "platform-team"
aws_region   = "us-east-1"

vpc_cidr           = "10.30.0.0/16"
az_count           = 3
single_nat_gateway = false

cluster_version         = "1.30"
endpoint_private_access = true
endpoint_public_access  = false

log_retention_days = 30

node_groups = {
  system = {
    instance_types = ["m6i.large"]
    desired_size   = 3
    min_size       = 3
    max_size       = 6
    labels = {
      workload = "system"
    }
  }

  apps = {
    instance_types = ["m6i.xlarge"]
    desired_size   = 3
    min_size       = 3
    max_size       = 9
    labels = {
      workload = "apps"
    }
  }
}

tags = {
  CostCenter = "staging"
}
