### 1. You are running an application on an autoscaled managed instance group in a single zone. This is a high-priority workload, and you need to test changes to the managed instance group before any changes are finalized. You need to ensure that there is sufficient capacity to serve any requests while you are testing the changes. What should you do?

- A. Configure autoscaling to "Only scale out" while you make changes.
- B. Change the managed instance group to run in multiple zones.
- C. Temporarily disable autoscaling while you make changes.
- D. Enable predictive autoscaling.


Ans: A

```
Feedback
A: Correct. Configuring autoscaling to “Only scale out” ensures that capacity doesn’t drop. If there are more requests, the managed instance group scales out.
B: Incorrect. Changing the managed instance group to run in multiple zones does not guarantee that the changes being tested don't impact capacity.
C: Incorrect. Disabling autoscaling only supports the current capacity, which might not be sufficient during the period you make the changes.
D: Incorrect. Predictive autoscaling does not guarantee that your application will have sufficient capacity. While you make changes to the existing configuration, the number of actual requests might spike or the changes that you make might affect the predictive autoscaling, which might result in insufficient capacity.
```

```
Reference URL:
https://cloud.google.com/compute/docs/autoscaler/managing-autoscalers
```

### 2. Your company requires that all employees within a team use a consistent, templated development environment, which includes popular integrated development environments (IDEs). You need to maintain security patches and updates to the development environments. You also need to identify a reliable, Google-recommended way to ensure that all developers within each team use a consistent development environment. What should you do?

- A. Create daily Compute Engine snapshots of a 'golden' machine with all security patches and make the snapshots available for developers to update their own machines.
- B. Create a checklist of all software updates with update scripts and allow developers to update their own machines.
- C. Create an image with all up-to-date dependencies and install the image on laptops for the developers to use.
- D. Create Cloud Workstations configurations specific to each team.

Ans: D

```
Feedback
A: Incorrect. Relying on the developers to make the update themselves might result in inconsistencies.
B: Incorrect. Relying on the developers to make the update themselves might result in inconsistencies.
C: Incorrect. Critical patches and updates cannot be reliably rolled out to all developers’ laptops.
D: Correct. Cloud Workstations configurations provide templates for the creation of consistent workstations across multiple developers, and specify configuration settings such as machine type, disk size, tools, and pre-installed libraries. Any operations performed on a workstation configuration, such as changing the machine type or container image, reflect on each workstation the next time the workstation starts up.
```

```
Reference URL:
https://cloud.google.com/workstations/docs/overview
https://cloud.google.com/workstations/docs/create-configuration
https://cloud.google.com/workstations/docs/create-workstation
https://www.youtube.com/watch?v=E1cblFqb8nk
https://www.youtube.com/watch?v=C6Dpmujxp9Q
```

### 3. Your team has received information about a security patch that addresses a critical vulnerability. The patch needs to be applied to Compute Engine instances that serve millions of customers across the world. You need to roll out the security patch quickly, while minimizing cost and impact on end customers. What should you do?

- A. Perform a canary rollout of the security patch with a short duration.
- B. Simultaneously update of all the Compute Engine instances across the world.
- C. Perform a 24 hour-rolling update to occur during each region’s overnight hours.
- D. Perform an A/B rollout, and create a copy of all the instances in Compute Engine. Apply the security patch, and then switch users.

Ans: A

```
Feedback
A: Correct. A canary rollout with a short duration lets you quickly and cost-effectively identify any side effects of the security patch before you expand the rollout.
B: Incorrect. If the security patch has any adverse or unexpected implications, all users could be affected simultaneously.
C: Incorrect. This is not an effective strategy, because critical systems in regions that currently serve customers in the day time could be an attack vector.
D: Incorrect. This is not cost-effective and would also be time consuming to create a copy of all the services and machines.
```

```
Reference URL:
 
https://sre.google/workbook/canarying-releases/
 
https://cloud.google.com/blog/products/gcp/how-release-canaries-can-save-your-bacon-cre-life-lessons

```


### 4. You have an application deployed on Cloud Run with users around the world. You need to configure Cloud Run to route all users to their nearest region so that request responses have low latency. What should you do?

- A. Deploy the application to any one region, and serve the application at a global anycast IP address behind a global external HTTP(S) load balancer.
- B. Deploy the application to each region, and serve the application at a global anycast IP address behind a global external HTTP(S) load balancer.
- C. Deploy the application to one region per continent and serve the application by using a regional external HTTP(S) load balancer in each region and attach the same global IP address to all the regional load balancers.
- D. Deploy the application to any one region, and configure Google Cloud Armor in the frontend to allow traffic from all IP addresses.


