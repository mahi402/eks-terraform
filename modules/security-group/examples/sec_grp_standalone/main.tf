/*
 * # AWS IAM Security Group module
 * Terraform module which creates SAF2.0 Security Group in AWS
*/
# Filename    : modules/security-group/examples/sec_grp_standalone/main.tf
# Date        : 27 December 2021
# Author      : Renuka Uppalapati (rxuu@pge.com)
# Description : security group creation
#
locals {
  name               = var.name
  description        = var.description
  AppID              = var.AppID
  Environment        = var.Environment
  DataClassification = var.DataClassification
  CRIS               = var.CRIS
  Notify             = var.Notify
  Owner              = var.Owner
  Compliance         = var.Compliance
}

module "tags" {
  source             = "../../../tags"
  AppID              = local.AppID
  Environment        = local.Environment
  DataClassification = local.DataClassification
  CRIS               = local.CRIS
  Notify             = local.Notify
  Owner              = local.Owner
  Compliance         = local.Compliance
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/vpc-coe/id"
}

#########################################
# Create Standalone Security Group
#########################################
module "standalone_security_group" {
  source                       = "../../"
  name                         = local.name
  description                  = local.description
  vpc_id                       = data.aws_ssm_parameter.vpc_id.value
  cidr_ingress_rules           = var.cidr_ingress_rules
  cidr_egress_rules            = var.cidr_egress_rules
  security_group_ingress_rules = var.security_group_ingress_rules
  security_group_egress_rules  = var.security_group_egress_rules
  tags                         = module.tags.tags
}


