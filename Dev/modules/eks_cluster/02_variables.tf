variable "aws_eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_iam_role_name" {
  description = "IAM role name for the EKS control plane."
  type        = string
}

variable "cluster_subnet_ids" {
  description = "Subnet IDs for the EKS cluster networking (private/public as needed)."
  type        = list(string)
}
