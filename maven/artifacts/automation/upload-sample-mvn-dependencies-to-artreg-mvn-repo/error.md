
### 1. pom.xml not exist
```
[ERROR] [ERROR] Some problems were encountered while processing the POMs:
[FATAL] Non-readable POM /home/nanthaagadevops/automation/pom.xml: /home/nanthaagadevops/automation/pom.xml (No such file or directory) @ 
 @ 
[ERROR] The build could not read 1 project -> [Help 1]
[ERROR]   
[ERROR]   The project  (/home/nanthaagadevops/automation/pom.xml) has 1 error
[ERROR]     Non-readable POM /home/nanthaagadevops/automation/pom.xml: /home/nanthaagadevops/automation/pom.xml (No such file or directory)
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/ProjectBuildingException
```

Soln:  Add pom.xml with minimum template
```
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- Project coordinates -->
    <groupId>your.group.id</groupId>
    <artifactId>your-artifact-id</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <name>Your Project Name</name>
    <description>A sample project for Maven configuration</description>
    
</project>
```

### 2. status code: 401, reason phrase: Unauthorized (401)
Error
```
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.551 s
[INFO] Finished at: 2024-10-27T22:02:15+05:30
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-deploy-plugin:3.1.1:deploy-file (default-cli) on project your-artifact-id: Failed to deploy artifacts: Could not transfer artifact junit:junit:jar:4.13.2 from/to gcp-artifact-registry (https://asia-south1-maven.pkg.dev/devops-438202/maven-repo): status code: 401, reason phrase: Unauthorized (401) -> [Help 1]
```
Soln 1:
```
check settings.xml <id>artifact-registry</id>  as same as defined in pom.xml
```

soln 2:
```
Check auth is expired
```