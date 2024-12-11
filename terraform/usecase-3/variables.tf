# variables.tf

# Declare a variable for the instance name
variable "instance_name" {
  description = "The name of the compute instance"
  type        = string
  default     = "my-instance"
}

# Declare a variable for the machine type
variable "machine_type" {
  description = "The machine type of the instance"
  type        = string
  default     = "e2-micro"
}

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