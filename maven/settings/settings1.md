```
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

    <activeProfiles>
        <activeProfile>gcp-artifact-registry</activeProfile>
    </activeProfiles>

    <profiles>
        <profile>
            <id>gcp-artifact-registry</id>
            <repositories>
                <repository>
                    <id>gcp-artifact-registry</id>
                    <url>https://asia-south1-maven.pkg.dev/YOUR_PROJECT_ID/YOUR_REPOSITORY_NAME</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                </repository>
            </repositories>
        </profile>
    </profiles>

    <servers>
        <server>
            <id>gcp-artifact-registry</id>
            <username>oauth2accesstoken</username> <!-- For Google Cloud, use this -->
            <password>YOUR_OAUTH_ACCESS_TOKEN</password> <!-- This can be empty if using application default credentials -->
        </server>
    </servers>
</settings>

```