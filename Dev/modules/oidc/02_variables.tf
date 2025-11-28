variable "project_name" {
  description = "Project/system identifier used to build role names"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "AWS region metadata used for tagging"
  type        = string
}

variable "tags" {
  description = "Additional tags applied to the IAM roles"
  type        = map(string)
  default     = {}
}

variable "plan_s3_resource_arns" {
  description = "S3 resource ARNs (bucket and objects) the plan role may read"
  type        = list(string)
  default     = []
}

variable "plan_kms_key_arns" {
  description = "KMS key ARNs the plan role may describe"
  type        = list(string)
  default     = []
}

variable "apply_s3_resource_arns" {
  description = "S3 resource ARNs (bucket and objects) the apply role may manage"
  type        = list(string)
  default     = []
}

variable "apply_cloudfront_arns" {
  description = "CloudFront distribution ARNs the apply role may manage"
  type        = list(string)
  default     = []
}

variable "apply_kms_key_arns" {
  description = "KMS key ARNs the apply role may manage"
  type        = list(string)
  default     = []
}

variable "apply_pass_role_arns" {
  description = "IAM role ARNs the apply role may pass to AWS services"
  type        = list(string)
  default     = []
}

variable "create_oidc_provider" {
  description = "When true, create the GitHub Actions OIDC provider in this account"
  type        = bool
  default     = true
}

variable "manage_roles" {
  description = "When true, the module creates the plan/apply roles; otherwise existing ARNs must be provided."
  type        = bool
  default     = true
}

variable "oidc_provider_arn" {
  description = "Existing OIDC provider ARN (used when create_oidc_provider is false)"
  type        = string
  default     = null
  validation {
    condition     = var.create_oidc_provider || var.oidc_provider_arn != null
    error_message = "Set oidc_provider_arn when create_oidc_provider is false."
  }
}

variable "oidc_provider_url" {
  description = "OIDC provider host (token.actions.githubusercontent.com)"
  type        = string
  default     = "token.actions.githubusercontent.com"
}

variable "oidc_thumbprints" {
  description = "Thumbprints trusted when creating the provider"
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

variable "oidc_additional_client_ids" {
  description = "Additional client IDs allowed for the provider (STS is always included)"
  type        = list(string)
  default     = []
}

variable "oidc_audience" {
  description = "Audience expected in the OIDC token"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "oidc_subjects" {
  description = "Exact OIDC subjects (repo:org/repo:ref:refs/heads/branch) allowed to assume the roles"
  type        = list(string)
}

variable "existing_plan_role_arn" {
  description = "Existing IAM role ARN used for terraform plan when manage_roles is false."
  type        = string
  default     = null
  validation {
    condition     = var.manage_roles || var.existing_plan_role_arn != null
    error_message = "Provide existing_plan_role_arn when manage_roles is false."
  }
}

variable "existing_apply_role_arn" {
  description = "Existing IAM role ARN used for terraform apply when manage_roles is false."
  type        = string
  default     = null
  validation {
    condition     = var.manage_roles || var.existing_apply_role_arn != null
    error_message = "Provide existing_apply_role_arn when manage_roles is false."
  }
}