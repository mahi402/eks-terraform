locals {
  name                 = "aws-cloudwatch-metrics"
  namespace            = "amazon-cloudwatch"
  service_account_name = "cloudwatch-agent"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "${path.module}"
    version     = "0.0.7"
    namespace   = local.namespace
    values      = local.default_helm_values
    description = "aws-cloudwatch-metrics Helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  default_helm_values = [templatefile("${path.module}/values.yaml", {
    eks_cluster_id = var.addon_context.eks_cluster_id
  })]

  set_values = [
    {
      name  = "serviceAccount.name"
      value = local.service_account_name
    },
    {
      name  = "serviceAccount.create"
      value = false
    }
  ]

  irsa_config = {
    kubernetes_namespace              = local.helm_config["namespace"]
    kubernetes_service_account        = local.service_account_name
    create_kubernetes_namespace       = try(local.helm_config["create_namespace"], true)
    create_kubernetes_service_account = true
    irsa_iam_policies                 = concat(["arn:${var.addon_context.aws_partition_id}:iam::aws:policy/CloudWatchAgentServerPolicy"], var.irsa_policies)
  }


}