Ans: B

```
Feedback
A: Incorrect. All requests would have to be routed to the single Cloud Run instance, which causes latency and congestion.
B: Correct. The Cloud Run instance needs to be available in the regions closest to where the users are located. The global external HTTP(S) load balancer can be the endpoint for the anycast IP address which will route the request to the closest region with the Cloud Run instance running.C: Incorrect. This is not the most efficient solution. You will have to set up multiple load balancers which are complex in configuration and not unified for the customer.
D: Incorrect. Google Cloud Armor allow rules will allow traffic from all over the world, but responses will have higher latency when served from one region.
 
https://cloud.google.com/run/docs/multiple-regions
 
https://cloud.google.com/run/docs/container-contract
```

### 5. Your company is running a legacy database in Google Kubernetes Engine (GKE) that does not respond well to Pod evictions and rescheduling. Your company cannot afford a disruption to the running database. You need to choose a GKE maintenance strategy to use. What should you do?

- A. Configure the GKE maintenance channel to “Stable”.
- B. Configure a node pool upgrade strategy with max-surge-upgrade set to 0.
- C. Create a "PodDisruptionBudget" object and specify maxUnavailable as 100%.
- D. Configure a maintenance exclusion window with a scope of “No minor or node upgrades”.

Ans: D

```
Feedback
A: Incorrect. If you choose the stable release channel alone, all updates will be performed on the stable release schedule, which can cause Pod evictions.
B: Incorrect. A surge upgrade strategy will not restrict maintenance updates, and that could cause pod evictions.
C. Incorrect. A ”PodDisruptionBudget” of 100% will not stop the maintenance upgrades,therefore, it could cause Pod evictions.
D: Correct. The "No minor or node upgrades" setting prevents node pool disruption and avoids any eviction and rescheduling of your workloads because of node upgrades.
 
https://cloud.google.com/kubernetes-engine/docs/concepts/maintenance-windows-and-exclusions
 
https://cloud.google.com/kubernetes-engine/docs/concepts/maintenance-windows-and-exclusions#scope_of_maintenance_to_exclude
 
https://cloud.google.com/kubernetes-engine/docs/concepts/release-channels
 
https://cloud.google.com/kubernetes-engine/docs/best-practices/upgrading-clusters
 
https://www.youtube.com/watch?v=eqJQTANI_RI
```

### 6. Your organization uses Cloud Run to deploy a containerized application. A new version of the application recently passed internal tests and now needs to be tested in production. You need to implement a configuration so that beta testers can test the application before you roll out the application to end users. What should you do?

- A. Deploy the Cloud Run application to production, and direct 1% of traffic to the application.
- B. Configure Google Cloud Armor to reject requests that originate from IP addresses outside of the testing team.
- C. Deploy the container to a private VM instance on Compute Engine, and enable access for the testing team only.
- D. Deploy the Cloud Run application to production with a revision tag and the “--no-traffic“ option, and share the URL with the testing team.

Ans: D

```
Feedback
A: Incorrect. End users might fall within the 1% and access the application.
B: Incorrect. Maintaining a list of IP addresses that the testing team uses is cumbersome and not reliable.
C: Incorrect. This deployment environment is different from the production environment, and more effort is required to reliably roll the application out to end users.
D: Correct. Assigning a tag lets you access the revision at a specific URL without serving traffic.
 
https://cloud.google.com/run/docs/rollouts-rollbacks-traffic-migration#deploy-with-tags
 
https://cloud.google.com/run/docs/rollouts-rollbacks-traffic-migration#tags
 
https://www.youtube.com/watch?v=pi0Ss24bqL4
```

### 7. You work for a small company that uses open source Java packages as part of the CI/CD pipeline in Cloud Build. Your security team is concerned that vulnerabilities in the open source packages could be exploited. You need to implement a cost-effective solution to ensure that your production system dependencies are secure. What should you do?

- A. Pull only the latest versions of GitHub packages into your Cloud Build pipeline.
- B. Pull the packages into Cloud Build from Assured Open Source Software (Assured OSS) packages.
- C. Pull the packages into Cloud Source Repositories, and have the security team validate open source packages.
- D. Pull the open source packages locally, use Cloud Build to scan all packages, and delete any flagged packages.

Ans:B

