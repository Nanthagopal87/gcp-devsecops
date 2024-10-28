Deploy the given architecture to vote namespace.

Click on each icon (including arrows) to see more details. Once done click on Check button to test your work.

### Namespace
Create a new namespace: name = 'vote'

kubectl create ns vote

### vote-deployment

image = 'kodekloud/examplevotingapp_vote:before'

kubectl -n vote create deployment vote-deployment --image=kodekloud/examplevotingapp_vote:before

### vote-service
port = '5000'
targetPort = '80'
nodePort= '31000'
service endpoint exposes deployment 'vote-deployment

kubectl -n vote expose deployment vote-deployment --type=NodePort --port=5000 --target-port=80 --nodePort=31000

kubectl -n vote expose deployment vote-deployment --type=NodePort --port=5000 --target-port=80 --dry-run=client -o yaml >> vote-svc.yaml

add nodeport

### result-deployment

image: 'kodekloud/examplevotingapp_result:before'

kubectl -n vote create deployment result-deployment --image=kodekloud/examplevotingapp_result:before

### result-service

targetPort: '80'
NodePort: '31001'

kubectl expose deployment result-deployment --type=NodePort --port=5000 --targetPort=80 --nodePort=31001

kubectl -n vote expose deployment result-deployment --name result-service --type=NodePort --port=5000 --target-port=80 --nodePort=31001 --dry-run=client -o yaml >> result-svc.yaml

### redis deployment
- image: 'redis:alpine'
- Volume Type: 'EmptyDir'
- Volume Name: 'redis-data'
- mountPath: '/data'
- status: 'Running'

kubectl create deployment redis-deployment --image=redis:alpine

### redis service

port: '6379'
targetPort: '6379'
type: 'ClusterIP'
service endpoint exposes deployment 'redis-deployment

kubectl expose deployment redis-deployment --type=ClusterIp --port=6379 --targetPort=6379

### DB Deployment

image: 'postgres:9.4' and add the env: 'POSTGRES_HOST_AUTH_METHOD=trust'
Volume Type: 'EmptyDir'
Volume Name: 'db-data'
mountPath: '/var/lib/postgresql/data'
status: 'Running'

kubectl create deployment db-deployment --image=postgres:9.4 

### DB Service
port: '5432'
targetPort: '5432'
type: 'ClusterIP'


###
image: 'kodekloud/examplevotingapp_worker'
status: 'Running'


