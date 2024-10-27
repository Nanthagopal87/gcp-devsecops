
Step 3: Create a New Maven Project
### Step 1: Configure Authentication for GCP Artifact Registry
a) Authenticate with gcloud (if not already authenticated):
gcloud auth application-default login

b) Set up the Artifact Registry credentials in your ~/.m2/settings.xml file:

<servers>
    <server>
        <id>artifact-registry</id>
        <username>oauth2accesstoken</username>
        <password>${env.GOOGLE_OAUTH_ACCESS_TOKEN}</password>
    </server>
</servers>

c) Export the GOOGLE_OAUTH_ACCESS_TOKEN:
export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token)

### Step 2: Create a New Maven Project

1) Generate a new Maven project using the Maven archetype command:

mvn archetype:generate -DgroupId=com.example -DartifactId=my-library -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

2) Navigate into the project directory:
cd my-library

### Step 3: Update pom.xml to Include GCP Artifact Registry

<distributionManagement>
    <repository>
        <id>artifact-registry</id>
        <url>https://us-central1-maven.pkg.dev/YOUR_PROJECT/YOUR_REPO_NAME</url>
    </repository>
</distributionManagement>

### Step 6: Build and Deploy the Library to Artifact Registry

1) Build the project:
mvn clean install

2) Deploy the library to your Artifact Registry repository:
mvn deploy

This will push your library to GCP Artifact Registry. Make sure to verify the artifact upload in the GCP console under Artifact Registry.





### Code Labs
https://codelabs.developers.google.com/dependency-management-artifact-registry#2