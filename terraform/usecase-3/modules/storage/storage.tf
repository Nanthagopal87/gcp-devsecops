# modules/storage/main.tf

resource "google_storage_bucket" "state_bucket" {
  name                        = var.bucket_name  # Replace with a unique name
  location                    = "asia"
  force_destroy               = true
  uniform_bucket_level_access = true
}

# Optionally, define outputs to return information about the bucket
output "bucket_name" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.state_bucket.name
}
