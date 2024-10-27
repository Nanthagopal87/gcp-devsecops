### 1. Configure Maven to pull the dependency from Artifact Registry Maven Repo

You can get this information from
```
GCP console->Artifact Repo->Select Librrary->Setup Information
```
```
gcloud artifacts print-settings mvn \
    --project=devops-438202 \
    --repository=maven-repo \
    --location=asia-south1
```
Result:
```
<!-- Insert following snippet into your pom.xml -->

<project>
  <distributionManagement>
    <snapshotRepository>
      <id>artifact-registry</id>
      <url>artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-repo</url>
    </snapshotRepository>
    <repository>
      <id>artifact-registry</id>
      <url>artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-repo</url>
    </repository>
  </distributionManagement>

  <repositories>
    <repository>
      <id>artifact-registry</id>
      <url>artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-repo</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>true</enabled>
      </snapshots>
    </repository>
  </repositories>

  <build>
    <extensions>
      <extension>
        <groupId>com.google.cloud.artifactregistry</groupId>
        <artifactId>artifactregistry-maven-wagon</artifactId>
        <version>2.2.0</version>
      </extension>
    </extensions>
  </build>
</project>
```
### 2. Can  distributionmanagment and repositories  urls be different?

Yes, the distributionManagement and repositories URLs in Maven can be different, and they serve distinct purposes:

### DistributionManagement Tag:
```
Used specifically for deployment, which means it defines where Maven should publish your built artifacts, like JARs, to a remote repository.

Typical in scenarios where you want to upload artifacts to a central or private repository (e.g., deploying your library or application to Artifact Registry or a Nexus/Artifactory repository).
```

### Repositories Tag
 
```
Defines locations from where Maven will download dependencies (libraries and plugins) that your project needs during the build process.

Useful for pointing Maven to repositories that contain dependencies not available in Maven Central, such as internal libraries or plugins stored in a company’s Artifact Registry.
```
# Example Configuration

If you need to define both, your pom.xml might look like this:

```
<repositories>     ===> Download
    <repository>
        <id>artifact-registry-repo</id>
        <url>https://asia-south1-maven.pkg.dev/my-project/dependencies-repo</url>
    </repository>
</repositories>
```
```
<distributionManagement>  ==> Publish
    <repository>
        <id>artifact-registry-deploy</id>
        <url>https://asia-south1-maven.pkg.dev/my-project/deploy-repo</url>
    </repository>
</distributionManagement>
```
In this setup:

    - Maven will download dependencies from https://asia-south1-maven.pkg.dev/my-project/dependencies-repo.

    - Maven will deploy artifacts to https://asia-south1-maven.pkg.dev/my-project/deploy-repo.

    This flexibility is useful when organizations use separate repositories for managing dependencies and deploying internal builds or releases.


### 3. Can we download libraries/dependencies from Multiple Artifact Repo?

Ans: Yes, under <repositories> tag you can add <repository> tag as much as possible

Bellow is the eample of 2 repository

```
<repositories>
    <repository>
      <id>artifact-registry</id>
      <url>artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-repo</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>true</enabled>
      </snapshots>
    </repository>
    
    <repository>
      <id>artifact-registry-1</id>
      <url>artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-library</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>true</enabled>
      </snapshots>
    </repository>
    
  </repositories>
```


### 5. How to modify Access Token in settings.xml

1) Case1: 
```
settings.xml
<password>${env.GOOGLE_CLOUD_ACCESS_TOKEN}</password>
```

Soln:
```
export GOOGLE_CLOUD_ACCESS_TOKEN=$(gcloud auth print-access-token)
```

2) Case 2:
```
settings.xml
<password>YOUR_OAUTH_ACCESS_TOKEN</password>
```
Soln:
```
ACCESS_TOKEN=$(gcloud auth print-access-token)
sed -i "s|<password>.*</password>|<password>${ACCESS_TOKEN}</password>|" ~/.m2/settings.xml
```