```
Feedback
A: Incorrect. Pulling the latest open source versions might have bugs and vulnerabilities that have not been discovered yet.
B: Correct. The Assured OSS Packages are built in Google Cloud’s own secured pipelines and are regularly scanned, analyzed, and fuzz tested for vulnerabilities.
C: Incorrect. This is not the most cost-effective solution because Google Cloud already offers open source packages that have been curated and validated.
D: Incorrect. Scanning all packages in each build is not cost-effective. Also, builds will not be successful if you delete essential packages.
 
https://cloud.google.com/assured-open-source-software/docs/remoterepositoryaccess
 
https://cloud.google.com/assured-open-source-software/docs/javaaccess
 
https://cloud.google.com/software-supply-chain-security/docs/practices
```

### 8. You have a custom application that runs on a few Compute Engine instances. The servers occasionally experience spikes in utilization up to 90% but then quickly return to about 50% utilization. You have alerts set up to notify you to take action when your server utilization is above 80%. You are receiving too many notifications, and need to update your alerts to only notify you when there is consistently high utilization for at least 5 minutes. What should you do?

- A. Send notifications to a Cloud Run application that identifies utilization above 80% for 5 minutes.
- B. Create an alert from a log-based metric with a rolling window of 5 minutes and a metric absence condition.
- C. Create an alert from a log-based metric with a rolling window of 5 minutes and a mean threshold of 80%.
- D. Create an alert from a log-based metric with a rolling window of 5 minutes and a mean threshold of 90%.

Ans: C

```
Feedback
A: Incorrect. It is a considerable effort to build a custom solution to filter and analyze alerts.
B: Incorrect. The absence of the metric is not indicative of high utilization.
C: Correct. You need to be notified only when utilization is consistently high over a period of 5 minutes.
D: Incorrect. A notification based on 90% reduces the number of notifications but it does not trigger for high utilization between 80% and 90%.
 
https://cloud.google.com/logging/docs/logs-based-metrics
 
https://cloud.google.com/logging/docs/logs-based-metrics/charts-and-alerts
 
https://cloud.google.com/monitoring/alerts/types-of-conditions#metric-threshold
 
https://www.youtube.com/watch?v=D0YKWvuJgwg
 
https://www.youtube.com/watch?v=4RgJjx4IxMs
 
https://www.cloudskillsboost.google/focuses/619?parent=catalog
```

### 9. Your organization has many projects with production environments that have to be migrated to Google Cloud. You manage organizational policies centrally. You want to follow Google-recommended practices to roll out policy changes in the resource hierarchy. What should you do?
A. Create an organization to experiment with policy changes and a separate one for the production environments.
B. Create an organization for the production environments, and then apply policy changes gradually across this organization going down the hierarchy.
C. Create an organization for the production environments and a staging environment for pre-release checks. Perform all experiments in the staging environment.
D. Create an organization for the production environments, and then apply policy changes gradually going up the hierarchy starting from production projects in this organization.

Ans: A

```
Feedback
A: Correct. Any change in the resource hierarchy the policy applies to might have far-reaching and unintended consequences. To mitigate this risk, it is a recommended practice to test policy changes in a separate organization before you apply them in your main organization.
B: Incorrect. Many policies are applicable to the entire organization. Policy changes to the existing production organization might have far-reaching and unintended consequences.
C: Incorrect. Staging environments should reflect the production environment configuration. It's not recommended to change configurations or make the security configurations easier just to do experiments.
D: Incorrect. Policy changes to the existing production organization could have unintended consequences.
 
https://cloud.google.com/architecture/identity/best-practices-for-planning#use_a_separate_organization_for_experimenting
```

### 10. Your organization runs a fault-tolerant, batch processing application that processes very large amounts of data. The computations are spread over hundreds of VMs for parallel processing. You need to implement a cost-effective solution to perform the data processing at scale. What should you do?

A. Allocate Spot VMs to process data.
B. Allocate sole tenant machines to process data.
C. Create a managed instance group with autohealing enabled.
D. Create a managed instance group with accelerator-optimized VMs and autoscaling enabled.

Ans: A

```
Feedback
A: Correct. Spot VMs are a cost-effective solution for fault-tolerant processing in Compute Engine in comparison to regular VMs.
B: Incorrect. Sole tenant VMs are not the most cost-effective solution.
C: Incorrect. Autohealing will automatically repair unhealthy VMs, but it won't be the most cost-effective solution with a regular VM configuration.
D: Incorrect. Autoscaling allocates VMs as required, but it’s not the most cost-effective solution with an accelerator-optimized VM configuration.
 
https://cloud.google.com/compute/docs/instances/spot
 
https://cloud.google.com/compute/docs/instances/create-use-spot
```

