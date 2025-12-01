project_name  = "nginx-app"
environment   = "dev"
region        = "eu-central-1"
aws_profile   = "" # Use empty when using OIDC - terraform-sso
tags = {
  ManagedBy = "Terraform"
}
oidc_subjects = [
  "repo:mikolajbb2002/eks_cluster_terraform:ref:refs/heads/*",
  "repo:mikolajbb2002/eks_cluster_terraform:pull_request"
]
