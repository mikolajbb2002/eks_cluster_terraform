variable "region" {
  description = "Deployment region (e.g., eu-central-1)"
  type        = string
}

variable "aws_profile" {
  description = "Shared config/credentials profile name for local runs; leave empty when using OIDC"
  type        = string
}

variable "project_name" {
  description = "Project identifier used in resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)."
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "az1" {
  description = "First availability zone identifier."
  type        = string
}

variable "az2" {
  description = "Second availability zone identifier."
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "CIDR for the public subnet in az1."
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR for the public subnet in az2."
  type        = string
}

variable "aws_eks_cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_iam_role_name" {
  description = "IAM role name for the EKS control plane."
  type        = string
}

variable "aws_eks_node_group" {
  description = "Name of the EKS managed node group."
  type        = string
}

variable "node_group_desired_size" {
  description = "Desired size of the node group."
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum size of the node group."
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum size of the node group."
  type        = number
}

variable "node_instance_type" {
  description = "Instance type for worker nodes."
  type        = string
}

variable "node_ami_type" {
  description = "AMI type for worker nodes."
  type        = string
}

variable "node_disk_size" {
  description = "Root volume size (GiB) for worker nodes."
  type        = number
}

variable "nodegroup_iam_role" {
  description = "IAM role name for the managed node group."
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources."
  type        = map(string)
}

variable "create_oidc_provider" {
  description = "Whether to create an OIDC provider for CI/CD roles."
  type        = bool
}

variable "oidc_provider_arn" {
  description = "Existing OIDC provider ARN (when not creating a new one)."
  type        = string
}

variable "oidc_manage_roles" {
  description = "Whether the module should manage IAM roles for OIDC."
  type        = bool
}

variable "oidc_plan_role_arn" {
  description = "Existing IAM role ARN used for terraform plan (if provided)."
  type        = string
}

variable "oidc_apply_role_arn" {
  description = "Existing IAM role ARN used for terraform apply (if provided)."
  type        = string
}

variable "oidc_subjects" {
  description = "List of OIDC subjects allowed to assume roles."
  type        = list(string)
}

variable "destination_cidr_block" {
  description = "CIDR block for internet-bound traffic."
  type        = string
  
}
