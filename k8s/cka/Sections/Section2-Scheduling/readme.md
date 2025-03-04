### Scheduling
1. Manual Scheduling
2. Labels and Selectors
3. Taints and Tolerations
4. Node Selectors
5. Node Affinity
6. Taints and Tolerations vs Node Affinity
7. Resource Requirements and Limits
8. Daemonsets
9. Static Pods
10. Multiple Schedulers
11. Configuring Scheduler Profiles




### 1. Manual Scheduling
Let's discuss about different ways of manually scheduling a pod on a node.

## How scheduling works
What do you do when you do not have a scheduler in your cluster?
You probably do not want to rely on the built-in scheduler, and instead want to schedule the pod yourself.

So how does exactly does a scheduler work in the backend?

Let's start with the simple pod definition file.

Filename: pod-definition.yaml

```
apiVersion: v1
kind: Pod
metadata: 
  name: nginx
  labels:
     name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
      - containerPort: 8080
   nodeName: 
```

Every pod has a field called Node name, that by default, is not set. You don't typically specify this field when you create the pod manifest file.

kubernetes adds it automatically. The scheduler goes through all the pods and looks for those that do not have this property set. 

Those are the candidates for the scheduling. It then identifies the right node for the pod by running the scheduler algorithm.

- Want to Schedule?
- Which node to Schedule?
- (Schedule) Bind Pod to Node

Once identified, it schdules the pods on the node by settig the node name property to the name of the node by creating a binding object.

## No Scheduler
So if there is no scheduler to monitor and scheduler nodes, what happens?
The pods continue to be in a pending state.

So what can you do about it?
You can manually assign pods to nodes yourself. Well, without a scheduler, the easiest way to schedule a pod is to simply set the node name feild to the name of the node in your pod specification file while creating the pod.

The pod then gets assigned to the specified node. You can only specify the node name at creating time.

What if the pod is already created and you want assign the pod to a node?

Kubernetes won't allow you to modify the node name property of a pod, so another way to assign a node to an existing pod is create a binding object and send a POST request to the pod's binding API, thus mimicking what the actual scheduler does.

Filename: pod-bind-definition.yaml
```
apiVersion: v1
kind: Binding
metadata: 
  name: nginx
target:
  apiVersion: v1
  kind: Node
  name: 
```

In the binding object, you specify a target node, with the name of the node, then send a POST request to the pod's binding API with the data set to the binding object in a JSON format.

```
curl --header "Content-Type: application/json" --request POST --data '{"apiVersion": "v1", "kind": "binding" ...,}'
http://$SERVER/api/v1/namespace/defaults/pods/$PODNAME/binding/
```

So you must convert the YAML file into its equivalent JSON form.

Some usefull commands:
```
To check default pods running as part of control plane:
kubectl get pods -n kube-system

To delete and re-create the pod
kubectl replace --force -f nginx.yaml

kubectl get pods -owide
kubectl get pods --watch
```

### 2. Labels and Selectors

What do we know about labels and selectors already?

Labels and selectors are a standard method to group things together. Say, you have a set of different species a user wants to be able to filter them based on different criteria, such as based on their class or kind

e.g we can cosider animals.

if they are domestic or wild or say by teir color.

And not ust group, you want to be able to filter them based on a criteria such as all green animals or multiple criteria such as everything green that is also a bird.

Whateve that classification may be, you need the ability to group things together and filetr them based on your needs and the best way to do that is with labels.

**Labels** are properties attached to each item, so you add properties to each item for their class, kind and color.

**Selectors** help you to filter these items.

e.g 

CAT               TORTOISE
----              --------
class: Mammal   class: Reptile
kind: Domestic  kind: Wild
color: Green    color: purple

COW               Sparrow
----              --------
class: Mammal    class: Kind
kind: Domestic   kind: Domestic
color: Orange    color: Green

For example, 
Case1: when you say class equals Mammal => We get a list of mammals, cat and Cow

Case2: when you say class equals Mammal and color eqquals green => cat

We see labels in selectors used everywhere, such as keywords you tag to youtube videos or blogs that help users filter and find the right content.

We see labels added to the item in an online portal that help you to add different kind of filters to view your products.


## Labels and Selectors in Kubernetes

