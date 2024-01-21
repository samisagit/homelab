provider "kubernetes" {
  config_path    = "~/.kubeconfig/k3s.yaml"
}

resource "kubernetes_namespace" "pihole" {
  metadata {
    name = "pihole"
  }
}

resource "kubernetes_manifest" "pod" {
  manifest = yamldecode(file("${path.module}/pod.yaml"))

  depends_on = [
    kubernetes_namespace.pihole,
  ]
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.module}/service.yaml"))

  depends_on = [
    kubernetes_manifest.pod,
  ]
}
