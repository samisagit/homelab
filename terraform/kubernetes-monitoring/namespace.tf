provider "kubernetes" {
  config_path    = "~/.kubeconfig/k3s.yaml"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
