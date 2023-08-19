Authenticate

```
make gcloud
```

Create terraform storage bucket

```
gsutil mb  gs://homelab-396412-tf-state
```

Enable versioning on bucket

```
gsutil versioning set on gs://homelab-396412-tf-state
```
