variable "region" {
  description = " AWS Region where bucket is gonna be created"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name for tfstate file"
  type        = string
}

variable "aws_profile" {
  description = "Shared config/credentials profile name for local runs; leave empty when using OIDC"
  type        = string
}

variable "enable_kms" {
  description = "Enable KMS encryption for bucket"
  type        = bool
}

variable "pipeline_oidc_provider_arn" {
  description = "OICD provider"
  type        = string  
}

variable "pipeline_oidc_subjects" {
  description = "my repo"
  type        = string
  }