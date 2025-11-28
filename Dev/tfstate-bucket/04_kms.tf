
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

output "kms_key_arn" {
  description = "KMS key ARN (null when KMS disabled)"
  value       = try(aws_kms_key.tfstate[0].arn, null)
}