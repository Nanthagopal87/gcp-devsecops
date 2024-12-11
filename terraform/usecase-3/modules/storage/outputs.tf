# modules/storage/outputs.tf

output "bucket_name_update" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.state_bucket.name
}
