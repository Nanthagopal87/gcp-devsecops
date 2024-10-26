#!/bin/bash

LIB_DIR="./plugins" # Path to your plugins directory
REPO_URL="https://asia-south1-maven.pkg.dev/YOUR_PROJECT_ID/YOUR_REPOSITORY_NAME"

# Loop through JAR files in the plugins directory
find "$LIB_DIR" -type f -name "*.jar" | while read -r plugin; do
    # Extracting artifactId and version from the folder structure
    # Assuming the structure is: plugins/groupId/artifactId/version/artifactId-version.jar

    RELATIVE_PATH=$(dirname "${plugin#$LIB_DIR/}")
    
    IFS='/' read -r -a PATH_ARRAY <<< "$RELATIVE_PATH"
    
    groupId=$(echo "${PATH_ARRAY[@]:0:${#PATH_ARRAY[@]}-2}" | tr '/' '.')
    artifactId="${PATH_ARRAY[-2]}"
    version="${PATH_ARRAY[-1]}"

    # Deploy the plugin
    mvn deploy:deploy-file \
        -DgroupId="$groupId" \
        -DartifactId="$artifactId" \
        -Dversion="$version" \
        -Dpackaging=maven-plugin \
        -Dfile="$plugin" \
        -DrepositoryId=artifact-registry \
        -Durl="$REPO_URL"

    if [ $? -eq 0 ]; then
        echo "Successfully uploaded $artifactId version $version"
    else
        echo "Failed to upload $artifactId version $version"
    fi
done
