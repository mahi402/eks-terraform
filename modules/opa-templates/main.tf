# module "helm_addon" {
#   source            = "../helm-addon"
#   helm_config       = local.helm_config
#   addon_context     = var.addon_context

# }

resource "helm_release" "opa-templates" {
  name  = "opa-templates"
  chart = "${path.module}/charts"

}