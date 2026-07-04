data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  selected_azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  public_subnet_cidrs = [
    for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 4, i)
  ]

  private_subnet_cidrs = [
    for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 4, i + var.az_count)
  ]

  cluster_name = coalesce(var.cluster_name_override, "${local.name_prefix}-eks")

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner
      Layer       = "platform"
    },
    var.tags
  )
}

module "networking" {
  source               = "../../modules/networking"
  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  azs                  = local.selected_azs
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  single_nat_gateway   = var.single_nat_gateway
  cluster_name         = local.cluster_name
  tags                 = local.common_tags
}

module "security" {
  source                = "../../modules/security"
  name_prefix           = local.name_prefix
  vpc_id                = module.networking.vpc_id
  cluster_ingress_cidrs = var.cluster_ingress_cidrs
  tags                  = local.common_tags
}

module "iam" {
  source                      = "../../modules/iam"
  name_prefix                 = local.name_prefix
  additional_node_policy_arns = var.additional_node_policy_arns
  tags                        = local.common_tags
}

module "eks" {
  source                                      = "../../modules/eks"
  cluster_name                                = local.cluster_name
  cluster_version                             = var.cluster_version
  cluster_role_arn                            = module.iam.cluster_role_arn
  subnet_ids                                  = module.networking.private_subnet_ids
  security_group_ids                          = [module.security.cluster_security_group_id]
  endpoint_private_access                     = var.endpoint_private_access
  endpoint_public_access                      = var.endpoint_public_access
  public_access_cidrs                         = var.public_access_cidrs
  enabled_cluster_log_types                   = var.enabled_cluster_log_types
  log_retention_days                          = var.log_retention_days
  bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  kms_key_arn                                 = var.kms_key_arn
  addons                                      = var.eks_addons
  tags                                        = local.common_tags
}

module "node_groups" {
  for_each = var.node_groups

  source          = "../../modules/node-group"
  cluster_name    = module.eks.cluster_name
  node_group_name = "${local.name_prefix}-${each.key}"
  node_role_arn   = module.iam.node_role_arn
  subnet_ids      = module.networking.private_subnet_ids

  instance_types  = try(each.value.instance_types, ["m6i.large"])
  capacity_type   = try(each.value.capacity_type, "ON_DEMAND")
  ami_type        = try(each.value.ami_type, "AL2023_x86_64_STANDARD")
  disk_size       = try(each.value.disk_size, 50)
  desired_size    = each.value.desired_size
  min_size        = each.value.min_size
  max_size        = each.value.max_size
  max_unavailable = try(each.value.max_unavailable, 1)
  labels          = try(each.value.labels, {})
  taints          = try(each.value.taints, [])

  tags = merge(local.common_tags, {
    NodeGroup = each.key
  })

  depends_on = [module.eks]
}
