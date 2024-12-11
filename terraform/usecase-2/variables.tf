
# Declare a variable for the zone
variable "zone" {
  description = "The zone to deploy the instance in"
  type        = string
  default     = "us-central1-a"
}

# Declare a variable for the region
variable "region" {
  description = "The zone to deploy the instance in"
  type        = string
  default     = "us-central1"
}