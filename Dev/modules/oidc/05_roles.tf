data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringLike"
      values   = var.oidc_subjects
      variable = "${local.iam_oidc_condition_prefix}sub"
    }

    condition {
      test     = "StringLike"
      values   = [var.oidc_audience]
      variable = "${local.iam_oidc_condition_prefix}aud"
    }

    principals {
      identifiers = [local.iam_oidc_provider_arn]
      type        = "Federated"
    }
  }
}