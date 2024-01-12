provider "kubernetes" {
  config_path    = "~/.kubeconfig/k3s.yaml"
}

# source from 
# https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml

resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("${path.module}/namespace.yaml")) 
}

resource "kubernetes_manifest" "addr_pool" {
  manifest = yamldecode(file("${path.module}/addr-pool.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
     "spec.conversion.webhook.clientConfig.caBundle",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "bdf_profiles" {
  manifest = yamldecode(file("${path.module}/bdf-profiles.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]


  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "bgp_adverts" {
  manifest = yamldecode(file("${path.module}/bgp-adverts.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]


  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "bgp_peers" {
  manifest = yamldecode(file("${path.module}/bgp-peers.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
     "spec.conversion.webhook.clientConfig.caBundle",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "communities" {
  manifest = yamldecode(file("${path.module}/communities.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "ip_addr_pool" {
  manifest = yamldecode(file("${path.module}/ip-addr-pool.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "l2_adverts" {
  manifest = yamldecode(file("${path.module}/l2-adverts.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "sa_controller" {
  manifest = yamldecode(file("${path.module}/sa-controller.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "sa_speaker" {
  manifest = yamldecode(file("${path.module}/sa-speaker.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "role_controller" {
  manifest = yamldecode(file("${path.module}/role-controller.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.bgp_adverts,
    kubernetes_manifest.bgp_peers,
    kubernetes_manifest.communities,
    kubernetes_manifest.addr_pool,
    kubernetes_manifest.l2_adverts,
    kubernetes_manifest.bdf_profiles,
    kubernetes_manifest.ip_addr_pool
  ]
}

resource "kubernetes_manifest" "role_listener" {
  manifest = yamldecode(file("${path.module}/role-listener.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.bgp_adverts,
    kubernetes_manifest.bgp_peers,
    kubernetes_manifest.communities,
    kubernetes_manifest.addr_pool,
    kubernetes_manifest.l2_adverts,
    kubernetes_manifest.bdf_profiles,
    kubernetes_manifest.ip_addr_pool
  ]
}

resource "kubernetes_manifest" "cluster_role_controller" {
  manifest = yamldecode(file("${path.module}/cluster-role-controller.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.bgp_adverts,
    kubernetes_manifest.bgp_peers,
    kubernetes_manifest.communities,
    kubernetes_manifest.addr_pool,
    kubernetes_manifest.l2_adverts,
    kubernetes_manifest.bdf_profiles,
    kubernetes_manifest.ip_addr_pool
  ]
}

resource "kubernetes_manifest" "cluster_role_speaker" {
  manifest = yamldecode(file("${path.module}/cluster-role-speaker.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.bgp_adverts,
    kubernetes_manifest.bgp_peers,
    kubernetes_manifest.communities,
    kubernetes_manifest.addr_pool,
    kubernetes_manifest.l2_adverts,
    kubernetes_manifest.bdf_profiles,
    kubernetes_manifest.ip_addr_pool
  ]
}

resource "kubernetes_manifest" "rb_controller" {
  manifest = yamldecode(file("${path.module}/rb-controller.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.role_controller,
    kubernetes_manifest.sa_controller,
  ]
}

resource "kubernetes_manifest" "rb_listener" {
  manifest = yamldecode(file("${path.module}/rb-listener.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.role_listener,
    kubernetes_manifest.sa_speaker,
  ]
}

resource "kubernetes_manifest" "crb_controller" {
  manifest = yamldecode(file("${path.module}/crb-controller.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.cluster_role_controller,
    kubernetes_manifest.sa_controller,
  ]
}

resource "kubernetes_manifest" "crb_speaker" {
  manifest = yamldecode(file("${path.module}/crb-speaker.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.cluster_role_speaker,
    kubernetes_manifest.sa_speaker,
  ]
}

resource "kubernetes_manifest" "cm_excludes" {
  manifest = yamldecode(file("${path.module}/cm-excludes.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "secret_webhook_server_cert" {
  manifest = yamldecode(file("${path.module}/secret-webhook-server-cert.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
  ]
}

resource "kubernetes_manifest" "service_webhook" {
  manifest = yamldecode(file("${path.module}/service-webhook.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.secret_webhook_server_cert,
  ]
}

resource "kubernetes_manifest" "deployment_controller" {
  manifest = yamldecode(file("${path.module}/deployment-controller.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.sa_controller,
    kubernetes_manifest.secret_webhook_server_cert,
  ]
}

resource "kubernetes_manifest" "daemonset_speaker" {
  manifest = yamldecode(file("${path.module}/daemonset-speaker.yaml")) 

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.sa_speaker,
    kubernetes_manifest.secret_webhook_server_cert,
    kubernetes_manifest.cm_excludes
  ]
}

resource "kubernetes_manifest" "validating_webbook" {
  manifest = yamldecode(file("${path.module}/validating-webhook.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.bgp_adverts,
    kubernetes_manifest.bgp_peers,
    kubernetes_manifest.communities,
    kubernetes_manifest.addr_pool,
    kubernetes_manifest.l2_adverts,
    kubernetes_manifest.bdf_profiles,
    kubernetes_manifest.ip_addr_pool
  ]
}

resource "kubernetes_manifest" "pool_range" {
  manifest = yamldecode(file("${path.module}/pool-range.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]

  depends_on = [
    kubernetes_manifest.namespace,
    kubernetes_manifest.addr_pool,
    kubernetes_manifest.ip_addr_pool,
    kubernetes_manifest.service_webhook,
  ]
}

resource "kubernetes_manifest" "l2_advert" {
  manifest = yamldecode(file("${path.module}/l2-advert.yaml")) 

   computed_fields = [
     "metadata.labels",
     "metadata.annotations",
     "metadata.creationTimestamp",
   ]

  depends_on = [
    kubernetes_manifest.pool_range,
  ]
}

