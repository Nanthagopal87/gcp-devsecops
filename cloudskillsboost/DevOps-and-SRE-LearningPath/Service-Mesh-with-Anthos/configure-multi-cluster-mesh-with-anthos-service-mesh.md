### AHYBRID081 Configuring a multi-cluster mesh with Anthos Service Mesh 

https://www.cloudskillsboost.google/paths/13/course_templates/435/labs/428004

## Overview

Many applications will eventually need to be distributed and have services running across multiple Anthos clusters. Anthos Service Mesh enables this with multi-cluster meshes.

A multi-cluster service mesh is a mesh composed of services running on more than one cluster.

A multi-cluster service mesh has the advantage that all the services look the same to clients, regardless of where the workloads are actually running. It’s transparent to the application whether a service is deployed in a single or multi-cluster service mesh.

In this lab, you build a service mesh encompassing two clusters, west and east. You deploy an application comprised of services, some running on west and some on east. You test the application to make sure that services can communicate across clusters without problem.

## Objectives

In this lab, you learn how to perform the following tasks:

- Install and configure a multi-cluster mesh
- Deploy and use Online Boutique in multiple configurations
- Review the deployments in each cluster
- Understand service-to-service flow between clusters
- Migrate workloads from one cluster to another

### Task 1. Prepare to install Anthos Service Mesh

### Task 2. Install Anthos Service Mesh on both clusters

### Task 3. Configure the mesh to span both clusters

### Task 4. Review Service Mesh control planes

### Task 5. Deploy the Online Boutique application across multiple clusters

### Task 6. Evaluate your multi-cluster application

### Task 7. Distribute one service across both clusters


