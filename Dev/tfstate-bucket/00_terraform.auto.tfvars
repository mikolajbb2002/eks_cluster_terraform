aws_profile = "terraform-sso"
enable_kms   = true
region     = "eu-central-1"
bucket_name ="tfstate-for-ecs-app"
pipeline_oidc_provider_arn ="arn:aws:iam::121935934245:oidc-provider/token.actions.githubusercontent.com"
pipeline_oidc_subjects ="repo:mikolajbb2002/eks_cluster_terraform/*"
