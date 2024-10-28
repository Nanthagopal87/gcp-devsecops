
This 2-Node Kubernetes cluster is broken! Troubleshoot, fix the cluster issues and then deploy the objects according to the given architecture diagram to unlock our Image Gallery!!

Click on each icon (including arrows) to see more details. Once done click on Check button to test your work.


### Copy Files

Copy all images from the directory '/media' on the controlplane node to '/web' directory on node01

### PV 
- Create new PersistentVolume = 'data-pv'
- PersistentVolume = data-pv, accessModes = 'ReadWriteMany'
- PersistentVolume = data-pv, hostPath = '/web'
- PersistentVolume = data-pv, storage = '1Gi'

### PVC
- Create new PersistentVolumeClaim = 'data-pvc'
- PersistentVolume = 'data-pvc', accessModes = 'ReadWriteMany'
- PersistentVolume = 'data-pvc', storage request = '1Gi'
- PersistentVolume = 'data-pvc', volumeName = 'data-pv

### Pod
- pod: gop-file-server volumeMount name: 'data-store'
- pod: gop-file-server persistent volume name: data-store
- pod: gop-file-server persistent volume claim used: 'data-pvc'

### Service
- New Service, name: 'gop-fs-service'
- Service name: gop-fs-service, port: '8080'
- Service name: gop-fs-service, targetPort: '8080'
