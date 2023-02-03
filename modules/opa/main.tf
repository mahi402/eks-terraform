
resource "kubernetes_namespace_v1" "this" {
  count = try(local.helm_config["create_namespace"], true) && local.helm_config["namespace"] != "gatekeeper-system" ? 1 : 0

  metadata {
    name = local.helm_config["namespace"]
    labels = {
      "app"                            = "gatekeeper"
      "admission.gatekeeper.sh/ignore" = "no-self-managing"
      "control-plane"                  = "controller-manager"
      "gatekeeper.sh/system"           = "yes"
    }
  }
}

module "helm_addon" {
  source        = "../helm-addon"
  helm_config   = local.helm_config
  irsa_config   = null
  addon_context = var.addon_context

}

