resource "kubernetes_manifest" "config_map" {
  manifest = yamldecode(file("${path.module}/config-map.yaml"))
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/deployment.yaml"))

  depends_on = [
    kubernetes_manifest.config_map
  ]
}

resource "kubernetes_manifest" "loadbalancer" {
  manifest = yamldecode(file("${path.module}/service.yaml"))

  depends_on = [
    kubernetes_manifest.deployment
  ]
}
