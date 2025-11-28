variable "region" {
  description = "Deployment region (e.g., eu-central-1)"
  type        = string
}

variable "aws_profile" {
  description = "Shared config/credentials profile name for local runs; leave empty when using OIDC"
  type        = string
}