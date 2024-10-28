### Add labels in Node
kubectl label nodes <node-name> <label-key>=<label-value
kubectl label nodes node01 size=Large

### Node Selector in Pod under spec

nodeSelector:
  size: Large

### Node Selector Limitations

- Large or Medium?
- Not Small

That's were Node Affinity concepts get evolved

### Node Affinity
- Pods to Nodes

### Node Affinity Types
    # Available
    reuiredDuringSchedulingIgnoredDuringExecutions
    preferredDuringSchedulingIgnoredDuringExecutions

    # Planned
    reuiredDuringSchedulingRequiredDuringExecutions

### Operator
- In -> need to add values => Refer node-affinity-operator-in-pod-definitions
- Exists  -> Refer node-affinity-operator-exists-pod-definitions


### Node Affinity vs Taints and Tolerants


    