# So how are labels and selectors used in kubernetes?

We have created a lot different types on objects in k8s, pods, services, replica sets, deployments etc.,

For k8s, all of these are different objects. Over time you may end up having hundred and thousands of these objects in your cluster. Then you will need a way to filter and view different objects by different categories, such as to group objects by their type or view objects by application or by their functionality.

Whatever it may be, you can group and select objects using labels and selectors.

For each object, attach labels as per your needs, like app, function etc.,

e.g

app: App1 
function: Front-end

app: App2
function: Web-servers

app: App3
function: Auth

app: App4
function: Image-proc

app: App5
function: DB

Then while selecting, specify a condition to filter specify objects.

For example, app equal App1

# So how exactly do you specify labels in kubernetes?

In a pod-definition file, under metadata, create a section called labels. Under that, add the labels in a key value format like this.

```
apiVersion: v1
kind: Pod
metadata: 
  name: simple-webapp
  labels: Front-End
     app: App1
     function: nginx
spec:
  containers:
  - name: simple-webapp
    image: simple-webapp
    ports:
      - containerPort: 8080

```

You can add as many labels as you like. Once the pod is created, to select the pod with the labels, use the kubetl get pods command along with the selector option and specify the condition like app equals App1.

```
kubectl get pods --selector app=App1
```

Now this is once use-case of Labels and Selectors.

K8S objects use labels and selectors internally to connect different objects together.

For example, to create a replica set, consisting of three different pods, we first label the pod definition and use selector in a replica set to group the pods.



replicaset-definition.yaml
```
apiVersion: v1
kind: ReplicaSet
metadata: 
  name: simple-webapp
  labels: Front-end
     app: App1
     function: nginx
spec:
  replicas: 3
  selector: 
    matchLabels:
      app: App1
  template:
    metadata:
      labels:
        app: App1
        function: Front-end
    spec: 
      containers:
      - name: simple-webapp
        image: simple-webapp
```

In a replica-set definition file, you will see labels defined in two places.

Note that this a area where beginners tend to make a mistake.

The labels defined under the template section are the labels configured on the pods.

The labeels you at the top, are the labels of the replica set itself.

We are not really concerned about the labels of the replica set for now because we are trying to get the replica set to discover the pod.

The labels on the replica set will be used if you were to configure some other obejct to discover the replicaset.

In order to connect the replica set to the pod, we configure the selector field, under the replica set specification to match the labels defined on the pod.

A single label will do if it matches correctly. However if you feel cloud be othrer pods witht the same lable with diff function, then you cpuld speecify both the label to ensure that the right part are discovered by the rs.

On creation, if the labels match, the rs is created successfully.

It works the same for other objects like a service.

When a service is created, it uses the selector defined in the  service definition file to match the labels set on the pods in the replica set definition file.

service-definition.yaml
```
apiVersion: v1
kind: Service
metadata: 
  name: my-service
spec:
  selector: 
      app: App1
  ports:
  - protocol: TCP
    port: 80
    targetPort: 9376
```

Finally, let's look at annotation. While labels and selectors are used to group and select obects, **annotation** are used to record other details for informatory purpose.

For example, tools detail like name, version, build information etc., or contact details, phone numbers, emailId's etc., that may be used of some kind of integration purpose. 


### 3. Taints and Tolerations

In this section, we will discuss about the pod-to-node relationship and you can restrict what pods are placed on what nodes.

The concept of taints and tolerations cab be a bit confusing for the beginners.

So we try to understand what they are using an analogy of a bug approaching a person.

Now, my aplologies in advance, but this is the best i could come up with.

To prevent the bug from landing on the person, we spray the person with a repellent spray or a taint we will call it in this lecture.

The bug is intolerant to the smell so on approaching the peron, the taint applied on the person throws the bug off .

However, there could be other bugs that are tolernt to this smell and so the taint doesn't really affect them and so they end up landing on the person. 

So there are two things that decide, if a bug can land on a person.

1. The taint on  a person
2. The bug's toleration level to that particular taint.

Getting back to k8s, the person is a node and bugs are pods.

Now, taints and tolerations have nothing to do with intrusion or security on the cluster.

