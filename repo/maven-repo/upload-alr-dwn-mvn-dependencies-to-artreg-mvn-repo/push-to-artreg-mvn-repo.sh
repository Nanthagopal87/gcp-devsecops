#!/bin/bash

LIB_DIR="./lib" # Path to your lib directory
REPO_URL="https://asia-south1-maven.pkg.dev/YOUR_PROJECT_ID/YOUR_REPOSITORY_NAME"

# Loop through JAR files in the lib directory
find "$LIB_DIR" -type f -name "*.jar" | while read -r jar; do
    # Extracting artifactId and version from the folder structure
    # Assuming the structure is: lib/groupId/artifactId/version/artifactId-version.jar
    # E.g., lib/com/example/my-lib/1.0.0/my-lib-1.0.0.jar

    # Get the relative path
    RELATIVE_PATH=$(dirname "${jar#$LIB_DIR/}")
    
    # Split the relative path
    IFS='/' read -r -a PATH_ARRAY <<< "$RELATIVE_PATH"
    
    # Extract groupId, artifactId, and version
    groupId=$(echo "${PATH_ARRAY[@]:0:${#PATH_ARRAY[@]}-2}" | tr '/' '.')
    artifactId="${PATH_ARRAY[-2]}"
    version="${PATH_ARRAY[-1]}"
    
    # Deploy the JAR file
    mvn deploy:deploy-file \
        -DgroupId="$groupId" \
        -DartifactId="$artifactId" \
        -Dversion="$version" \
        -Dpackaging=jar \
        -Dfile="$jar" \
        -DrepositoryId=artifact-registry \
        -Durl="$REPO_URL"

    if [ $? -eq 0 ]; then
        echo "Successfully uploaded $artifactId version $version"
    else
        echo "Failed to upload $artifactId version $version"
    fi
done
