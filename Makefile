.PHONY: gcloud
gcloud:
	gcloud config set project homelab-396412
	gcloud auth application-default login --project homelab-396412

