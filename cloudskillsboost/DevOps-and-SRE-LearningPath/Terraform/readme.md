### Build Infrastructure with Terraform on Google Cloud: Challenge Lab 

### Referene URL: https://www.cloudskillsboost.google/paths/20/course_templates/636/labs/464836

### Overview

In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the course to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

To score 100% you must successfully complete all tasks within the time period!

This lab is recommended for students who have enrolled in the Build Infrastructure with Terraform on Google Cloud course. Are you ready for the challenge?

### Topics tested:

- Import existing infrastructure into your Terraform configuration.
- Build and reference your own Terraform modules.
- Add a remote backend to your configuration.
- Use and implement a module from the Terraform Registry.
- Re-provision, destroy, and update infrastructure.
- Test connectivity between the resources you've created.

### Challenge scenario

You are a cloud engineer intern for a new startup. For your first project, your new boss has tasked you with creating infrastructure in a quick and efficient manner and generating a mechanism to keep track of it for future reference and changes. You have been directed to use Terraform to complete the project.

For this project, you will use Terraform to create, deploy, and keep track of infrastructure on the startup's preferred provider, Google Cloud. You will also need to import some mismanaged instances into your configuration and fix them.

In this lab, you will use Terraform to import and create multiple VM instances, a VPC network with two subnetworks, and a firewall rule for the VPC to allow connections between the two instances. You will also create a Cloud Storage bucket to host your remote backend.

```
Note: At the end of every section, plan and apply your changes to allow your work to be successfully verified. Since we will be updating many terraform files in this lab make sure to use the correct file path and maintain the correct indentation
```

### Task 1. Create the configuration files

1. In Cloud Shell, create your Terraform configuration files and a directory structure that resembles the following:

```
main.tf
variables.tf
modules/
└── instances
    ├── instances.tf
    ├── outputs.tf
    └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf
```

2. Fill out the variables.tf files in the root directory and within the modules. Add three variables to each file: region, zone, and project_id. For their default values, use , , and your Google Cloud Project ID.

```
Note: You should use these variables anywhere applicable in your resource configurations.
```

3. Add the Terraform block and the Google Provider to the main.tf file. Verify the zone argument is added along with the project and region arguments in the Google Provider block.

4. Initialize Terraform.

### Task 2. Import infrastructure

1. In the Google Cloud Console, on the Navigation menu, click Compute Engine > VM Instances. Two instances named tf-instance-1 and tf-instance-2 have already been created for you.

```
Note: by clicking on one of the instances, you can find its Instance ID, boot disk image, and machine type. These are all necessary for writing the configurations correctly and importing them into Terraform. 
```
2. Import the existing instances into the instances module. To do this, you will need to follow these steps:

- First, add the module reference into the main.tf file then re-initialize Terraform.
- Next, write the resource configurations in the instances.tf file to match the pre-existing instances. 

    a) Name your instances tf-instance-1 and tf-instance-2.
    b) For the purposes of this lab, the resource       configuration     should be as minimal as possible. To accomplish this, you will only need to include the following additional arguments in your configuration: machine_type, boot_disk, network_interface, metadata_startup_script, and allow_stopping_for_update. For the last two arguments, use the following configuration as this will ensure you won't need to recreate it:

    ```
    metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
    allow_stopping_for_update = true    
    ```
    c) Once you have written the resource configurations within the module, use the terraform import command to import them into your instances module.




terraform import module.instances.google_compute_instance.tf-instance-1 5114815339757624168
terraform import module.instances.google_compute_instance.tf-instance-2 3113896050574285672




3) Apply your changes. Note that since you did not fill out all of the arguments in the entire configuration, the apply will update the instances in-place. This is fine for lab purposes, but in a production environment, you should make sure to fill out all of the arguments correctly before importing.

### Task 3. Configure a remote backend

1) Create a Cloud Storage bucket resource inside the storage module. For the bucket name, use . For the rest of the arguments, you can simply use:

    - location = "US"
    - force_destroy = true
    - uniform_bucket_level_access = true

```
Note: You can optionally add output values inside of the outputs.tf file. 
```

```
terraform {
  backend "gcs" {
    bucket  = "# REPLACE WITH YOUR BUCKET NAME"
    prefix  = "terraform/state"
  }
}
```

```
Initialize your backend again, this time to automatically migrate the state:

terraform init -migrate-state
```


2) Add the module reference to the main.tf file. Initialize the module and apply the changes to create the bucket using Terraform.

3) Configure this storage bucket as the remote backend inside the main.tf file. Be sure to use the prefix terraform/state so it can be graded successfully.

4) If you've written the configuration correctly, upon init, Terraform will ask whether you want to copy the existing state data to the new backend. Type yes at the prompt.

### Task 4. Modify and update infrastructure

1) Navigate to the instances module and modify the tf-instance-1 resource to use an e2-standard-2 machine type.

2) Modify the tf-instance-2 resource to use an e2-standard-2 machine type.

3) Add a third instance resource and name it . For this third resource, use an e2-standard-2 machine type. Make sure to change the machine type to e2-standard-2 to all the three instances.



4) Initialize Terraform and apply your changes.

```
Note: Optionally, you can add output values from these resources in the outputs.tf file within the module.
```



### Task 5. Destroy resources

1) Destroy the third instance by removing the resource from the configuration file. After removing it, initialize terraform and apply the changes.




### Appendix - Terraform Commands
1. terraform init      => 
2. terraform plan      => 
3. terraform apply     => 
4. terraform show      => Examine your state file:
5. terraform refresh   => Update the state file

### Appendix - Terraform Advance Commands
1. terraform init -migrate-state => Re-Initilaize the backend(local/remote) again
2. terraform init -reconfigure


```
Local Backend
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
```
```
Remote Backend
terraform {
  backend "gcs" {
    bucket  = "# REPLACE WITH YOUR BUCKET NAME"
    prefix  = "terraform/state"
  }
}
```


### Appendix - Create resource for Bucket

```
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "qwiklabs-gcp-03-c26136e27648"
  location    = "US"
  uniform_bucket_level_access = true
  force_destroy = true
}
```










