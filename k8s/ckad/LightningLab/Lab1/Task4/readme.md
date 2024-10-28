Create a new deployment called nginx-deploy, with one single container called nginx, image nginx:1.16 and 4 replicas.
The deployment should use RollingUpdate strategy with maxSurge=1, and maxUnavailable=2.

Next upgrade the deployment to version 1.17.
Finally, once all pods are updated, undo the update and go back to the previous version.
Deployment created correctly?
Was the deployment created with nginx:1.16?
Was it upgraded to 1.17?
Deployment rolled back to 1.16?

### Ans
1) kubectl create deployment nginx-deploy --image=nginx:1.16 --replicas=4

kubectl get deployments
kubectl rollout status deployment/nginx-deploy
kubectl rollout history deployment/nginx-deploy
kubectl describe deployment nginx-deploy
As maxsurege and maxunavailabble already configured same as defined in the request, we dont need to modify. keep as it is.

Also verify the Container image set it as nginx:1.16


2) 

kubectl set image deployment/nginx-deploy nginx=nginx:1.17
kubectl rollout status deployment nginx-deploy
kubectl rollout history deployment/nginx-deploy

kubectl annotate

kubectl describe deployment nginx-deploy
Also verify the Container image set it as nginx:1.17

3) Deployment rollback to prev version

kubectl rollout undo deployment nginx-deploy
kubectl rollout status deployment/nginx-deploy
kubectl describe deployment nginx-deploy
Verify the Container image set back to nginx:1.16
kubectl rollout history deployment/nginx-deploy
kubectl rollout history deployment/nginx-deploy --revision=2  => To get more details about the specific revision


### Note the deployment

Annotate 

kubectl annotate deployment/nginx-deploy kubernetes.io/change-cause="image rollbacked to 1.17.1"

Alternatively, you can rollback to a specific revision by specifying it with --to-revision:

kubectl rollout undo deployment/nginx-deploy --to-revision=3
kubectl rollout history deployment/nginx-deploy --revision=3