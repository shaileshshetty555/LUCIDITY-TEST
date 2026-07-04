project_name = "lucidity"
environment  = "prod"
owner        = "platform-team"
aws_region   = "us-east-1"

vpc_cidr           = "10.40.0.0/16"
az_count           = 3
single_nat_gateway = false

cluster_version         = "1.30"
endpoint_private_access = true
endpoint_public_access  = false

log_retention_days = 90

node_groups = {
  system = {
    instance_types = ["m6i.xlarge"]
    desired_size   = 3
    min_size       = 3
    max_size       = 6
    labels = {
      workload = "system"
      tier     = "critical"
    }
  }

  apps-ondemand = {
    instance_types = ["m6i.2xlarge"]
    desired_size   = 4
    min_size       = 4
    max_size       = 12
    labels = {
      workload  = "apps"
      lifecycle = "ondemand"
    }
  }

  apps-spot = {
    instance_types = ["m6i.2xlarge"]
    capacity_type  = "SPOT"
    desired_size   = 2
    min_size       = 2
    max_size       = 10
    labels = {
      workload  = "apps"
      lifecycle = "spot"
    }
  }
}

tags = {
  CostCenter = "production"
  Compliance = "required"
}
