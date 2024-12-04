### 1. Library Information
```
curl -v - H "Authorization: Bearer $(gcloud auth print-access-token)"
https://asia-south1-maven.pkg.dev/devops-438202/maven-mirror-repo

com.fasterxml.jackson.core:jackson-core
2.12.2
jackson-core-2.12.2.jar 

com/fasterxml/jackson/core/jackson-core/2.12.2/jackson-core-2.12.2.jar

https://asia-south1-maven.pkg.dev/devops-438202/maven-mirror-repo/com/fasterxml/jackson/core/jackson-core/2.12.2/jackson-core-2.12.2.jar
```


### 2. Trying to download the file from Local Machhine using CURL and WGET commands

```
wget --header "Authorization: Bearer $(gcloud auth print-access-token)" \
https://asia-south1-maven.pkg.dev/devops-438202/maven-mirror-repo/com/fasterxml/jackson/core/jackson-core/2.12.2/jackson-core-2.12.2.jar
```

### Need to use -L as there is many redirecct happens, without -L the file is not downloaded
```
curl -L -o demo.jar -H "Authorization: Bearer $(gcloud auth print-access-token)" -o jackson-core-2.12.2.jar https://asia-south1-maven.pkg.dev/devops-438202/maven-mirror-repo/com/fasterxml/jackson/core/jackson-core/2.12.2/jackson-core-2.12.2.jar
```

```
curl -v -k -L --retry 3 --retry-delay 5 --max-time 30 -H "Authorization: Bearer $(gcloud auth print-access-token)" -o jackson-core-2.12.2.jar https://asia-south1-maven.pkg.dev/devops-438202/maven-mirror-repo/com/fasterxml/jackson/core/jackson-core/2.12.2/jackson-core-2.12.2.jar
```
