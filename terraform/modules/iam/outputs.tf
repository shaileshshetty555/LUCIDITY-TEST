output "cluster_role_arn" {
  description = "IAM role ARN for EKS control plane."
  value       = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  description = "IAM role ARN for EKS worker nodes."
  value       = aws_iam_role.eks_node.arn
}
