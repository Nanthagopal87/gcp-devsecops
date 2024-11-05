```
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

    <servers>
        <server>
            <id>gcp-artifact-registry</id>
            <username>oauth2accesstoken</username> <!-- For Google Cloud, use this -->
            <password>YOUR_OAUTH_ACCESS_TOKEN</password> <!-- This can be empty if using application default credentials -->
        </server>
    </servers>
</settings>

```