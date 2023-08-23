resource "kubernetes_manifest" "role" {
  manifest = yamldecode(file("${path.module}/role.yaml"))
}

resource "kubernetes_manifest" "role_binding" {
  manifest = yamldecode(file("${path.module}/role-binding.yaml"))

  depends_on = [
    kubernetes_manifest.role
  ]
}

resource "kubernetes_manifest" "service_account" {
  manifest = yamldecode(file("${path.module}/service-account.yaml"))
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/deployment.yaml"))

  depends_on = [
    kubernetes_manifest.role_binding,
    kubernetes_manifest.service_account
  ]
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.module}/service.yaml"))

  depends_on = [
    kubernetes_manifest.deployment
  ]
}
