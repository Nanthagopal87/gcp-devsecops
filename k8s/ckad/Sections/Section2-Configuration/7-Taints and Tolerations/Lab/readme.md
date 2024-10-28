### 1. How many nodes exist on the system? Including the controlplane node.
- kubectl get nodes

Ans: 2

### 2. Do any taints exist on node01 node?

kubectl get nodes

NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   20m   v1.31.0
node01         Ready    <none>          19m   v1.31.0

- kubectl describe node node01 | grep "Taint"

Ans: No

### 3. Create a taint on node01 with key of spray, value of mortein and effect of NoSchedule, Key = spray, Value = mortein, Effect = NoSchedule

Ans:
- kubectl taint node node01 spray=mortein:NoSchedule
- kubectl describe node node01 | grep "Taint"
Taints:             spray=mortein:NoSchedule

### 4. Create a new pod with the nginx image and pod name as mosquito.

Ans: kubectl run mosquito --image=nginx
kubectl get pod mosquito
NAME       READY   STATUS    RESTARTS   AGE
mosquito   0/1     Pending   0          79s

This is because, the pod mosquito is untolerated so its' not allowed to create pod

kubectl describe pod mosquito

Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  2m3s  default-scheduler  0/2 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }, 1 node(s) had untolerated taint {spray: mortein}. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.

### 5. What is the state of the POD?

Ans: Pending

### 6. Why do you think the pod is in a pending state?

Ans: POD Mosquito cannot tolerate taint on node01

### 7. Create another pod named bee with the nginx image, which has a toleration set to the taint mortein.

Ans:
- kubectl run bee --image=nginx --dry-run=client -o yaml >> pod-bee-tolerate.yaml

https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"

  Add the below secction under spec

tolerations:
- key: "spray"
  operator: "Equal"
  value: "mortein"
  effect: "NoSchedule"

  - kubectl describe node node01 | grep "Taint"
Taints:             spray=mortein:NoSchedule

kubectl apply -f pod-bee-tolerate.yaml

kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
bee        1/1     Running   0          2m49s
mosquito   0/1     Pending   0          14m

### 8. Notice the bee pod was scheduled on node node01 despite the taint

### 9. Do you see any taints on controlplane node?

- kubectl get nodes
- kubectl describe node controlplane | grep "Taint"
Taints:             node-role.kubernetes.io/control-plane:NoSchedule

Ans: Yes-NoSchedule

### 10. Remove the taint on controlplane, which currently has the taint effect of NoSchedule.

Ans: 
- kubectl taint --help
    # Remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' if one exists
  kubectl taint nodes foo dedicated:NoSchedule-
  
  # Remove from node 'foo' all the taints with key 'dedicated'
  kubectl taint nodes foo dedicated-

  kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
node/controlplane untainted

 kubectl describe node controlplane | grep "Taint"
Taints:             <none>

### 11. What is the state of the pod mosquito now?

k get pods
NAME       READY   STATUS    RESTARTS   AGE
bee        1/1     Running   0          9m25s
mosquito   1/1     Running   0          21m

Ans: Running

### 12. Which node is the POD mosquito on now?

controlplane ~ ➜  k get pods -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
bee        1/1     Running   0          10m   10.244.1.2   node01         <none>           <none>
mosquito   1/1     Running   0          22m   10.244.0.4   controlplane   <none>           <none>


Ans: controlplane
