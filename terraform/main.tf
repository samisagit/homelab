provider "google" {
	project = "homelab-396412"
}

module "metal-lb" {
  source = "./metal-lb"
}

module "kubernetes-monitoring" {
  source = "./kubernetes-monitoring"
}

module "home-assistant" {
  source = "./home-assistant"
}

module "pi-hole" {
  source = "./pi-hole"
}