Taints and tolertions are used to set restrictions on what pods can scheduled to a node.

Let us start with a simple cluster with three worker nodes. The nodes are named one, two and three.

We also have a set of pods that are to be deployed on to these nodes. Let's call them A,B,C and D.

When the pods are created, k8s scheduler tried to place these pods on the available worker nodes.

As of now there are no restrictions, or limitations and as such, the scheduler places the pods across all of the nodes to balance them out equally.


Now, let us assume we have a dedicated resoures on a node1 for a particular use case or application.

So we would like only those pods that belong to this application to be placed on node one.

First, we prevent all pods from being placed on the node by placing a taint on the node.

Let's call it blue(Taint=blue).

By default, pods have no tolerations. which means unless specificed otherwise. none of the pods can tolerate any taint.

So, in this case non the pod can be placed on node1, as none of them can tolearte the taint blue.

This solved half our rrequirement.

No unwanted pods are going to be placed on this node.

The other half is to enable certain pods, to be placed on this node.

For this, we must specify which pods are tolernt to this particular taint.

In our case, we would like to allow only pod D to be placed on this node.

So we add a toleration to pod D.

pod D is now tolerant to blue. So when the scheduler tries to plac this pod on node 1 it goes through.

Node1 can now only accepts pods that can tolerate the taint blue.

So with all the taints and tolerations in place, this is how the pods should would be schduled.

The scheduler tries to place pod A to node one, but due to the taint, it is thrown off and it goes to node two. The scheduler then tries to place pod B to node one, but again, due to the taint, it is thrown off and is placed on node three, which happens to be next free node.

The scheduler then tries to place pod C to node one, it is thrown off again and ends up on node 2 and finally  thee scheduler tries to place the pod D on node one.

Since the pod is tolerant to node one, it goes through. So remeber taints are set on nodes and tolerants are set on pods. So how do you do this?

## Taints- Node

Use the kubectl taint nodes command to taint a node specify the name of the node to taint followed by the taint itself, which is a key-value pair.

```
kubectl taint nodes node-name key=value:taint-effect
```
For example, if you would like to dedicate the node to pods in application blue, then the key-value pair would be app=blue.

The taint effect defines **what would happen to the pods if they do not tolerate the taint.**

There are three taint effects, no schedule which means the pods will not be schedule on the node which is what we have been discussing. Prefer no schedule, which means the system will try to avoid placing a pod on the node, but that is not guranteed. And third is no execute, which means that new pods willnot be sheduled on the node and existing pods on the node, if any, will be evicted. if they do not tolerate the taint. Theste pods may have been scheduled on the node before the taint was applied to the node.

An example command would be to taint node one with the key-value pair app=blue and an effect of no schedule.

```
kubectl taint nodes node1 app=blue:NoSchedule
```

- No Schedule => pods will not be schedule on the node.
- PreferNoSchedule => 
- NoExecite => 

## Toleration - PODs

Toleration are added to pods. To add atolerations to a pod, first pull up the pod definition file. In the spec section of the pod definition file, add a section called, **'tolerations'**, move the same value used while creating the iant.
Under this section, the key is app, operator is equal value is blue and the effect is no schedule.


```
kubectl taint nodes node1 app=blue:NoSchedule
```

pod-definition.yaml
```
apiVesion:
kindL Pod
metadata:
  name: myapp-pod
spec:
  containers:
  - name: nginx-container
    image: nginx
  tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"

```

And remeber, all of these values need to be encoded in double quotes. When the pods are now created or updated with the new tolerations, they are either, not scheduled on nodes or evicted from the existing nodes depending on the effect set.

Let us try to understand the **no execute** taint effect in  a bit more depth.

## Taint - No Execute

Node1 => D and C pods
Node2 => A pod
Node3 => B pod

In this example, we have three nodes running some workload, We do not have any taints or tolerations at this moment, so they are schduled this way.

We then decided to dedicate node one for a special application, and as such, we taint the node with the application name and add a toleration to the pod that belongs to the application, which happens to be pod D in this case.

While tainting the node, we set the taint effect, to no execute, and as such, once the taint, on the nodes takes effect, it evits the pod c from the node 1, which simply means the pod is killed.

The pod D continuous to run on the node as it has a toleration to the taint blue.

