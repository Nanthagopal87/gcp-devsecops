
### 1. pom.xml not exist

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


Soln:  Add pom.xml with minimum template

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


### 2. 

