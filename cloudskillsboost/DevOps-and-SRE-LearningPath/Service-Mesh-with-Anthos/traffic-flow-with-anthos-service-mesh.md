### Managing Traffic Flow with Anthos Service Mesh

https://www.cloudskillsboost.google/paths/20/course_templates/435/labs/427986

### Task 1. Review Traffic Management use cases

Different traffic management capabilities are enabled by using different configuration options.

## Example: traffic splitting

Route traffic to multiple versions of a service.

```
```

## Example: timeouts

Set a timeout, the amount of time Istio waits for a response to a request. The timeout for HTTP requests is 15 seconds, but it can be overridden.

```
```

## Example: retries

A retry is an attempt to complete an operation multiple times if it fails. Adjust the maximum number of retry attempts, or the number of attempts possible within the default or overridden timeout period.

## Example: fault injection: inserting delays

Fault injection is a testing method that introduces errors into a system to ensure that it can withstand and recover from error conditions.

```
```

This example introduces a 5 second delay in 10% of the requests to the "v1" version of the ratings microservice.

## Example: fault injection: inserting aborts

```
```

The above example returns an HTTP 400 error code for 10% of the requests to the ratings service "v1".

## Example: conditional routing: based on source labels
```
```

A rule can indicate that it only applies to calls from workloads (pods) implementing the version v2 of the reviews service.

## Example: conditional routing: based on request headers

```
```

The above rule only applies to an incoming request if it includes a custom "end-user" header that contains the string “atharvak”.

### Task 2. Complete lab setup

This lab environment has already been partially configured.


- A GKE cluster named gke was created.
- Anthos Service Mesh has been installed
- The Bookinfo multi-service sample application was deployed.

Configure cluster access for kubectl

1. Set the Zone environment variable:
```
CLUSTER_ZONE=us-east1-c
```
2. In Cloud Shell, set environment variables cluster name:
```
export CLUSTER_NAME=gke
```
3. Configure kubectl command line access by running:
```
export GCLOUD_PROJECT=$(gcloud config get-value project)
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --project $GCLOUD_PROJECT
```
If prompted, click the Authorize button.

## Verify cluster and Anthos Service Mesh installation
4. Check that your cluster is up and running:
```
gcloud container clusters list
```

Output:
```
NAME: gke
LOCATION: us-east1-c
MASTER_VERSION: 1.30.5-gke.1699000
MASTER_IP: 34.73.198.6
MACHINE_TYPE: e2-standard-4
NODE_VERSION: 1.30.5-gke.1699000
NUM_NODES: 3
STATUS: RUNNING
```

5. Ensure the Kubernetes pods for the Anthos Service Mesh control plane are deployed:
```
kubectl get pods -n istio-system
```

## Output:
```
NAME                                 READY   STATUS    RESTARTS   AGE
istiod-asm-1226-2-64fcf49649-bktdw   1/1     Running   0          3h5m
istiod-asm-1226-2-64fcf49649-h7nx9   1/1     Running   0          3h5m
```

### Task 3. Install Gateways to enable ingress

### Task 4. Use the Anthos Service Mesh dashboard view routing to multiple versions

### Task 5. Apply default destination rules, for all available versions


### Task 6. Apply virtual services to route by default to only one version

### Task 7. Route to a specific version of a service based on user identity


### Task 8. Shift traffic gradually from one version of a microservice to another

### Task 9. Add timeouts to avoid waiting indefinitely for service replies

### Task 10. Add circuit breakers to enhance your microservices' resiliency

### 

