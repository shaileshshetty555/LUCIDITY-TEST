output "node_group_arn" {
  description = "Node group ARN."
  value       = aws_eks_node_group.this.arn
}

output "node_group_status" {
  description = "Node group status."
  value       = aws_eks_node_group.this.status
}

output "autoscaling_group_names" {
  description = "Underlying Auto Scaling Group names created by the managed node group."
  value       = [for ng in aws_eks_node_group.this.resources : ng.autoscaling_groups[*].name]
}
