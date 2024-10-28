Build a highly available Redis Cluster based on the given architecture diagram.

Click on each icon to see more details. Once done click on the Check button to test your work.

### redis01
- PersistentVolume - Name: redis01
- Access modes: ReadWriteOnce
- Size: 1Gi
- hostPath: /redis01, directory should be created on worker node

### redis02
- Access modes: ReadWriteOnce
- Size: 1Gi
- hostPath: /redis02, directory should be created on worker node

### redis-cluster-config

- Ports - service name 'redis-cluster-service', port name: 'gossip', port: '16379'
- Ports - service name 'redis-cluster-service', port name: 'client', targetPort: '6379'
- Ports - service name 'redis-cluster-service', port name: 'gossip', targetPort: '16379'

### redis-cluster

- PersistentVolume - Name: redis01
- Replicas: 6
- Pods status: Running (All 6 replicas)
- Image: redis:5.0.1-alpine, Label = app: redis-cluster
- container name: redis, command: ["/conf/update-node.sh", "redis-server", "/conf/redis.conf"]
- Env: name: 'POD_IP', valueFrom: 'fieldRef', fieldPath: 'status.podIP' (apiVersion: v1)

Ports - name: 'client', containerPort: '6379'
Ports - name: 'gossip', containerPort: '16379'

Volume Mount - name: 'conf', mountPath: '/conf', readOnly:'false' (ConfigMap Mount)
Volume Mount - name: 'data', mountPath: '/data', readOnly:'false' (volumeClaim)

volumes - name: 'conf', Type: 'ConfigMap', ConfigMap Name: 'redis-cluster-configmap',
Volumes - name: 'conf', ConfigMap Name: 'redis-cluster-configmap', defaultMode = '0755'

volumeClaimTemplates - name: 'data'
volumeClaimTemplates - accessModes: 'ReadWriteOnce'
volumeClaimTemplates - Storage Request: '1Gi'

