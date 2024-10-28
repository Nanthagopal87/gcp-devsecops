### 1. Write a script to download the maven dependencies from maven repo and push the dependencies to Artifact Registry maven repo

To download dependencies from the Maven repository and push them to Google Artifact Registry's Maven repository, you can use a Bash script that handles both the downloading and pushing steps. Here’s how you can do it:

## Requirements

    gcloud CLI: Ensure gcloud is configured to authenticate with your Google Cloud account.
    Maven: For downloading dependencies, Maven needs to be installed.
    Environment Variables:
        Replace placeholder values with your actual GCP project ID, Artifact Registry Maven repo name, and region.

## Explanation

    gcloud Setup: Configures authentication and project settings.
    Artifact Registry Repo Creation: Creates a Maven repository in Artifact Registry if it doesn’t exist.
    Dependencies File: This script reads dependencies from a file (dependencies.txt), where each dependency is specified in the format groupId:artifactId:version.
    Dependency Download: Uses mvn dependency:get to download each dependency.
    Dependency Upload: Deploys each dependency to the Artifact Registry repository using mvn deploy:deploy-file.

### Notes

    Be sure Maven’s settings.xml file is configured for Artifact Registry credentials.
    This script handles only .jar dependencies; you may need adjustments for other artifact types.

Would you like further customization for this script, like additional error handling or support for a wider range of artifact formats?

### dependencies.txt

Here's an example dependencies.txt file for your Maven dependencies. Each line follows the format groupId:artifactId:version.

`
org.springframework:spring-core:5.3.21
org.apache.commons:commons-lang3:3.12.0
com.google.guava:guava:31.0.1-jre
org.slf4j:slf4j-api:1.7.32
junit:junit:4.13.2
`

Each line represents a Maven artifact:
```
    groupId: Typically identifies the organization or project (e.g., org.springframework).
    artifactId: Identifies the library or module (e.g., spring-core).
    version: Specifies the version of the dependency (e.g., 5.3.21).
```
Make sure to customize this list with the dependencies required by your project.


### Step 1: Steps to Use an Access Token in Maven

    Generate an Access Token:
        Use the gcloud command to generate an access token:
```
    export GOOGLE_CLOUD_ACCESS_TOKEN=$(gcloud auth print-access-token)

```
### Step 2: Update settings.xml with Access Token:

    In settings.xml, configure the server with the access token by setting the username as oauth2accesstoken and placing the ACCESS_TOKEN as the password:
```
<servers>
    <server>
        <id>gcp-artifact-registry</id>
        <username>oauth2accesstoken</username>
        <password>YOUR_ACCESS_TOKEN</password>  or       <password>${env.GOOGLE_CLOUD_ACCESS_TOKEN}</password>

    </server>
</servers>
```
### Step 3: Run Maven Commands with the Access Token:

Replace YOUR_ACCESS_TOKEN in settings.xml with the actual token. If you want to automate this step, you could use environment variables and a dynamic token replacement.

### Step 3: Automate Token Replacement (optional):
```
ACCESS_TOKEN=$(gcloud auth print-access-token)
sed -i "s|<password>.*</password>|<password>${ACCESS_TOKEN}</password>|" ~/.m2/settings.xml

or 
export GOOGLE_CLOUD_ACCESS_TOKEN=$(gcloud auth print-access-token)
```
Using the Access Token Dynamically

Using the token this way means you won’t have to embed permanent credentials, which enhances security, especially in CI/CD pipelines where tokens can be generated per build.


### Step 4: Clear Local Maven Repository Cache

Sometimes Maven’s local repository cache can get corrupted, especially if downloads were interrupted. Deleting the specific plugin folder can force Maven to re-download it.
```
rm -rf ~/.m2/repository/org/apache/maven/plugins/maven-deploy-plugin
```

After removing the folder, try running the mvn deploy:deploy-file command again.

These steps should help Maven locate and execute the deploy-file goal successfully. Let me know if the issue persists or if you see a specific error after these changes.


### Appendix


Processing dependency: junit:junit:4.13.2
groupId: junit
artifactId: junit
version: 4.13.2
artifactPath: junit/junit/4.13.2

mvn org.apache.maven.plugins:maven-deploy-plugin:3.1.1:deploy-file -f pom.xml -Dfile=downloaded-dependencies/junit/junit/4.13.2/junit-4.13.2.jar \
    -DgroupId=junit \
    -DartifactId=junit \
    -Dversion=4.13.2 \
    -Dpackaging=jar \
    -DrepositoryId=gcp-artifact-registry \
    -Durl=https://asia-south1-maven.pkg.dev/devops-438202/maven-repo


### List of Maven Plugins

cd ~/.m2/repository/org/apache/maven/plugins/maven-deploy-plugin/
ls

maven-antrun-plugin      maven-help-plugin                maven-release-plugin
maven-assembly-plugin    maven-install-plugin             maven-resources-plugin
maven-clean-plugin       maven-jar-plugin                 maven-site-plugin
maven-compiler-plugin    maven-metadata-central.xml       maven-surefire-plugin
maven-dependency-plugin  maven-metadata-central.xml.sha1  resolver-status.properties
maven-deploy-plugin      maven-plugins