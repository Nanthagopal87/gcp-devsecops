### 1. Compare Maven Artifacts vs Plugins vs Archetype

### 2. Can we store maven plugins in GCP artifact maven repo

### 3. In Local machine, access maven plugins from Artifact Registry maven repo  instead of repo.maven

### 4. How to modify a manually created Maven project into a Spring Boot project,

 you need to follow several steps to add the necessary dependencies, plugins, and configuration files. Here’s a step-by-step guide on how to do this:

### 5. While creating maven project, whether it will access repo.maven

Yes, when you execute the command to generate a Maven project using the mvn archetype:generate command, Maven will access the configured repositories to download the required archetype and its dependencies. By default, this includes Maven Central (https://repo.maven.apache.org/maven2) unless you have configured additional repositories or overridden the default settings in your settings.xml.


### 6. In Local machine, access maven archetype from Artifact Registry maven repo  instead of repo.maven


### 7. Oct 27, 2024 11:17:19 PM com.google.auth.oauth2.DefaultCredentialsProvider warnAboutProblematicCredentials
```
WARNING: Your application has authenticated using end user credentials from Google Cloud SDK. We recommend that most server applications use service accounts instead. If your application continues to use end user credentials from Cloud SDK, you might receive a "quota exceeded" or "API not enabled" error. For more information about service accounts, see https://cloud.google.com/docs/authentication/.
```
#

### FAQ-4

# Step 1: Create a Basic Maven Project
```
mvn archetype:generate -DgroupId=com.example -DartifactId=my-spring-boot-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

# Step 2: Update pom.xml

a) Add Spring boot dependencies
```
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <scope>runtime</scope>
        <optional>true</optional>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

b) Add Spring Boot Plugins  (optional)

```
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <version>3.1.3</version> <!-- Use the latest version -->
            <executions>
                <execution>
                    <goals>
                        <goal>repackage</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

3. Add Parent POM

```
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.1.3</version> <!-- Use the latest version -->
    <relativePath/> <!-- lookup parent from repository -->
</parent>
```

# Step 3: Create the Main Application Class

Create a new Java class in src/main/java/com/example (or your chosen package structure) to serve as the main application class. For example, create a file named MySpringBootApplication.java with the following content:

```
package com.example; // Change this to match your package structure

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MySpringBootApplication {
    public static void main(String[] args) {
        SpringApplication.run(MySpringBootApplication.class, args);
    }
}
```

# Step 4: Create Application Properties File

Create a configuration file named application.properties in src/main/resources to customize your Spring Boot application settings. For example:
```
server.port=8080
spring.application.name=my-spring-boot-app
```

Step 5: Run Your Application

You can now run your Spring Boot application using Maven:
```
mvn spring-boot:run
```

Summary

You’ve now successfully converted a basic Maven project into a Spring Boot project. This includes setting up the necessary dependencies, a main application class, and application properties. You can expand your project further by adding more Spring Boot features and dependencies as needed.
