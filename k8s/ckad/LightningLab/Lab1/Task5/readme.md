Create a redis deployment with the following parameters:

Name of the deployment should be redis using the redis:alpine image. It should have exactly 1 replica.

The container should request for .2 CPU. It should use the label app=redis.

It should mount exactly 2 volumes.

a. An Empty directory volume called data at path /redis-master-data.

b. A configmap volume called redis-config at path /redis-master.

c. The container should expose the port 6379.


The configmap has already been created.

Deployment created correctly?


k create deployment redis --image=redis:alpine --replicas=1 --label=app=redis

k create deployment redis --image=redis:alpine --replicas=1 --label=app=redis --dry-run=client -o yaml

k create deployment redis --image=redis:alpine --replicas=1 --dry-run=client -o yam
l