Now, going back to our original scenario, where we have taint and tolerations configured.

Remember taints and tolerations are only meant to restrict nodes from accepting certain pods.

In this caese, node one can only accept Pod D, bit it does not gurantee that pod D will always, be placed on node one.

Since there are no taints or restrictions applied on the other two nodes, pod D may very well be placed .

**So, remeber, taints and tolearions does not tell the pod to go to a particular node. Instead it tells the node to only accept pods with certain tolerations.**

If your requirement is to restrict a pod to certain nodes, it is acheived through the another concept called **Affinity**, which will discuss in next section.

Finally, while we are on this topic, let us also take an interesting fact. So far we have only been refering to the worker nodes.

But we also have master nodes in the cluster, which is technically ust another node that has all the capabilities of hosting a pod, plus it runs all the management software.

Now, i'm not sure if you noticed the scheduler does not schedule any pods on the master node.

Why is that?

When the kubernetes cluster is first setup, a taint is set on the master node automatically that prevents any pods from being scheduled on this node.

You can see this, as well as modify the behaviour, if required.

**However, a best practice is to not deploy application workloads on a master server.**

To see this taint, run a kubectl describe node command with kubemaster as the node name and look for the taint section. You will see the taint set to not schedule any pods on the master node.

```
kubectl describe node kubemaster | grep "Taint"
Taints:   node-role.kubernetes.io/master:NoSchedule
```

### 3. Node Selectors

Let's start with a example. You have 3 node cluster of which two are smaller nodes, with lower hardware resources, and one of them is a larger node configured with higher resources.

You have different kinds of workloads running in your cluster. You would like to dedicate the data processing workloads that require higher horsepower to the larger node as that is the only node that will not run out of resources in case the job demands extra resources.

However, in the current default setup, **any pods can go to any nodes**.
So, Pod C in this case, may very well endup on the nodes two or threee, which is not desired.

To solve this, we can set a limitation on the pods so that they only run on particular nodes.

There are two ways to do this.
1. Node Selectors
2. Node Affinity

## Node Selectors - Which is simple and easier method
We look at the pod-definition file we created earlier. This file has a simple definition to create a pod with a data processing image.

pod-definition.yaml
```
apiVesion:
kindL Pod
metadata:
  name: myapp-pod
spec:
  containers:
  - name: data-processor
    image: data-processor
**nodeSelector:**
  **size: Large** 

```
To limit this Pod to run on node A(larger node), we add a new property called **node selector** to the spec section and specify the size as large.

But wait a minute, where did the size large come from, and how does k8s know which is the large node?

The key value pair of size and large are in fact labels assigned to the nodes.

The scheduler used these labels to match and identity the right node to place the pods on.

Labels and Selectors are a topic we have seen many times throughout this k8s course such as with services, replica sets, anf deployments. To use lables in a node selector like this, you must have labeled your nodes prior to creating this pods.

So, let us go back and see how we can label the nodes

To label a node, use the command kubectl label nodes followd by the name of the node and the label in a key value pair format.
```
kubectl label nodes <node-name> <label-key>=<label-value>
```

In this case, it would be 
```
kubectl label nodes node-1 size=Large
```

Now that we have labeled the node, we can get back to creating the pod.

This time the node selector set to a size of large.

```
kubectl create -f pod-definition.yaml
```
When the pod is now created,  it is placed on node-1 as desired.

## Node Selector - Limitations

Node Selectors have served purpose, but it has limitations. We uses a single label and selector to acheive our goal here. 

- Large or Medium
- Not Small

But what if our requirement is much more complex? For example we would ike to say
something like place the Pod on a large or medium node, or something like place the pod on any nodes that are not small.

You cannot acheive this using node selectors. For this, node affinity and anti-affinity features were introduced and we will look at that next.

### Node Affinity

The primary purpose of node affinity feature is to ensure pods are hosted on particular nodes, in this case to ensure the large data processing pod and ends up on node-1.

In the previous lecture, we did this easily using node selectors.

**We disucssed we cannot provide the advance expressions like OR or NOT with node selectors**

The node affinity feature provides us with the advanced capabilities to limit pod placement on specific nodes.

