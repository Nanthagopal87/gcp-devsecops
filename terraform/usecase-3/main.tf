terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }

  }

# Backend configuration
  backend "gcs" {
    bucket = "your-unique-bucket-name"  # Use the bucket created by the storage module
    prefix = "terraform/state"
  }

}

provider "google" {
  project = "devops-438202"
  region  = var.region
  zone    = var.zone
}


# Module to create the storage bucket
module "storage" {
  source = "./modules/storage"
  bucket_name = "your-unique-bucket-name"  # Provide a name for the bucket here
}

# Optionally, reference the output from the module
# output "storage_bucket_name" {
#   description = "The name of the storage bucket"
#   value       = module.storage.bucket_name
# }

