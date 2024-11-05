```
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.example</groupId>
	<artifactId>maven-demo-to-spring-boot-prj</artifactId>
	<packaging>jar</packaging>
	<version>6.0-SNAPSHOT</version>
	<name>maven-demo-to-spring-boot-prj</name>
	<url>http://maven.apache.org</url>


    <!-- To Upload libraries to Artifact Registry -->
	<distributionManagement>
		<snapshotRepository>
			<id>artifact-registry1</id>
			<url>
				artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-library</url>
		</snapshotRepository>
		<repository>
			<id>artifact-registry</id>
			<url>
				artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-library</url>
		</repository>
	</distributionManagement>

	<!-- To Download libraries from Artifact Registry -->
	<repositories>
		<repository>	
		    <id>artifact-registry</id>
			<url>artifactregistry://asia-south1-maven.pkg.dev/devops-438202/maven-virtual-repo</url>
			<releases>
				<enabled>true</enabled>
			</releases>
			<snapshots>
				<enabled>true</enabled>
			</snapshots>
		</repository>
	</repositories>


	<dependencies>

		<dependency>
			<groupId>com.example</groupId>
			<artifactId>my-library</artifactId>
			<version>1.0</version>
		</dependency>
		
		<dependency>
			<groupId>com.example</groupId>
			<artifactId>maven-demo-to-spring-boot-prj</artifactId>
			<version>5.0-SNAPSHOT</version>
			<!--<version>1.0</version>-->
		</dependency>
		
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
			<version>3.3.4</version>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter</artifactId>
			<version>3.3.4</version>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-devtools</artifactId>
			<version>3.3.4</version>
			<scope>runtime</scope>
			<optional>true</optional>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<version>3.3.4</version>
			<scope>test</scope>
		</dependency>

		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>3.8.1</version>
			<scope>test</scope>
		</dependency>

	</dependencies>

	<build>
		<extensions>
			<extension>
				<groupId>com.google.cloud.artifactregistry</groupId>
				<artifactId>artifactregistry-maven-wagon</artifactId>
				<version>2.2.0</version>
			</extension>
		</extensions>
	</build>

</project>
```