output "plan_role_arn" {
  description = "IAM role ARN used by the pipeline for terraform plan"
  value       = local.plan_role_arn
}

output "apply_role_arn" {
  description = "IAM role ARN used by the pipeline for terraform apply"
  value       = local.apply_role_arn
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN trusted by the pipeline roles"
  value       = local.iam_oidc_provider_arn
}