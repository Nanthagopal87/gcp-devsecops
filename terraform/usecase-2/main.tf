terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }

  }

# Backend configuration
#   backend "gcs" {
#     bucket = "your-unique-bucket-name"  # Use the bucket created by the storage module
#     prefix = "terraform/state"
#   }

}

provider "google" {
  project = "devops-438202"
  region  = var.region
  zone    = var.zone
}


# # Optionally, reference the output from the module
output "storage_bucket_name" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.gcs_bucket.name
}

resource "google_storage_bucket" "gcs_bucket" {
  name                        = "nan-1987-aga-xxxx"  # Replace with a unique name
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

