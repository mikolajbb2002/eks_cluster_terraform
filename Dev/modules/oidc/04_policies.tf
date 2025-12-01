#Build data used to role names
locals {
  project_slug     = lower(replace(var.project_name, " ", "-"))
  environment_slug = lower(replace(var.environment, " ", "-"))
  role_name_prefix = "${local.project_slug}-${var.region}-${local.environment_slug}"

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = upper(var.environment)
      Region      = var.region
      ManagedBy   = "Terraform"
      Component   = "iam"
    },
    var.tags
  )
  # ARN lists for bucket without /* for object with /*
  apply_s3_bucket_arns = [for arn in var.apply_s3_resource_arns : arn if !endswith(arn, "/*")]
  apply_s3_object_arns = [for arn in var.apply_s3_resource_arns : arn if endswith(arn, "/*")]

  #Priviligies for plan role used for terraform plan
  #List* is used to compare data

  plan_read_actions = [
    "s3:Get*",
    "s3:List*",
    "iam:Get*",
    "iam:List*",
    "kms:DescribeKey",
    "kms:Get*",
    "kms:List*",
    "dynamodb:Get*",
    "dynamodb:List*",
    "ec2:Describe*",
    "ec2:Get*",
    "ec2:List*",
    "eks:Describe*",
    "eks:List*",
    "elasticloadbalancing:Describe*",
    "elasticloadbalancing:Get*",
  ]
}

# Allows all action from plan_read_actions list
data "aws_iam_policy_document" "plan_permissions" {
  statement {
    effect    = "Allow"
    actions   = local.plan_read_actions
    resources = ["*"]
  }

  #Allow role to GetCallerIdentity 
  statement {
    effect    = "Allow"
    actions   = ["sts:GetCallerIdentity"]
    resources = ["*"]
  }
}

#This block defines full privilliges for apply role
data "aws_iam_policy_document" "apply_permissions" {

  # application-autoscaling grants 
  statement {
    effect = "Allow"
    actions = [
      "eks:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "eks:Delete*",
    ]
    resources = ["*"]
  }

  # alb grants 
  statement {
    effect = "Allow"
    actions = [
      "elasticloadbalancing:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "elasticloadbalancing:Delete*",
    ]
    resources = ["*"]
  }

statement {
  effect = "Allow"
    actions = [
      "dynamodb:*",
    ]
    resources = ["*"]
  }

statement {
    effect = "Allow"
    actions = [
      "ec2:*",
    ]
    resources = ["*"]
}

statement {
    effect = "Deny"
    actions = [
      "ec2:Delete*",
    ]
    resources = ["*"]
}
  #Full grants for kms keys except deletion operation defined in statement below

  statement {
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = length(var.apply_kms_key_arns) > 0 ? var.apply_kms_key_arns : ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:DeleteAlias"
    ]
    resources = length(var.apply_kms_key_arns) > 0 ? var.apply_kms_key_arns : ["*"]
  }


  # S3 access for state bucket and other artifacts
  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = length(var.apply_s3_resource_arns) > 0 ? concat(local.apply_s3_bucket_arns, local.apply_s3_object_arns) : ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "s3:Delete*"
    ]
    resources = length(var.apply_s3_resource_arns) > 0 ? var.apply_s3_resource_arns : ["*"]
  }

  # IAM grants required to manage execution roles and OIDC providers
  statement {
    effect = "Allow"
    actions = [
      "iam:*",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "iam:Delete*",
    ]
    resources = ["*"]
  }


  # full access to policies but only for plan and apply roles

  statement {
    effect = "Allow"
    actions = [
      "iam:*"
    ]
    resources = [
      local.plan_role_arn,
      local.apply_role_arn
    ]
  }

  #Allow role to GetCallerIdentity 

  statement {
    effect    = "Allow"
    actions   = ["sts:GetCallerIdentity"]
    resources = ["*"]
  }
}