### 11. Your security team requires you to create a replica of the production infrastructure for testing in case of a suspected system breach. You want to follow Google-recommended practices to quickly deliver replicas to the security team. What should you do?

A. Run Cloud Asset Inventory, list the resources in the production environment, and recreate the resources by using the Google Cloud console.
B. Run a scan with the Security Command Center, list the resources in the production environment, and recreate the resources by using the gcloud CLI.
C. Create a Terraform script to recreate your production environment and rerun the script as required.
D. Create bash shell scripts to recreate your production environment, and rerun the scripts as required.

Ans: C

```
Feedback
A: Incorrect. Repeatedly recreating entire technical environments manually through the console is not Google-recommended.
B: Incorrect. Resources listed in the Security Command Center will not have sufficient information to recreate them. Also, repeatedly recreating entire technical environments manually with the gcloud command line tool is not a Google-recommended practice.
C: Correct. Infrastructure as code is the recommended way to manage repeatability technical environments. Terraform is the Google-recommended tool for infrastructure as code.
D: Incorrect. Repeatedly recreating entire technical environments manually with bash scripts tool is not a Google-recommended practice.
 
https://cloud.google.com/blog/products/devops-sre/want-repeatable-scale-adopt-infrastructure-as-code-on-gcp
 
https://cloud.google.com/docs/terraform
 
https://cloud.google.com/docs/terraform/best-practices-for-terraform
```

### 12. You need to investigate some network traffic to a VM in your Google Cloud VPC. You have VPC Flow Logs enabled. However, when you filter for the traffic information, the network traffic is not available. You need to identify the issue. What should you do?

A. Determine whether you are filtering by TCP protocol.
B. Determine whether you need to lower the sample rate.
C. Determine whether the traffic you are filtering for has very low volume.
D. Determine whether the traffic is flowing from a VM outside your VPC to your VM inside the VPC.

Ans: C

```
Feedback
A: Incorrect. This is not the issue. TCP is supported by VPC Flow Logs, and it should be available in the data captured.
B: Incorrect. Lowering the sample rate captures less logs. A sample rate of 1.0 (100%) means that all entries are kept.
C: Correct. Very low traffic volume could be the issue. Logs are sampled, so some packets in low volume flows might be missed.
D: Incorrect. This is not the issue. VPC Flow Logs can capture traffic coming from external servers into VMs in a Google Cloud VPC.
 
https://cloud.google.com/vpc/docs/using-flow-logs#some_flows_are_missing
 
https://cloud.google.com/vpc/docs/using-flow-logs
```

### 13. Your colleague noticed an increasing amount of suspicious traffic entering your project's virtual private cloud (VPC) while on call at night. Your colleague updated the configuration of Cloud Armor to stop the traffic that originates from certain IP addresses. The change reduced the network traffic, but there were escalations from an affected customer, which resulted in penalties for your company. Your team wants to use Google-recommended practices to prevent a recurrence. What should you do?
A. Institute a policy that requires that all changes are made during day time when there are additional people to review changes.
B. Create a process that requires a second level of review for this colleague for any changes.
C. Identify core technical issues, and document the learnings for use by the entire team.
D. Create an incident report for your colleague and escalate to senior management.

Ans: C

```
Feedback
A: Incorrect. This is not a viable policy, because configurations would need to be changed at any time. In this case, a potential cyber attack happened at night. The team needs processes that can be applied any time.
B: Incorrect. This approach does not follow recommended practices because it focuses specifically on an individual instead of improving the process for everybody.
C: Correct. This solution takes the DevOps/SRE approach of objectively identifying the technical issue without blaming the individual.
D: Incorrect. This approach does not follow recommended practices, because it focuses on blaming the individual instead of improving the process.
 
https://sre.google/workbook/postmortem-culture/
 
https://cloud.google.com/blog/products/gcp/fearless-shared-postmortems-cre-life-lessons
```

### 14. You are creating a software delivery pipeline for your company. New application features delivered by the development team must be deployed by using Cloud Deploy in testing, staging, and then production. The corresponding deployment targets are already defined. You instantiated the delivery pipeline by creating a release. You need to perform the deployments while following Google-recommended practices. What should you do?

A. Create an image for each stage in Artifact Registry and apply each image in the corresponding stage.
B. Configure Binary Authorization to approve the deployment before each stage.
C. Create an independent delivery pipeline for each of the delivery stages.
D. Promote the initial release through the staging and production stages.

