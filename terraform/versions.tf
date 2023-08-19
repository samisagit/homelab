terraform {
	required_version = "~>1.5.5"
	backend "gcs" {
		bucket  = "homelab-396412-tf-state"
    		prefix  = "terraform/state"
	}
	required_providers {
		google = {
			source = "hashicorp/google"
			version = "~>4.78.0"
		}
		kubernetes = {
			source = "hashicorp/kubernetes"
			version = "~>2.23.0"
		}
	}
}
