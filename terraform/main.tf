provider "google" {
	project = "homelab-396412"
}

module "kubernetes-monitoring" {
  source = "./kubernetes-monitoring"
}

module "home-assistant" {
  source = "./home-assistant"
}

