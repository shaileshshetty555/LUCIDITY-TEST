variable "name_prefix" {
  description = "Prefix for security group naming."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security groups are created."
  type        = string
}

variable "cluster_ingress_cidrs" {
  description = "CIDRs allowed to access EKS API endpoint on 443 when public endpoint is enabled."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
