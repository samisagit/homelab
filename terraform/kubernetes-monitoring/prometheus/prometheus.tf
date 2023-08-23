resource "kubernetes_manifest" "role" {
  manifest = yamldecode(file("${path.module}/role.yaml"))
}

resource "kubernetes_manifest" "role_binding" {
  manifest = yamldecode(file("${path.module}/role-binding.yaml"))

  depends_on = [
    kubernetes_manifest.role
  ]
}

resource "kubernetes_manifest" "config_map" {
  manifest = yamldecode(file("${path.module}/config-map.yaml"))
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/deployment.yaml"))

  depends_on = [
    kubernetes_manifest.config_map
  ]
}
