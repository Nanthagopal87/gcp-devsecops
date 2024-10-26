Failed to retrieve remote metadata com.example:my-library:1.0-SNAPSHOT/maven-metadata.xml: Could not transfer metadata com.example:my-library:1.0-SNAPSHOT/maven-metadata.xml from/to artifact-registry


Soln:

Step 1: Try a Release Version Instead of a SNAPSHOT

Alternative:

Step 2: Manually Generate and Deploy the Metadata File
mvn clean install

This places the metadata file in your local .m2 repository (e.g., ~/.m2/repository/com/example/demo-project/1.0-SNAPSHOT/maven-metadata.xml).

Upload maven-metadata.xml to Artifact Registry: Use curl to upload the metadata file to your Artifact Registry. Replace the path with your own project and repo details:

curl -X PUT -T ~/.m2/repository/com/example/demo-project/1.0-SNAPSHOT/maven-metadata.xml \
    -H "Authorization: Bearer $GOOGLE_OAUTH_ACCESS_TOKEN" \
    "https://asia-south1-maven.pkg.dev/devops-438202/maven-repo/com/example/demo-project/1.0-SNAPSHOT/maven-metadata.xml"

Deploy the SNAPSHOT Version Again: After uploading the metadata file, try redeploying the SNAPSHOT version:

mvn deploy
