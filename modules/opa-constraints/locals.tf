locals {
  name = "opa-constraints"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "${path.module}"
    namespace   = ""
    version     = "0.0.4"
    description = "gatekeeper-constraints helm Chart deployment configuration"
    values      = []
    timeout     = "3600"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )


}