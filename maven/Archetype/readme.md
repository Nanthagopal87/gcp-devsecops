### 1. Create a maven project using mvn archetype with default settings

```
mvn archetype:generate \
-DgroupId=com.example \
-DartifactId=maven-demo \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DinteractiveMode=false
```

### 2. Create a maven project using advance settings

```
mvn -X archetype:generate \
    -DgroupId=com.example \
    -DartifactId=maven-demo1 \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DarchetypeCatalog=local \
    -DarchetypeRepository=https://asia-south1-maven.pkg.dev/devops-438302/maven-repo
```

### NOTE:
   - Removed -DinteractiveMode=false
   - Added -DarchetypeRepository
   - Added -DarchetypeCatalog


### 3. 