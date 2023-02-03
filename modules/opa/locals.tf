locals {
  name = "gatekeeper"

  default_helm_config = {
    name             = local.name
    chart            = local.name
    repository       = "https://open-policy-agent.github.io/gatekeeper/charts"
    version          = "3.9.0"
    namespace        = "gatekeeper-system"
    description      = "Install gatekeeper to guard your cluster"
    values           = []
    timeout          = "3600"
    create_namespace = true
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )


}