variable "project_name" {
  description = "Global project name used for naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
}

variable "owner" {
  description = "Team or owner tag value."
  type        = string
}

variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR."
  }
}

variable "az_count" {
  description = "Number of Availability Zones to use."
  type        = number

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 4
    error_message = "az_count must be between 2 and 4."
  }
}

variable "single_nat_gateway" {
  description = "If true, create a single NAT gateway (lower cost, lower resilience)."
  type        = bool
  default     = false
}

variable "cluster_name_override" {
  description = "Optional explicit EKS cluster name."
  type        = string
  default     = null
}

variable "cluster_version" {
  description = "Kubernetes version for EKS."
  type        = string
  default     = "1.30"
}

variable "endpoint_private_access" {
  description = "Enable private endpoint for EKS API."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public endpoint for EKS API."
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "Allowed CIDRs when public EKS endpoint is enabled."
  type        = list(string)
  default     = []
}

variable "cluster_ingress_cidrs" {
  description = "Additional CIDRs allowed to reach cluster SG on 443."
  type        = list(string)
  default     = []
}

variable "enabled_cluster_log_types" {
  description = "EKS control plane logs enabled to CloudWatch."
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "log_retention_days" {
  description = "CloudWatch retention days for EKS logs."
  type        = number
  default     = 30
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Whether cluster creator gets automatic admin permissions."
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for secrets encryption."
  type        = string
  default     = null
}

variable "additional_node_policy_arns" {
  description = "Additional IAM policies attached to node role."
  type        = list(string)
  default     = []
}

variable "node_groups" {
  description = "Managed node groups definition."
  type = map(object({
    instance_types  = optional(list(string), ["m6i.large"])
    capacity_type   = optional(string, "ON_DEMAND")
    ami_type        = optional(string, "AL2023_x86_64_STANDARD")
    disk_size       = optional(number, 50)
    desired_size    = number
    min_size        = number
    max_size        = number
    max_unavailable = optional(number, 1)
    labels          = optional(map(string), {})
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
  }))
}

variable "eks_addons" {
  description = "EKS addons configuration map."
  type = map(object({
    addon_version               = optional(string)
    most_recent                 = optional(bool, true)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
    preserve                    = optional(bool, true)
  }))

  default = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }
}

variable "tags" {
  description = "Additional tags to merge into the default tagging strategy."
  type        = map(string)
  default     = {}
}