With great power comes gerat complexity, so the simple node selector specification will now look this with node affinity, although both does exact same thing. Place the pod on the large node.


pod-definition.yaml
```
apiVesion:
kindL Pod
metadata:
  name: myapp-pod
spec:
  containers:
  - name: data-processor
    image: data-processor
**affinity:**
  **nodeAffinity:** 
    **requireDuringSchedulingIgnoreDuringExecution:**  
      **nodeSelectorTerms:**
        - **matchExpressions:**
          - **key: size**
            **operator: In**
            **values:**
            **- Large**
```

Let us look at a bit closer it. Under spec you have affinity and then node affinity under that. And then you have a property that looks like a sentence called, **requireDuringSchedulingIgnoreDuringExecution**. 

And then you have the node selector terms, that is an array and that is where you will specify the key-value pairs.

The key value pairs are in the form of **key, operator, and value**.

Where the operator is in. The IN operator ensure that the pod will be placed on a node whose label size has any **value in the list of values** specified here?

In this case, it is just one called large. If you think your pod could be placed on  a **large or a medium node**, you could simply add the value to the list of values like this.


```
**affinity:**
  **nodeAffinity:** 
    **requireDuringSchedulingIgnoreDuringExecution:**  
      **nodeSelectorTerms:**
        - **matchExpressions:**
          - **key: size**
            **operator: In**
            **values:**
            **- Large**
            **- Medium**
```

You could use the node **IN operator** to say something like, size not in small, where nod affinity will match the nodes with a size not set to small.

```
- **matchExpressions:**
          - **key: size**
            **operator: Not In**
            **values:**
            **- Small**
```

We know that we have only set the label size to large and medium nodes.
The smaller nodes don't even have label set, so we don't really have to even check th value of the label. As long as we are sure we don't set a label size to the smaller node using the exist operator will give us the same result.

The exist operator simply check the lable size exists on the nodes, and you don't need the value section for that as it is not compare the values.

```
- **matchExpressions:**
          - **key: size**
            **operator: Exists**
```

There are number of other operators as well. Check the documentation for specific details.

Now we understand all of this and we're comfortablle with creating a pod with specific affinity rules. 

When the pods are created, these rules are considered and the pods are placed are placed onto the right nodes.

**But what if node affinity could not match a node with a given expression?**

In this case, what if there are no nodes with the lable called size?

**Say we had the labels and the pods are scheduled. What if someone changes the label on the node at a future point in time?**

will the pod continue to staty on the node?

All of this is answered by long sentence like property under node affinity, which happens to be the **type of node affinity.**

## Node Affinity Types
```
- Available:
  - requiredDuringSchedulingIgnoredDuringExecution
  - preferredDuringSchedulingIgnoredDuringExecution

- Planned:
  - requiredDuringSchedulingRequiredDuringExecution
```
The type of affinity defines the behaviour of the scheduler with respect to node affinity and the stages in the life cycle of the pod.

There are currently two types of the node affinity available,
  - requiredDuringSchedulingIgnoredDuringExecution
  - preferredDuringSchedulingIgnoredDuringExecution

And there arre addition types of node affinity planned:
- requiredDuringSchedulingRequiredDuringExecution 


We will not break this down to understand further.

We will start by looking, at the two avaiable affinity types.

There are 2 states in the lifecycle of pods, when considering node affinity, during scheduling and during execution

| | During Scheduling | During Execution |


During Scheduling is the state where a pod doesn't exist and is created for the first time.








### Important Commands:
```
kubectl run --restart=Never --image=busybox static-busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-busybox.yaml
```



ETCDCTL_API=3 etcdctl --endpoints=https://192.168.100.160:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db

Snapshot saved at /opt/snapshot-pre-boot.db
root@controlplane:~#




root@controlplane:~# ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db


2022-03-25 09:19:27.175043 I | mvcc: restore compact to 2552
2022-03-25 09:19:27.266709 I | etcdserver/membership: added member 8e9e05c52164694d [http://localhost:2380] to cluster cdf818194e3a8c32
root@controlplane:~#


  volumes:
  - hostPath:
      path: /var/lib/etcd-from-backup
      type: DirectoryOrCreate
    name: etcd-data


watch "crictl ps | grep etcd"








