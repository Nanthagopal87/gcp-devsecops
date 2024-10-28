#!/bin/bash

# Set variables
PROJECT_ID="devops-438202"                     # Replace with your GCP project ID
REPO_NAME="maven-repo"                         # Replace with your Artifact Registry Maven repo name
LOCATION="asia-south1"                         # Replace with your Artifact Registry location

LIB_DIR="../downloaded-dependencies" # Path to your lib directory
#REPO_URL="https://asia-south1-maven.pkg.dev/devops-438202/maven-repo"
REPO_URL=https://$LOCATION-maven.pkg.dev/$PROJECT_ID/$REPO_NAME

# Loop through JAR files in the lib directory
find "$LIB_DIR" -type f -name "*.jar" | while read -r jar; do
    # Extracting artifactId and version from the folder structure
    # Assuming the structure is: lib/groupId/artifactId/version/artifactId-version.jar
    # E.g., lib/com/example/my-lib/1.0.0/my-lib-1.0.0.jar

    echo ${jar}

    #exit 1;
    # Get the relative path
    RELATIVE_PATH=$(dirname "${jar#$LIB_DIR/}")
    
    # Split the relative path
    IFS='/' read -r -a PATH_ARRAY <<< "$RELATIVE_PATH"
    
    # Extract groupId, artifactId, and version
    groupId=$(echo "${PATH_ARRAY[@]:0:${#PATH_ARRAY[@]}-2}" | tr '/' '.')
    artifactId="${PATH_ARRAY[-2]}"
    version="${PATH_ARRAY[-1]}"
    
    echo ${groupId}:${artifactId}:${version}

    #exit 1;
    # Deploy the JAR file
    mvn org.apache.maven.plugins:maven-deploy-plugin:3.1.1:deploy-file -f pom.xml -Dfile=${jar} \
    -DgroupId=$groupId \
    -DartifactId=$artifactId \
    -Dversion=$version \
    -Dpackaging=jar \
    -DrepositoryId=gcp-artifact-registry \
    -Durl=https://$LOCATION-maven.pkg.dev/$PROJECT_ID/$REPO_NAME

    # mvn deploy:deploy-file \
    #     -DgroupId="$groupId" \
    #     -DartifactId="$artifactId" \
    #     -Dversion="$version" \
    #     -Dpackaging=jar \
    #     -Dfile="$jar" \
    #     -DrepositoryId=artifact-registry \
    #     -Durl="$REPO_URL"

    # if [ $? -eq 0 ]; then
    #     echo "Successfully uploaded $artifactId version $version"
    # else
    #     echo "Failed to upload $artifactId version $version"
    # fi
done
