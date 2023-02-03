/*
 * # AWS IAM Policy module
 * Terraform module which creates SAF2.0 IAM Policy in AWS
*/
#
#  Filename    : modules/iam/iam_policy/main.tf
#  Date        : 17 Nov 2021
#  
#  Description : multiple iam policy creation modules
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

#Combine multiple customer managed policies
locals {
  iam_policies = [for src in var.policy : jsondecode(src)]
  iam_policy_statements = flatten([
    for policy in local.iam_policies : policy.Statement
  ])
  merged_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.iam_policy_statements
  })
}

resource "aws_iam_policy" "default" {
  name        = var.name
  path        = var.path
  description = var.description
  policy      = local.merged_policy
  tags        = merge(var.tags, { pge_team = local.namespace })
}


