#!/bin/bash

# Set variables
PROJECT_ID="your-gcp-project-id"               # Replace with your GCP project ID
REPO_NAME="your-maven-repo"                    # Replace with your Artifact Registry Maven repo name
LOCATION="us-central1"                         # Replace with your Artifact Registry location
PACKAGE_GROUP="com.example"                    # Replace with your package group name (e.g., com.example)
DEPENDENCY_LIST="dependencies.txt"             # Text file listing Maven dependencies

# Authenticate with gcloud if not already authenticated
gcloud auth login
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
mkdir -p downloaded-dependencies

while IFS= read -r dependency; do
    echo "Processing dependency: $dependency"

    # Download the dependency to the local repository
    mvn dependency:get -Dartifact=$dependency -Ddest=downloaded-dependencies

    # Push the downloaded dependency to Artifact Registry
    mvn deploy:deploy-file \
        -Dfile=downloaded-dependencies/$(echo $dependency | tr ':' '/')/$(echo $dependency | awk -F':' '{print $3}')/$(echo $dependency | tr ':' '-')-$(echo $dependency | awk -F':' '{print $3}').jar \
        -DgroupId=$(echo $dependency | awk -F':' '{print $1}') \
        -DartifactId=$(echo $dependency | awk -F':' '{print $2}') \
        -Dversion=$(echo $dependency | awk -F':' '{print $3}') \
        -Dpackaging=jar \
        -DrepositoryId=gcp-artifact-registry \
        -Durl=https://$LOCATION-maven.pkg.dev/$PROJECT_ID/$REPO_NAME

    echo "Pushed $dependency to Artifact Registry"
done < "$DEPENDENCY_LIST"

echo "All dependencies processed."