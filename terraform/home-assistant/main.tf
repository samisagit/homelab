provider "kubernetes" {
  config_path    = "~/.kubeconfig/k3s.yaml"
}

resource "kubernetes_namespace" "ha" {
  metadata {
    name = "ha"
  }
}

resource "kubernetes_manifest" "pvc" {
  manifest = yamldecode(file("${path.module}/persistent-volume-claim.yaml"))

  depends_on = [
    kubernetes_namespace.ha
  ]
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/deployment.yaml"))

  depends_on = [
    kubernetes_manifest.pvc
  ]
}

resource "kubernetes_manifest" "loadbalancer" {
  manifest = yamldecode(file("${path.module}/service.yaml"))

  depends_on = [
    kubernetes_manifest.deployment
  ]
}

resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(file("${path.module}/ingress.yaml"))

  depends_on = [
    kubernetes_manifest.loadbalancer
  ]
}
