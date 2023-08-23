provider "kubernetes" {
  config_path    = "~/.kubeconfig/k3s.yaml"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

module "node_exporter" {
  source = "./node-exporter"

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

module "prometheus" {
  source = "./prometheus"

  depends_on = [
    module.node_exporter
  ]
}

