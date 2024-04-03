locals {
  yaml_files = fileset("./kubernetes_manifest", "*.yaml")
  yaml_contents = {
    for f in local.yaml_files : f => yamldecode(file("./kubernetes_manifest/${f}"))
    }
}

resource "kubernetes_manifest" "manifest" {
  for_each = local.yaml_contents
  manifest = each.value
}