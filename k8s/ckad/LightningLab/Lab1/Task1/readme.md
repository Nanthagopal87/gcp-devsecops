NOTE: "Welcome to the KodeKloud CKAD Lightning Lab - Part 1!"

"You can toggle between the questions but make sure that that you click on END EXAM before the the timer runs out.
While this test environment is valid for 60 minutes, challenge yourself and try to complete all 5 questions within 30 minutes! To pass, correctly complete at least 4 out of 5 questions.Good Luck!!!"


Create a Persistent Volume called log-volume. It should make use of a storage class name manual. It should use RWX as the access mode and have a size of 1Gi. The volume should use the hostPath /opt/volume/nginx

Next, create a PVC called log-claim requesting a minimum of 200Mi of storage. This PVC should bind to log-volume.

Mount this in a pod called logger at the location /var/www/nginx. This pod should use the image nginx:alpine.

log-volume created with correct parameters?

### PV
### PVC
### POD

k run logger --image=nginx:alpine