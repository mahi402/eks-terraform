/*
 * # AWS IAM Role module
 * Terraform module which creates SAF2.0 IAM Role in AWS
*/
#
# Filename    : modules/iam/iam_role_policy/main.tf
# Date        : 22 Nov 2021

# Description : The modules creates multiple terraform roles with multiple policies eg, inline, file policy ,customer managed etc
#

terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  namespace = "ccoe-tf-developers"
}

data "aws_iam_policy_document" "assume_trusted_aws_principals" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = var.trusted_aws_principals
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "assume_service" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = var.aws_service
      type        = "Service"
    }
  }
}


resource "aws_iam_role" "default" {
  assume_role_policy    = length(var.aws_service) == 0 ? data.aws_iam_policy_document.assume_trusted_aws_principals.json : data.aws_iam_policy_document.assume_service.json
  name                  = var.name
  description           = var.description
  path                  = var.path
  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.permission_boundary
  max_session_duration  = var.max_session_duration
  tags                  = merge(var.tags, { pge_team = local.namespace })
}

resource "aws_iam_role_policy" "role_policy" {
  count  = length(var.inline_policy)
  name   = "${var.name}-Inline-${count.index + 1}"
  policy = element(var.inline_policy, count.index)
  role   = aws_iam_role.default.id
}

resource "aws_iam_role_policy_attachment" "attach_managed_policy" {
  count      = length(var.policy_arns)
  policy_arn = element(var.policy_arns, count.index)
  role       = aws_iam_role.default.name
}
