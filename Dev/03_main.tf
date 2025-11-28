locals {
  # lines below build standarized resource names
  project            = lower(replace(var.project_name, " ", "-"))
  region             = lower(var.region)
  env                = lower(var.environment)
  vpc_name   = "${local.project}-${local.env}-vpc"
  aws_eks_cluster_name = "${local.project}-${local.env}-eks-cluster"
  aws_eks_node_group   = "${local.project}-${local.env}-eks-nodegroup"
}

module "network" {
  source = "./modules/network"
  vpc_cidr_block         = var.vpc_cidr_block
  vpc_name               = var.vpc_name
  az1                    = var.az1
  az2                    = var.az2
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
}

module "eks_cluster" {
  source = "./modules/eks_cluster"

  aws_eks_cluster_name = var.aws_eks_cluster_name
  cluster_subnet_ids   = module.network.public_subnet_ids
  cluster_iam_role_name = var.cluster_iam_role_name
}

module "eks_nodegroup" {
  source = "./modules/eks_nodegroup"

  cluster_name            = module.eks_cluster.cluster_name
  aws_eks_node_group      = var.aws_eks_node_group
  node_group_desired_size = var.node_group_desired_size
  node_group_max_size     = var.node_group_max_size
  node_group_min_size     = var.node_group_min_size
  node_instance_type      = var.node_instance_type
  node_ami_type           = var.node_ami_type
  node_disk_size          = var.node_disk_size
  subnet_ids              = module.network.public_subnet_ids
  nodegroup_iam_role      = var.nodegroup_iam_role
}

module "oidc" {
  source       = "./modules/oidc"
  project_name = var.project_name
  environment  = var.environment
  region       = var.region
  tags         = var.tags

  create_oidc_provider    = var.create_oidc_provider
  oidc_provider_arn       = var.oidc_provider_arn
  manage_roles            = var.oidc_manage_roles
  existing_plan_role_arn  = var.oidc_plan_role_arn
  existing_apply_role_arn = var.oidc_apply_role_arn
  oidc_subjects           = var.oidc_subjects
}

terraform {
  backend "s3" {
    bucket  = "tfstate-for-ecs-app"
    key     = "main/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
