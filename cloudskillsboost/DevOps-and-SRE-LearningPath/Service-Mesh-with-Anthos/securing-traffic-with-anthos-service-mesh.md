### AHYBRID061 Securing Traffic with Anthos Service Mesh

https://www.cloudskillsboost.google/paths/20/course_templates/435/labs/427996

## Overview

Anthos Service Mesh security helps you mitigate insider threats and reduce the risk of a data breach by ensuring that all communications between workloads are encrypted, mutually authenticated, and authorized.

In this lab, you learn how PERMISSIVE mode mTLS allows services to receive both plaintext and mTLS traffic from clients, allowing you to incrementally adopt mTLS. You also enabled STRICT mode mTLS across your service mesh effectively blocking plaintext traffic to all your Istio injected services and then you scoped STRICT mode mTLS down to a single namespace

## Objectives

In this lab, you learn how to perform the following tasks:

- Enforce STRICT mTLS mode across the service mesh
- Enforce STRICT mTLS mode on a single namespace
- Explore the security configurations in the Anthos Service Mesh Dashboard
- Add authorization policies to enforce access based on a JSON Web Token (JWT)
- Add authorization policies for HTTP traffic in an Istio mesh

### Task 1. Confirm Anthos Service Mesh setup

This lab environment has already been partially configured. A GKE cluster with 2 nodes has been provisioned for you. If you would like to investigate how the cluster creation process happened, look at the setup-vm startup-script.

Configure cluster access for kubectl

1. Set the Zone environment variable:
```
CLUSTER_ZONE=us-east4-a
```
2. In Cloud Shell, set environment variables cluster name:
```
export CLUSTER_NAME=gke
```

3. Configure kubectl command line access by running:
```
# get the project id
export GCLOUD_PROJECT=$(gcloud config get-value project)

# configure kubectl
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --project $GCLOUD_PROJECT
```
If prompted, click the Authorize button.

## Verify cluster and Anthos Service Mesh installation
4. Check that your cluster is up and running:
```
gcloud container clusters list
```

```
NAME: gke
LOCATION: us-east4-a
MASTER_VERSION: 1.30.5-gke.1699000
MASTER_IP: 34.150.208.8
MACHINE_TYPE: e2-standard-2
NODE_VERSION: 1.30.5-gke.1699000
NUM_NODES: 3
STATUS: RUNNING
```

5. Ensure the following Kubernetes istiod services are deployed:

```
kubectl get service -n istio-system
```
```
NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                 AGE
istiod               ClusterIP   34.118.229.156   <none>        15010/TCP,15012/TCP,443/TCP,15014/TCP   13h
istiod-asm-1157-23   ClusterIP   34.118.227.142   <none>        15010/TCP,15012/TCP,443/TCP,15014/TCP   13h
```


6. Ensure the corresponding Kubernetes istiod-* pods are deployed and all containers are up and running:

```
kubectl get pods -n istio-system
```

### Task 2. Deploy sleep and httpbin services

In this task, you create a set of namespaces to host the httpbin, and sleep services. You will use those services to explore the impact of mTLS on traffic. The sleep service acts as the client and will call the httpbin service, which acts as a server.

Setup the authentication example

You will deploy this example configuration and then use it to explore the authentication options that Istio offers:

1. In Cloud Shell, create namespaces for the example clients and services. Traffic in the legacy-* namespaces takes place over plain text, while traffic in the mtls-* namespaces happens over mTLS:

```
kubectl create ns mtls-client
kubectl create ns mtls-service
kubectl create ns legacy-client
kubectl create ns legacy-service

kubectl get namespaces
```

```
kubectl create ns mtls-service
kubectl create ns legacy-client
kubectl create ns legacy-service

kubectl get namespaces
namespace/mtls-client created
namespace/mtls-service created
namespace/legacy-client created
namespace/legacy-service created
NAME                 STATUS   AGE
asm-system           Active   13h
default              Active   13h
gke-managed-system   Active   13h
gmp-public           Active   13h
gmp-system           Active   13h
istio-system         Active   13h
kube-node-lease      Active   13h
kube-public          Active   13h
kube-system          Active   13h
legacy-client        Active   2s
legacy-service       Active   1s
mtls-client          Active   4s
mtls-service         Active   3s
```

