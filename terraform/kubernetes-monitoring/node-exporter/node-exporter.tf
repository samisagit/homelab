resource "kubernetes_manifest" "daemonset" {
  manifest = yamldecode(file("${path.module}/daemonset.yaml"))
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.module}/service.yaml"))

  depends_on = [kubernetes_manifest.daemonset]
}

