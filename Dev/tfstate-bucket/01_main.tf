data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# KMS key used to encrypt Terraform state (optional)
resource "aws_kms_key" "tfstate" {
  count               = var.enable_kms ? 1 : 0
  description         = "KMS key for Terraform state file"
  enable_key_rotation = true
}

resource "aws_kms_alias" "tfstate" {
  count         = var.enable_kms ? 1 : 0
  name          = "alias/tfstate-${data.aws_caller_identity.current.account_id}"
  target_key_id = aws_kms_key.tfstate[0].key_id
}

# S3 bucket storing terraform.tfstate
resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "infra"
    ManagedBy   = "terraform"
  }
}

# Block public access to the state bucket
resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket                  = aws_s3_bucket.tfstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning for state retention
resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}


output "tfstate_bucket_name" {
  description = "Name of the state bucket"
  value       = aws_s3_bucket.tfstate.bucket
}

output "kms_key_arn" {
  description = "KMS key ARN (null when KMS disabled)"
  value       = try(aws_kms_key.tfstate[0].arn, null)
}