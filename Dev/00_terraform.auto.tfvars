region      = "eu-central-1"
aws_profile = "terraform-sso"

project_name = "nginx-app"
environment  = "dev"

vpc_name               = "eks-vpc"
vpc_cidr_block               = "10.0.0.0/16"
az1                    = "eu-central-1a"
az2                    = "eu-central-1b"
public_subnet_az1_cidr = "10.0.1.0/24"
public_subnet_az2_cidr = "10.0.2.0/24"

aws_eks_cluster_name  = "eks-cluster"
cluster_iam_role_name = "eks-cluster-role"

aws_eks_node_group      = "eks-nodegroup"
node_group_desired_size = 1
node_group_max_size     = 1
node_group_min_size     = 1
node_instance_type      = "t3.small"
node_ami_type           = "AL2023_x86_64_STANDARD"
node_disk_size          = 20

nodegroup_iam_role = "eks-nodegorup-role"

tags = {
  Project = "nginx-app"
  Env     = "dev"
}

create_oidc_provider = false
oidc_provider_arn    = ""
oidc_manage_roles    = false
oidc_plan_role_arn   = ""
oidc_apply_role_arn  = ""
oidc_subjects        = []
