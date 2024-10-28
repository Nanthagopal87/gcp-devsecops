### PV & PV Claim
- jekyll-site pv is already created. Inspect it before you create the pvc.
- Access modes: ReadWriteMany
- pvc name = jekyll-site, namespace = development
- 'jekyll-site' PVC should be bound to the PersistentVolume called 'jekyll-site'.

### Pod & InitContainer
- pod: 'jekyll', container: 'jekyll', volume name = 'site'
- pod: 'jekyll', container: 'jekyll', mountPath = '/site'
- pod: 'jekyll', container: 'jekyll', image = 'gcr.io/kodekloud/customimage/jekyll-serve'
- pod: 'jekyll', uses volume called 'site' with pvc = 'jekyll-site'
- pod: 'jekyll' uses label 'run=jekyll'

### Service
- Service 'jekyll' uses NodePort: '30097', namespace: 'development'


#### Role
- 'developer-role', should have all(*) permissions for pods in development namespace
- 'developer-role', should have all permissions(*) for persistentvolumeclaims in development namespace

### RoleBindings
- rolebinding = developer-rolebinding associated with user = 'martin'

### Context
set context 'developer' with user = 'martin' and cluster = 'kubernetes' as the current context.

set context 'developer' with user = 'martin' and cluster = 'kubernetes' as the current context.








