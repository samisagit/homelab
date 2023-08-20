provider "kubernetes" {
  config_path    = "~/.kubeconfig/k3s.yaml"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

module "node_expoerter" {
  source = "./node-exporter"

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