Ans: D

```
Feedback
A: Incorrect. Creating separate images for each deployment is not the recommended approach.
B: Incorrect. Binary authorization provides a security check prior to deployment. However, it is not a solution for deployment itself.
C: Incorrect. Creating separate delivery pipelines in Cloud Deploy is not recommended for this use case. The recommended approach is to promote the deployment to the next stage.
D: Correct. Instantiating the release will deploy to the first target. You can promote it to go to staging and then again to go to production.
 
https://cloud.google.com/deploy/docs/deploy-app-run
 
https://cloud.google.com/deploy/docs/promote-release
```

### 15. Your organization runs many builds on Google Cloud daily. You need to ensure that VMs do not have public IP addresses and secure the build machines against data exfiltration. You want to use Google-recommended practices to create a customizable, easily-managed solution for your builds that can scale to the demands of your organization. What should you do?

A. Implement private pools in Cloud Build with VPC service control.
B. Run and configure the builds in Cloud Build in a default pool for required privacy.
C. Create a build environment by using Compute Engine VMs in a custom VPC. Use Jenkins to run the builds.
D. Create a build environment by using Compute Engine Spot VM instances in a custom VPC. Use Jenkins to run the builds.

Ans: A

```
Feedback
A: Correct. Creating a VPC service control, and running builds in a private pool gives you more security and allows multiple customizations that the default pool does not allow.
B: Incorrect. The default pool does not allow customization to limit VM configurations such as public IP addresses.
C: Incorrect. This custom approach incurs more effort and is not the recommended approach on Google Cloud.
D: Incorrect. This custom approach incurs more effort and is not the recommended approach on Google Cloud.
 
https://cloud.google.com/build/docs/private-pools/private-pools-overview
 
https://cloud.google.com/build/docs/private-pools/using-vpc-service-controls
 
https://cloud.google.com/build/docs/private-pools/set-up-private-pool-to-use-in-vpc-network
```

### 16. Your company has a major sales event planned in September. You have identified a group of employees to support operations during the sales event. You want to follow Google-recommended practices to provide the employees with access to Google Cloud resources for September only. What should you do?

A. Add a firewall rule to allow traffic from the identified employees’ machines to the resources. Change the firewall rule to deny traffic at the end of September.
B. Create a group that contains the identified employees. Assign the group permissions to access the resources and configure an Identity and Access Management (IAM) condition with a date/time expression for September.
C. Create a group that contains the identified employees and assign the group a custom Identity and Access Management (IAM) role that has permissions to access the resources. Delete the custom role at the end of September.
D. Assign a custom Identity and Access Management (IAM) role that has permissions to access the resources to each of the identified employees. Create a Cloud Scheduler task to delete the custom role at the end of September.

Ans: B

```
Feedback
A: Incorrect. The firewall rules might allow network traffic, but that does not mean that the user has the IAM permissions to work on the resources.
B: Correct. IAM conditions automatically assign the required permissions for the designated period only.
C: Incorrect. You need to remember to remove the role at the end of September, which is not recommended. Also, the permissions apply right away, which is not necessary.
D: Incorrect. Assigning roles to individual users is not recommended. Also, using Cloud Scheduler to later delete the role is not the recommended practice.
 
https://cloud.google.com/iam/docs/conditions-overview
```

### 17. Your company runs applications that serve users in Europe. Industry regulations require you to instantiate resources only in specific regions. You need to ensure that all projects in your Google Cloud organization follow this requirement. What should you do?

A. Create a log-based alert to identify resources created outside of the allowed list of regions. Delete any non-compliant resources.
B. Run an hourly Asset Inventory scan to catalog all resources. Delete any instance outside of the allowed list of regions.
C. Create a limited group of users with permission to create new instances. Create processes to verify compliance.
D. Configure an organizational policy with the allowed regions in an “in: allowed_values“ list.

Ans: D

```
Feedback
A: Incorrect. This option allows a resource to be created, which is a breach of the regulation.
B: Incorrect. This option allows a resource to be created, which is a breach of the regulation.
C: Incorrect. This is not reliable, because the team might still accidentally or maliciously create resources in the wrong regions.
D: Correct. The organizational policy constraint preempts the creation of a resource if it is not in the allowed regions.
 
https://cloud.google.com/resource-manager/docs/organization-policy/defining-locations#gcloud
 
https://cloud.google.com/resource-manager/docs/organization-policy/overview
```

