### Roles Added

```
export SERVICE_ACCOUNT_NAME="packer-builder"
export SERVICE_ACCOUNT_DISPLAY_NAME="Packer Build Service Account"
```

1. gcloud projects add-iam-policy-binding ${PROJECT_ID}   --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}"   --role="roles/compute.instanceAdmin.v1"
2. gcloud projects add-iam-policy-binding ${PROJECT_ID}   --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}"   --role="roles/iam.serviceAccountUser"
3. gcloud projects add-iam-policy-binding ${PROJECT_ID}   --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}"   --role="roles/compute.osLogin"
4. gcloud iam service-accounts add-iam-policy-binding ${PACKER_SA_EMAIL}   --role="roles/iam.serviceAccountTokenCreator"   --member="user:${USER_EMAIL}"
5. gcloud projects add-iam-policy-binding ${PROJECT_ID}     --member="serviceAccount:${PACKER_SA_EMAIL}"     --role="roles/serviceusage.serviceUsageConsumer"

```
export PACKER_SA_EMAIL="packer-builder@prj-gke-cnch-meetup-2025-05-19.iam.gserviceaccount.com"
export USER_EMAIL=$(gcloud config get-value account)
ssh-keygen -t rsa -f ./dummy_key -N ""
gcloud compute os-login ssh-keys add   --key-file=./dummy_key.pub   --impersonate-service-account="packer-builder@prj-gke-cnch-meetup-2025-05-19.iam.gserviceaccount.com"
gcloud services enable iamcredentials.googleapis.com --project=prj-gke-cnch-meetup-2025-05-19
```

```
packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

# source "googlecompute" "my-instance" {
#   project = "my-project"
#   zone    = "us-central1-a"
# }

source "googlecompute" "basic-example" {
  project_id   = "prj-gke-cnch-meetup-2025-05-19"
  source_image = "ubuntu-2404-noble-amd64-v20250819"
  #ssh_username = "packer"
  zone         = "asia-south1-a"
  image_name   = "packer-oslogin-example-{{timestamp}}"

  // Specify the service account for Packer to use
  service_account_email = "packer-builder@prj-gke-cnch-meetup-2025-05-19.iam.gserviceaccount.com"

# Tell Packer to ACT AS this service account for all API calls
  impersonate_service_account = "packer-builder@prj-gke-cnch-meetup-2025-05-19.iam.gserviceaccount.com"

  # Provide the expected OS Login username for the service account.
  ssh_username = "packer-builder_prj-gke-cnch-meetup-2025-05-19_iam_gserviceaccount_com"

  // Instruct Packer to use the OS Login API for SSH
  use_os_login = true

  // Set instance metadata to enable OS Login on the VM
  metadata = {
    enable-oslogin = true
  }
}

build {
  sources = ["sources.googlecompute.basic-example"]
  #sources = ["source.googlecompute.os-login-example"]
  provisioner "shell" {
    inline = [
      #"echo 'Running a shell command as user: {{build `User`}}'",
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}
```
