locals {
  oidc_provider_host = trimsuffix(var.oidc_provider_url, "/")
  oidc_provider_url  = startswith(var.oidc_provider_url, "https://") ? var.oidc_provider_url : "https://${local.oidc_provider_host}"
}

# Create provider if no existing
resource "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 1 : 0

  url             = local.oidc_provider_url
  client_id_list  = distinct(concat(["sts.amazonaws.com"], var.oidc_additional_client_ids))
  thumbprint_list = var.oidc_thumbprints
}

# Switch arn for provider which is used, add prefix used to build aud and sub keys
locals {
  iam_oidc_provider_arn     = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : var.oidc_provider_arn
  iam_oidc_condition_prefix = "${local.oidc_provider_host}:"
}

locals {
  plan_role_arn  = var.manage_roles ? aws_iam_role.plan[0].arn : var.existing_plan_role_arn
  apply_role_arn = var.manage_roles ? aws_iam_role.apply[0].arn : var.existing_apply_role_arn
}

resource "aws_iam_role" "plan" {
  count              = var.manage_roles ? 1 : 0
  name               = "${local.role_name_prefix}-plan"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.common_tags
}

#Add policy only for plan

resource "aws_iam_role_policy" "plan" {
  count  = var.manage_roles ? 1 : 0
  name   = "plan-permissions"
  role   = aws_iam_role.plan[count.index].id
  policy = data.aws_iam_policy_document.plan_permissions.json
}

#Create role for terraform apply 

resource "aws_iam_role" "apply" {
  count              = var.manage_roles ? 1 : 0
  name               = "${local.role_name_prefix}-apply"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.common_tags
}

#Add policy for apply

resource "aws_iam_role_policy" "apply" {
  count  = var.manage_roles ? 1 : 0
  name   = "apply-permissions"
  role   = aws_iam_role.apply[count.index].id
  policy = data.aws_iam_policy_document.apply_permissions.json
}