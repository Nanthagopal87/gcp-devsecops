terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }

  }

}

provider "google" {
  project = "devops-438202"
  region  = var.region
}


resource "google_compute_instance" "imported_instance" {
  name = "instance-20241208-145348"
  zone = var.zone
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20241112"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }

}

output "instance_internal_ip" {
  value = google_compute_instance.imported_instance.network_interface[0].network_ip
  description = "Internal IP address of the VM instance."
}

output "instance_external_ip" {
  value = google_compute_instance.imported_instance.network_interface[0].access_config[0].nat_ip
  description = "External IP address of the VM instance."
}