2. Deploy the legacy services in the legacy-* namespaces. You call them legacy because they are not part of the mesh:

```
#configurations are stored in Github

kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/sleep/sleep.yaml \
-n legacy-client

kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/httpbin/httpbin.yaml \
-n legacy-service
```

3. Enable auto-injection of the Istio sidecar proxy on the mtls-* namespaces:

```
# get the revision label
export DEPLOYMENT=$(kubectl get deployments -n istio-system | grep istiod)
export VERSION=asm-$(echo $DEPLOYMENT | cut -d'-' -f 3)-$(echo $DEPLOYMENT \
    | cut -d'-' -f 4 | cut -d' ' -f 1)

# enable auto-injection on the namespaces
kubectl label namespace mtls-client istio.io/rev=${VERSION} --overwrite
kubectl label namespace mtls-service istio.io/rev=${VERSION} --overwrite
```

4. Deploy the services in the mtls-* namespaces:

```
kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/sleep/sleep.yaml \
-n mtls-client

kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.6/samples/httpbin/httpbin.yaml \
-n mtls-service
```

5. Verify that the sleep service and the httpbin service are each deployed in both the mtls-service and legacy-service namespaces:

```
kubectl get services --all-namespaces
```
```
NAMESPACE        NAME                                                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                 AGE
asm-system       canonical-service-controller-manager-metrics-service   ClusterIP   34.118.236.29    <none>        8443/TCP                                13h
default          kubernetes                                             ClusterIP   34.118.224.1     <none>        443/TCP                                 13h
gmp-system       alertmanager                                           ClusterIP   None             <none>        9093/TCP                                13h
gmp-system       gmp-operator                                           ClusterIP   34.118.232.189   <none>        8443/TCP,443/TCP                        13h
istio-system     istiod                                                 ClusterIP   34.118.229.156   <none>        15010/TCP,15012/TCP,443/TCP,15014/TCP   13h
istio-system     istiod-asm-1157-23                                     ClusterIP   34.118.227.142   <none>        15010/TCP,15012/TCP,443/TCP,15014/TCP   13h
kube-system      default-http-backend                                   NodePort    34.118.229.33    <none>        80:30772/TCP                            13h
kube-system      kube-dns                                               ClusterIP   34.118.224.10    <none>        53/UDP,53/TCP                           13h
kube-system      metrics-server                                         ClusterIP   34.118.236.189   <none>        443/TCP                                 13h
legacy-client    sleep                                                  ClusterIP   34.118.225.203   <none>        80/TCP                                  87s
legacy-service   httpbin                                                ClusterIP   34.118.231.184   <none>        8000/TCP                                83s
mtls-client      sleep                                                  ClusterIP   34.118.237.234   <none>        80/TCP                                  7s
mtls-service     httpbin                                                ClusterIP   34.118.236.130   <none>        8000/TCP                                4s
```

6. Verify that a sleep pod is running in the mtls-client and legacy-client namespaces and that an httpbin pod is running in the mtls-service and legacy-service namespaces:

```
kubectl get pods --all-namespaces
```

