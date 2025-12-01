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

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
}

variable "dynamodb_attribute_name" {
  description = "Attribute name for the DynamoDB table"
  type        = string
}

variable "dynamodb_attribute_type" {
  description = "Attribute type for the DynamoDB table"
  type        = string
}

