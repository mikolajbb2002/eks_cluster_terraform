terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.17"
  }
}
}

provider "aws" {
  profile = var.aws_profile
  region  = var.region
  
}

module "oidc" {
  source        = "../modules/oidc"
  project_name  = var.project_name
  environment   = var.environment
  region        = var.region
  tags          = var.tags
  create_oidc_provider = true
  oidc_subjects        = var.oidc_subjects
}