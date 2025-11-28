output "vpc_id" {
  description = "VPC identifier."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs used by the cluster."
  value       = module.network.public_subnet_ids
}

output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks_cluster.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint."
  value       = module.eks_cluster.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded cluster CA data."
  value       = module.eks_cluster.cluster_certificate_authority_data
}

output "cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane."
  value       = module.eks_cluster.cluster_role_arn
}

output "node_group_name" {
  description = "Managed node group name."
  value       = module.eks_nodegroup.node_group_name
}

output "node_group_arn" {
  description = "Managed node group ARN."
  value       = module.eks_nodegroup.node_group_arn
}

output "node_role_arn" {
  description = "IAM role ARN assumed by nodes."
  value       = module.eks_nodegroup.node_role_arn
}

output "nodegroup_subnet_ids" {
  description = "Subnet IDs created for the node group."
  value       = module.eks_nodegroup.subnet_ids
}
