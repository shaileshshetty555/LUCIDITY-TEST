variable "name_prefix" {
  description = "Prefix used for IAM role names."
  type        = string
}

variable "additional_node_policy_arns" {
  description = "Additional IAM policy ARNs to attach to the node role."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to IAM resources that support tagging."
  type        = map(string)
  default     = {}
}
