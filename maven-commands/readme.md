### Maven Commands - https://repo.maven.apache.org/maven2/org/springframework/boot/

1. Check for Available Versions
mvn dependency:list -Dartifact=org.springframework.boot:spring-boot-starter-devtools -DremoteRepositories=https://repo.maven.apache.org/maven2

1. Downoad the dependency and copy the libs to the destination folder

mvn org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
    -DrepoUrl=https://repo.maven.apache.org/maven2 \
    -Dartifact=${GROUP_ID}:${ARTIFACT_ID}:${VERSION} \
    -Dtransitive=false  # Set to true if you need dependencies as well

    e.g
    mvn dependency:copy \
    -Dartifact=junit:junit:4.13.2 \
    -DoutputDirectory=libs/junit/junit/4.13.2

  a) Download junit:junit:4.13.2
    mvn dependency:copy \
    -Dartifact=junit:junit:4.13.2 \
    -Dtransitive=true \
    -DoutputDirectory=libs1/junit/junit/4.13.2

  b) org.springframework.boot:spring-boot-starter:3.1.3
    mvn dependency:copy \
    -Dartifact=org.springframework.boot:spring-boot-starter:3.1.3 \
    -Dtransitive=true \
    -DoutputDirectory=libs2/org.springframework.boot/spring-boot-starter/3.1.3

c) org.springframework.boot:spring-boot-starter-parent:3.1.3

mvn dependency:copy \
    -Dartifact=org.springframework.boot:spring-boot-starter-parent:3.1.3:pom \
    -DoutputDirectory=libs2/org.springframework.boot/spring-boot-starter-parent/3.1.3



d) org.springframework.boot:spring-boot-starter-web


mvn dependency:copy \
    -Dartifact=org.springframework.boot:spring-boot-starter-web:3.1.3 \
    -Dtransitive=true \
    -DoutputDirectory=libs2/org.springframework.boot/spring-boot-starter-web/3.1.3


e) org.springframework.boot:spring-boot-starter-test

mvn dependency:copy \
    -Dartifact=org.springframework.boot:spring-boot-starter-test:3.1.3 \
    -DoutputDirectory=libs2/org.springframework.boot/spring-boot-starter-test/3.1.3

f) org.springframework.boot:spring-boot-devtools - https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-devtools/3.1.3/

mvn dependency:copy \
    -Dartifact=org.springframework.boot:spring-boot-devtools:3.1.3 \
    -Dtransitive=true \
    -DoutputDirectory=libs2/org.springframework.boot/spring-boot-devtools/3.1.3

e) org.springframework.boot:spring-boot-starter-actuator

mvn dependency:copy \
    -Dartifact=org.springframework.boot:spring-boot-starter-actuator:3.1.3 \
    -Dtransitive=true \
    -DoutputDirectory=libs2/org.springframework.boot/spring-boot-starter-actuator/3.1.3

f) org.projectlombok:lombok  - https://repo.maven.apache.org/maven2/org/projectlombok/lombok/1.18.8/
mvn dependency:copy \
    -Dartifact=org.projectlombok:lombok:1.18.8 \
    -Dtransitive=true \
    -DoutputDirectory=libs2/org.projectlombok/lombok/1.18.8



### --------

# Option 1: Download spring-boot-starter with Transitive Dependencies
# Option 2: Use dependency:get for the Parent POM (No Transitive Dependencies)
# Explanation
   - For transitive dependencies: Use spring-boot-starter instead of spring-boot-starter-parent, as this brings in core Spring Boot dependencies.
   - For the parent POM: Use dependency:get without -Dtransitive=true, since parent POMs don’t have dependencies in the same way.

###   ----------

1. 
mvn dependency:get \
    -DgroupId=$GROUP_ID \
    -DartifactId=$ARTIFACT_ID \
    -Dversion=$VERSION \
    -Ddest=libs/

2. GROUP_ID="org.springframework.boot"
ARTIFACT_ID="spring-boot-starter-parent"
VERSION="3.1.3"  # Replace with the desired version



# Run Maven to download the artifact
mvn org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
    -DrepoUrl=https://repo.maven.apache.org/maven2 \
    -Dartifact=${GROUP_ID}:${ARTIFACT_ID}:${VERSION} \
    -Dtransitive=false  # Set to true if you need dependencies as well

    e.g
    mvn dependency:copy \
    -Dartifact=junit:junit:4.13.2 \
    -DoutputDirectory=libs/junit/junit/4.13.2
