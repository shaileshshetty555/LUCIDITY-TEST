variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for EKS cluster."
  type        = string
  default     = "1.30"
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS control plane."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by EKS control plane and ENIs."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs associated with EKS control plane."
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Enable private API endpoint."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public API endpoint."
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "Allowed CIDRs for public API endpoint access."
  type        = list(string)
  default     = []
}

variable "enabled_cluster_log_types" {
  description = "Control plane log types to enable."
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days for EKS control plane logs."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 7
    error_message = "log_retention_days should be at least 7 days for operational investigations."
  }
}

variable "authentication_mode" {
  description = "EKS authentication mode."
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Whether the cluster creator should receive automatic admin access."
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for envelope encryption of Kubernetes secrets."
  type        = string
  default     = null
}

variable "addons" {
  description = "EKS managed addons configuration."
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
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