```
NAMESPACE        NAME                                                    READY   STATUS    RESTARTS   AGE
asm-system       canonical-service-controller-manager-6b4755fcf9-k24hz   2/2     Running   0          13h
gmp-system       collector-55cwg                                         2/2     Running   0          13h
gmp-system       collector-74mc5                                         2/2     Running   0          13h
gmp-system       collector-fh4mp                                         2/2     Running   0          13h
gmp-system       gmp-operator-76fd98dbd4-c8dsf                           1/1     Running   0          13h
istio-system     istiod-asm-1157-23-85fbd8cf85-5djhf                     1/1     Running   0          13h
istio-system     istiod-asm-1157-23-85fbd8cf85-k6gdp                     1/1     Running   0          13h
kube-system      event-exporter-gke-5759df9455-66wxt                     2/2     Running   0          13h
kube-system      fluentbit-gke-2t57n                                     3/3     Running   0          13h
kube-system      fluentbit-gke-2vclx                                     3/3     Running   0          13h
kube-system      fluentbit-gke-pnzqb                                     3/3     Running   0          13h
kube-system      gke-metadata-server-bq2wx                               1/1     Running   0          13h
kube-system      gke-metadata-server-fjtrz                               1/1     Running   0          13h
kube-system      gke-metadata-server-r4ffz                               1/1     Running   0          13h
kube-system      gke-metrics-agent-7ghw5                                 3/3     Running   0          13h
kube-system      gke-metrics-agent-sgwq5                                 3/3     Running   0          13h
kube-system      gke-metrics-agent-wzscq                                 3/3     Running   0          13h
kube-system      konnectivity-agent-6f548d7d97-5vgkm                     2/2     Running   0          13h
kube-system      konnectivity-agent-6f548d7d97-hmgrn                     2/2     Running   0          13h
kube-system      konnectivity-agent-6f548d7d97-q9hbv                     2/2     Running   0          13h
kube-system      konnectivity-agent-autoscaler-74c67bcb5b-9r5dn          1/1     Running   0          13h
kube-system      kube-dns-74bff99dfb-lrv62                               5/5     Running   0          13h
kube-system      kube-dns-74bff99dfb-xw2ds                               5/5     Running   0          13h
kube-system      kube-dns-autoscaler-6f896b6968-hnznb                    1/1     Running   0          13h
kube-system      kube-proxy-gke-gke-pool-12345-0f86fd2e-b763             1/1     Running   0          13h
kube-system      kube-proxy-gke-gke-pool-12345-0f86fd2e-ljjk             1/1     Running   0          13h
kube-system      kube-proxy-gke-gke-pool-12345-0f86fd2e-pcj0             1/1     Running   0          13h
kube-system      l7-default-backend-9d87b864c-2bkqs                      1/1     Running   0          13h
kube-system      metrics-server-v1.30.3-5fcb455695-9dr75                 1/1     Running   0          13h
kube-system      netd-gft7j                                              3/3     Running   0          13h
kube-system      netd-nd5pr                                              3/3     Running   0          13h
kube-system      netd-pgpmk                                              3/3     Running   0          13h
kube-system      pdcsi-node-jj5w7                                        2/2     Running   0          13h
kube-system      pdcsi-node-nwfjs                                        2/2     Running   0          13h
kube-system      pdcsi-node-zkwr4                                        2/2     Running   0          13h
legacy-client    sleep-9879fb58f-c6wtd                                   1/1     Running   0          2m16s
legacy-service   httpbin-5855dc8bdd-5rqkx                                1/1     Running   0          2m12s
mtls-client      sleep-9879fb58f-ckkz8                                   2/2     Running   0          56s
mtls-service     httpbin-5855dc8bdd-fz56l                                2/2     Running   0          53s

```

Verify that the two sleep clients can communicate with the two httpbin services

- Use Cloud Shell to run this nested command loop:

```
for from in "mtls-client" "legacy-client"; do
  for to in "mtls-service" "legacy-service"; do
    kubectl exec $(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name}) -c sleep -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"
  done
done
```

Output:
```
sleep.mtls-client to httpbin.mtls-service: 200
sleep.mtls-client to httpbin.legacy-service: 200
sleep.legacy-client to httpbin.mtls-service: 200
sleep.legacy-client to httpbin.legacy-service: 200
```

Now you're ready to enforce security policies for this application.

### Task 3. Understand authentication and enable service to service authentication with mTLS

Anthos Service Mesh

1. In the console, go to Navigation Menu > Kubernetes Engine > Service Mesh.

In the Anthos Service Mesh dashboard, you will see the 2 services that were created in the mtls-service and mtls-client/sleep namespaces. You don't see the legacy services because you did not label their namespace, and therefore they remain outside of the mesh.




### Task 4. Leverage RequestAuthentication and AuthorizationPolicy resources

### Task 5. Authorizing requests based on method and path



