### 1. How many Labels exist on node node01?

kubectl get node node01 --show-labels
       or
kubectl describe node node01 and count the number of labels.

 kubectl get node node01 --show-labels
NAME     STATUS   ROLES    AGE   VERSION   LABELS
node01   Ready    <none>   15m   v1.31.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux

Ans: 5

### 2. What is the value set to the label key beta.kubernetes.io/arch on node01?

Ans: amd64

### 3. Apply a label color=blue to node node01

kubectl label node node01 color=blue
node/node01 labeled

kubectl get node node01 --show-labels
NAME     STATUS   ROLES    AGE   VERSION   LABELS
node01   Ready    <none>   19m   v1.31.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,color=blue,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux

### 4. Create a new deployment named blue with the nginx image and 3 replicas.

kubectl create deployment blue --image=nginx --replicas=3

controlplane ~ ➜  kubectl get deployment
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   3/3     3            3           13s

controlplane ~ ➜  kubectl get pods
NAME                    READY   STATUS    RESTARTS   AGE
blue-6dc9b889f5-gr4jz   1/1     Running   0          18s
blue-6dc9b889f5-nbf69   1/1     Running   0          18s
blue-6dc9b889f5-qfxwj   1/1     Running   0          18s

controlplane ~ ➜  kubectl get rs
NAME              DESIRED   CURRENT   READY   AGE
blue-6dc9b889f5   3         3         3       24s

### 5. Which nodes can the pods for the blue deployment be placed on? Make sure to check taints on both nodes!

kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   22m   v1.31.0
node01         Ready    <none>          22m   v1.31.0

kubectl describe node node01 | grep "Taint"
Taints:             <none>
kubectl describe node controlplane | grep "Taint"
Taints:             <none>


As there is no taint applied on both nodes, pod will be placed on either nodes. So ans is controlplane ans node01



Also we can check where the pod is allocated with respect to node by using below commands.

controlplane ~ ➜  kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-6dc9b889f5-gr4jz   1/1     Running   0          3m38s   10.244.1.3   node01         <none>           <none>
blue-6dc9b889f5-nbf69   1/1     Running   0          3m38s   10.244.0.4   controlplane   <none>           <none>
blue-6dc9b889f5-qfxwj   1/1     Running   0          3m38s   10.244.1.2   node01         <none>           <none>


Ans: controlplane and node01

### 6. Set Node Affinity to the deployment to place the pods on node01 only.

- Name: blue
- Replicas: 3
- Image: nginx
- NodeAffinity: requiredDuringSchedulingIgnoredDuringExecution
- Key: color
- value: blue


kubectl create deployment blue --image=nginx --replicas=3 --dry-run=client -o yaml >> node-affinity-deployment.yaml

Edit the deployment file

affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: color
                operator: In
                values:
                - blue
/tmp/kubectl-edit-333595250.yaml

kubectl replace --force /tmp/kubectl-edit-333595250.yaml
kubectl replace -f /tmp/kubectl-edit-333595250.yaml


### 7. Which nodes are the pods placed on now?

kubectl get pods -o wide

NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
blue-5659879b55-c4985   1/1     Running   0          85s   10.244.1.4   node01   <none>           <none>
blue-5659879b55-kmq8q   1/1     Running   0          81s   10.244.1.6   node01   <none>           <none>
blue-5659879b55-rnq8x   1/1     Running   0          83s   10.244.1.5   node01   <none>           <none>

Ans: node01


### 8. Create a new deployment named red with the nginx image and 2 replicas, and ensure it gets placed on the controlplane node only.

Use the label key - node-role.kubernetes.io/control-plane - which is already set on the controlplane node.

Name: red
Replicas: 2
Image: nginx
NodeAffinity: requiredDuringSchedulingIgnoredDuringExecution
Key: node-role.kubernetes.io/control-plane
Use the right operator


kubectl create deployment red --image=nginx --replicas=2 --dry-run=client -o yaml

Edit the file 
affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: node-role.kubernetes.io/control-plane
                operator: Exists

kubectl apply -f red-deploy.yaml deployment.apps/red created

Verify

controlplane ~ ➜  k get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-5659879b55-c4985   1/1     Running   0          9m24s   10.244.1.4   node01         <none>           <none>
blue-5659879b55-kmq8q   1/1     Running   0          9m20s   10.244.1.6   node01         <none>           <none>
blue-5659879b55-rnq8x   1/1     Running   0          9m22s   10.244.1.5   node01         <none>           <none>
red-7c64d97ff5-4n6g2    1/1     Running   0          65s     10.244.0.5   controlplane   <none>           <none>
red-7c64d97ff5-8czk5    1/1     Running   0          65s     10.244.0.6   controlplane   <none>           <none>



