output "node_group_arn" {
  description = "ARN of the managed node group."
  value       = aws_eks_node_group.example.arn
}

output "node_group_name" {
  description = "Name of the managed node group."
  value       = aws_eks_node_group.example.node_group_name
}

output "node_role_arn" {
  description = "IAM role ARN assumed by the node group."
  value       = aws_iam_role.example.arn
}

output "subnet_ids" {
  description = "Identifiers of the subnets created for the node group."
  value       = aws_subnet.example[*].id
}
