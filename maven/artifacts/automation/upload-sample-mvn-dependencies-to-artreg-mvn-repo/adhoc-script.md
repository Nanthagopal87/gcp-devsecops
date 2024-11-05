```
#!/bin/bash

# Set variables
PROJECT_ID="devops-438202"                     # Replace with your GCP project ID
REPO_NAME="maven-repo"                         # Replace with your Artifact Registry Maven repo name
LOCATION="asia-south1"                         # Replace with your Artifact Registry location
PACKAGE_GROUP="com.example"                    # Replace with your package group name (e.g., com.example)
#DEPENDENCY_LIST="../dependencies-list/dependencies.txt"             # Text file listing Maven dependencies
DEPENDENCY_LIST="../dependencies-list/spring-boot-dependencies.txt"             # Text file listing Maven dependencies
#DEPENDENCY_LIST="../dependencies-list/sample.txt"             # Text file listing Maven dependencies

#cat $DEPENDENCY_LIST
#exit 1
DOWNLOAD_FOLDER="../downloaded-dependencies"
#echo ${DOWNLOAD_FOLDER}
#exit 1;


# Authenticate with gcloud if not already authenticated
#gcloud auth login
gcloud config set project $PROJECT_ID

# Enable the Artifact Registry API if not enabled
gcloud services enable artifactregistry.googleapis.com

# Log into Artifact Registry for Docker (required to push packages)
gcloud auth configure-docker $LOCATION-docker.pkg.dev

# Create the Maven repo if it doesn't exist
gcloud artifacts repositories create $REPO_NAME \
  --repository-format=maven \
  --location=$LOCATION \
  --description="Maven repository for dependencies"

# Read dependencies from file and download them to the local repository
# Each line in the file should be in the format: groupId:artifactId:version
#mkdir -p downloaded-dependencies
mkdir -p ${DOWNLOAD_FOLDER}



while IFS= read -r dependency; do
    echo "Processing dependency: $dependency"

    # Set variables to handle artifact details
    groupId=$(echo $dependency | awk -F':' '{print $1}')
    artifactId=$(echo $dependency | awk -F':' '{print $2}')
    version=$(echo $dependency | awk -F':' '{print $3}')
    artifactPath="$groupId/$artifactId/$version"

    # Download the dependency to the local repository
    #mvn dependency:get -Dartifact=$dependency -Ddest=downloaded-dependencies
    #mvn dependency:get -Dartifact=$dependency -Ddest=${DOWNLOAD_FOLDER}

    # Download the dependency to the local repository
    #mvn dependency:get -Dartifact=$dependency

    # Copy the dependency to the specific folder
    mvn dependency:copy \
        -Dartifact=$dependency \
        -DoutputDirectory=${DOWNLOAD_FOLDER}/$artifactPath

    # Specify the correct path to the jar file
jarFile="${DOWNLOAD_FOLDER}/$groupId/$artifactId/$version/$artifactId-$version.jar"
#jarFile="automation/downloaded-dependencies/$groupId/$artifactId/$version/$artifactId-$version.jar"
echo "jar-file:"$jarFile

#exit 1;

#exit 1;
    # Push the downloaded dependency to Artifact Registry
    # mvn deploy:deploy-file \
    #     -Dfile=${DOWNLOAD_FOLDER}/$(echo $dependency | tr ':' '/')/$(echo $dependency | awk -F':' '{print $3}')/$(echo $dependency | tr ':' '-')-$(echo $dependency | awk -F':' '{print $3}').jar \
    #     -DgroupId=$(echo $dependency | awk -F':' '{print $1}') \
    #     -DartifactId=$(echo $dependency | awk -F':' '{print $2}') \
    #     -Dversion=$(echo $dependency | awk -F':' '{print $3}') \
    #     -Dpackaging=jar \
    #     -DrepositoryId=gcp-artifact-registry \
    #     -Durl=https://$LOCATION-maven.pkg.dev/$PROJECT_ID/$REPO_NAME

    # mvn org.apache.maven.plugins:maven-deploy-plugin:3.1.1:deploy-file -f pom.xml -Dfile=$jarFile \
    #mvn deploy:deploy-file -f pom.xml -Dfile=$jarFile \
    mvn org.apache.maven.plugins:maven-deploy-plugin:3.1.1:deploy-file -f pom.xml -Dfile=$jarFile \
    -DgroupId=$groupId \
    -DartifactId=$artifactId \
    -Dversion=$version \
    -Dpackaging=jar \
    -DrepositoryId=gcp-artifact-registry \
    -Durl=https://$LOCATION-maven.pkg.dev/$PROJECT_ID/$REPO_NAME

    echo "Pushed $dependency to Artifact Registry"
done < "$DEPENDENCY_LIST"

echo "All dependencies processed"
```