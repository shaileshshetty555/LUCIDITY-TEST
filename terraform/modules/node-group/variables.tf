variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group."
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for worker nodes."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for node placement."
  type        = list(string)
}

variable "instance_types" {
  description = "EC2 instance types for node group."
  type        = list(string)
  default     = ["m6i.large"]
}

variable "capacity_type" {
  description = "Node capacity type: ON_DEMAND or SPOT."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "ami_type" {
  description = "AMI type used by managed node group."
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "disk_size" {
  description = "Node root volume size in GiB."
  type        = number
  default     = 50

  validation {
    condition     = var.disk_size >= 20
    error_message = "disk_size should be at least 20 GiB."
  }
}

variable "desired_size" {
  description = "Desired node count."
  type        = number
}

variable "min_size" {
  description = "Minimum node count."
  type        = number
}

variable "max_size" {
  description = "Maximum node count."
  type        = number
}

variable "max_unavailable" {
  description = "Maximum unavailable nodes during updates."
  type        = number
  default     = 1
}

variable "labels" {
  description = "Kubernetes labels for nodes."
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "Optional list of Kubernetes taints for the node group."
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}

variable "launch_template" {
  description = "Optional launch template configuration."
  type = object({
    id      = string
    version = string
  })
  default = null
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
