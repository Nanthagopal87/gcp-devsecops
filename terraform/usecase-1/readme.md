I have create a VM Instance in GCP named instance-20241208-145348  in the zone us-central1-b through GCP Console. I need to import the vm-instance in tf code undermain.tf.

To import the existing VM instance created in GCP into a Terraform configuration, you can follow these steps:

### 1. Write the Terraform Configuration

```
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

```


### 2. Check Terraform State

Initially there will not state file found.

```
terraform state list
```

```
No state file was found!

State management commands require a state file. Run this command
in a directory where Terraform has been run or use the -state flag
to point the command to a specific state location.

```
```
terraform show
```
```
No state.
```

### 3. Run Terraform Import Command

Use the `terraform import` command to import the VM instance into the state file. Run this command in the same directory as your `main.tf`:

```
terraform import google_compute_instance.imported_instance projects/devops-438202/zones/us-central1-b/instances/instance-20241208-145348

```

```
google_compute_instance.imported_instance: Importing from ID "projects/devops-438202/zones/us-central1-b/instances/instance-20241208-145348"...
google_compute_instance.imported_instance: Import prepared!
  Prepared google_compute_instance for import
google_compute_instance.imported_instance: Refreshing state... [id=projects/devops-438202/zones/us-central1-b/instances/instance-20241208-145348]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### 4. Check Terraform State

After importing, Terraform will add the resource to its state file. To verify, run:

```
terraform state list
```
Output:
```
google_compute_instance.imported_instance
```

### 5. Update the Configuration

After the import, Terraform doesn't automatically update your main.tf file. You need to manually adjust the configuration to match the instance's current properties. To get the current resource attributes, run:

```
terraform show
```

Output:
```
# google_compute_instance.imported_instance:
resource "google_compute_instance" "imported_instance" {
    can_ip_forward       = false
    cpu_platform         = "Intel Broadwell"
    current_status       = "RUNNING"
    deletion_protection  = false
    description          = null
    effective_labels     = {}
    enable_display       = false
    hostname             = null
    id                   = "projects/devops-438202/zones/us-central1-b/instances/instance-20241208-145348"
    instance_id          = "4038709196390665578"
    label_fingerprint    = "42WmSpB8rSM="
    labels               = {}
    machine_type         = "e2-medium"
    metadata             = {}
    metadata_fingerprint = "X9lzP-VQdm4="
    min_cpu_platform     = null
    name                 = "instance-20241208-145348"
    project              = "devops-438202"
    resource_policies    = []
    self_link            = "https://www.googleapis.com/compute/v1/projects/devops-438202/zones/us-central1-b/instances/instance-20241208-145348"
    tags                 = []
    tags_fingerprint     = "42WmSpB8rSM="
    terraform_labels     = {}
    zone                 = "us-central1-b"

    boot_disk {
        auto_delete                = true
        device_name                = "instance-20241208-145348"
        disk_encryption_key_raw    = (sensitive value)
        disk_encryption_key_sha256 = null
        interface                  = null
        kms_key_self_link          = null
        mode                       = "READ_WRITE"
        source                     = "https://www.googleapis.com/compute/v1/projects/devops-438202/zones/us-central1-b/disks/instance-20241208-145348"

        initialize_params {
            enable_confidential_compute = false
            image                       = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-12-bookworm-v20241112"
            labels                      = {}
            provisioned_iops            = 0
            provisioned_throughput      = 0
            resource_manager_tags       = {}
            resource_policies           = []
            size                        = 10
            storage_pool                = null
            type                        = "pd-balanced"
        }
    }

    confidential_instance_config {
        confidential_instance_type  = null
        enable_confidential_compute = false
    }

    network_interface {
        internal_ipv6_prefix_length = 0
        ipv6_access_type            = null
        ipv6_address                = null
        name                        = "nic0"
        network                     = "https://www.googleapis.com/compute/v1/projects/devops-438202/global/networks/default"
        network_ip                  = "10.128.0.2"
        nic_type                    = null
        queue_count                 = 0
        stack_type                  = "IPV4_ONLY"
        subnetwork                  = "https://www.googleapis.com/compute/v1/projects/devops-438202/regions/us-central1/subnetworks/default"
        subnetwork_project          = "devops-438202"

        access_config {
            nat_ip                 = "35.224.76.154"
            network_tier           = "PREMIUM"
            public_ptr_domain_name = null
        }
    }

    reservation_affinity {
        type = "ANY_RESERVATION"
    }

    scheduling {
        automatic_restart           = true
        instance_termination_action = null
        min_node_cpus               = 0
        on_host_maintenance         = "MIGRATE"
        preemptible                 = false
        provisioning_model          = "STANDARD"
    }

    service_account {
        email  = "11512457482-compute@developer.gserviceaccount.com"
        scopes = [
            "https://www.googleapis.com/auth/devstorage.read_only",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring.write",
            "https://www.googleapis.com/auth/service.management.readonly",
            "https://www.googleapis.com/auth/servicecontrol",
            "https://www.googleapis.com/auth/trace.append",
        ]
    }

    shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
}
```

### 6. Reconcile with Existing Configuration

Ensure the 'main.tf' reflects the imported instance's attributes. If needed, update the resource configuration.

### 7. Get Internal and External IP

Declare the output variable in main.tf as follows

```
output "instance_internal_ip" {
  value = google_compute_instance.imported_instance.network_interface[0].network_ip
  description = "Internal IP address of the VM instance."
}

output "instance_external_ip" {
  value = google_compute_instance.imported_instance.network_interface[0].access_config[0].nat_ip
  description = "External IP address of the VM instance."
}

```

Explanation

- network_interface[0].network_ip: Retrieves the internal IP of the first network interface.
- network_interface[0].access_config[0].nat_ip: Retrieves the external IP (NAT IP) of the first access configuration on the first network interface.

Run Terraform Commands

a) To apply the changes and output the IPs:
```
terraform apply
```

Terraform will display the outputs after applying the configuration:

```
google_compute_instance.imported_instance: Refreshing state... [id=projects/devops-438202/zones/us-central1-b/instances/instance-20241208-145348]

Changes to Outputs:
  + instance_external_ip = "34.133.216.176"
  + instance_internal_ip = "10.128.0.3"

You can apply this plan to save these new output values to the Terraform state, without changing any real
infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

instance_external_ip = "34.133.216.176"
instance_internal_ip = "10.128.0.3"

```

### 8. Verify Output variables vi terraform output commands

```
terraform output
```

Output:
```
instance_external_ip = "34.133.216.176"
instance_internal_ip = "10.128.0.3
```