### 18. Your application has a module that performs a computationally intensive task. Your development team wants to optimize this module by experimenting with different algorithms. You need to help the team test the algorithms in both the staging and production environments to gather detailed data on the performance of each algorithm. What should you do?

A. Instrument the code with profiling libraries. Visualize the data in Cloud Profiler as flame graphs.
B. Instrument the code to capture the flow of requests and responses. Review the request latencies in Cloud Trace.
C. Instrument the code with log statements at various parts of the algorithm. Send log-based notifications to collect data on the algorithm's execution.
D. Instrument the code with log statements at various parts of the algorithm. Send notifications based on log-metrics when the same control structures are called multiple times.


Ans: A

```
Feedback
A: Correct. Flame graphs in Cloud Profiler help you visualize the call stack within a program. This lets you identify bottlenecks and guides you in optimizing the code and algorithms.
B: Incorrect. Cloud Trace does not provide sufficient information on benchmarking code. It is better suited for distributed tracing of applications with multiple calls between them.
C: Incorrect. Log statements affect the timing of algorithms. Data collected in this way is inconvenient to visualize and is not detailed enough to provide guidance on bottlenecks.
D: Incorrect. Log statements affect the timing of algorithms. Data collected in this way is inconvenient to visualize and is not detailed enough to provide guidance on bottlenecks.
 
https://cloud.google.com/profiler/docs/concepts-profiling
 
https://cloud.google.com/profiler/docs/measure-app-performance
 
https://cloud.google.com/profiler/docs/concepts-flame
 
https://codelabs.developers.google.com/cloud-profiler-go#0
 
https://codelabs.developers.google.com/codelabs/otel-cloudtrace-go#0
```

### 19. Your code is stored on GitHub and built with Cloud Build, both manually and with webhooks. Building the code requires accessing confidential information. You want to follow Google-recommended practices to ensure the security of the confidential information. What should you do?

A. Trigger the builds from the command line each time, and supply the required confidential information as parameters.
B. Create an encrypted file in your GitHub repository to only contain the confidential information, and reference the encrypted file in your Cloud Build file.
C. Create an entry in Secret Manager, specify the URI for the confidential secrets in the Cloud Build file, and reference the secret as parameters in the build steps.
D. Retain the code in Github. Create a new repository only for confidential information in Cloud Source Repositories, and reference the new repository in your Cloud Build file.


Ans: C

```
Feedback
A: Incorrect. This solution does not work for those cases when webhooks trigger the build.
B: Incorrect. As a rule, any confidential information, secrets, and credentials should not be stored in a source repository. Others who have access to the GitHub repository would have access to the credentials, thus breaking the principle of least privilege.
C: Correct. Secret Manager can be configured with Identity and Access Management (IAM) to follow the principle of least privilege. Cloud Build can reference Secret Manager and you can include the secrets in the build steps by using parameter substitution.
D: Incorrect. As a rule, any confidential information, secrets, and credentials should not be stored in a source repository. Isolating confidential information in a separate repository is also not acceptable. Others who have access to the Cloud Source Repositories repository would have access to the information, thus breaking the principle of least privilege.
 
https://cloud.google.com/build/docs/securing-builds/use-secrets
 
https://cloud.google.com/build/docs/configuring-builds/substitute-variable-values
```

### 20. Your company uses an application that is deployed on Compute Engine virtual machines (VMs) to deliver a service to your customer. You have a Service Level Agreement (SLA) to provide 99% availability per month. Telemetry data over the first 22 days of the month shows that you served 10,000,000 requests with 99.28% availability. The development team has added new features to the application and wants to deploy them. You need to decide on a deployment approach while following Site Reliability Engineering (SRE) practices. What should you do?
A. Deploy the new features right away to Confidential VMs.
B. Defer the deployment of the new features until the next month.
C. Ask the customer to modify the SLOs and deploy new features right away.
D. Ask the customer to modify the SLA to 98.5% and deploy new features right away.

Ans: B

```
Feedback
A: Incorrect. Confidential VMs do not guarantee high availability for end-user requests.
B: Correct. The error budget is very low and you need to balance stability over feature updates.
C: Incorrect. SLOs are an internal measure and do not reflect your service agreement with the customer.
D: Incorrect. Changing SLAs when you have a low remaining error budget is not a recommended approach for application delivery.
 
https://sre.google/workbook/error-budget-policy/
 
https://sre.google/sre-book/embracing-risk/
```

