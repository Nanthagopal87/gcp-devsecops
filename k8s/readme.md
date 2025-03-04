### K8S - Compare CKAD vs CKA vs CKS

### CKAD
- Application Design and Build                        - 20%
- Application Deployment                              - 20%
- Application Observability and Maintenance           - 15%
- Application Environment, Configuration and Security - 25%
- Service and Networking                              - 20%

### KodeCloud - CKAD
- Section1-Core-Concepts
- Section2-Configuration
- Section3-MultiContainer-Pods
- Section4-Observability
- Section5-PodDesign
- Section6-Service-and-Networking
- Section7-Persistence

### CKA
- Cluster Architecture, Installation & Configuration - 25%
- Workload and Scheduling                            - 15%
- Service and Networking                             - 20%
- Storage                                            - 10%
- Troubleshooting                                    - 30%

### KodeCloud - CKA
- Section1-Core-Concepts
- Section2-Scheduling
- Section3-Logging & Monitoring
- Section4-Application Lifecycle Managment
- Section5-Cluster Maintenance
- Section6-Security
- Section7-Storage
- Section8-Networking
- Section9-Design and Install Kubernetes Cluster
- Section10-Install Kubernetes the kubeadm way
- Section11-E2E tests on a kubernetes cluster
- Section12-Troubleshooting

### CKS
- Cluster Setup                         - 10%
- Cluster Hardening                     - 15%
- System Hardening                      - 15%
- Minimize Microservice Vulnerabilities - 20%
- Supply Chain Security                 - 20%
- Monitor, Logging and Runtime Security - 20%



### FUC's

- kubectl exec webapp -it -- bash/sh
- kubectl exec webapp -- cat /log/app.log

## Volumes:
 - emptyDir
 - hostPath


### CASE 1: Pod using volume claim

```
cat webapp.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: webapp
    image: kodekloud/event-simulator
    volumeMounts:
    - name: log-storage
      mountPath: /log
  volumes:
  - name: log-storage
    hostPath:
      path: /var/log/webapp
      type: Directory
```

### CASE 2: Pod using PVC

```
cat webapp.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: webapp
    image: kodekloud/event-simulator
    volumeMounts:
    - name: log-storage
      mountPath: /log
  volumes:
  - name: log-storage
    persistentVolumeClaim:
        claimName: claim-log-1

```





