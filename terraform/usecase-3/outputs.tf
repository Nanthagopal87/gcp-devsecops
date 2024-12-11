output "hello-world" {
description = "Print a Hello World text output"
value = "Hello World"
}
output "demo" {
    value = "Demo"
}

output "storage_bucket_name" {
  description = "The name of the storage bucket"
  value       = module.storage.bucket_name
}