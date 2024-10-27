To install a specific version of Maven, such as 3.9.5, using apt directly isn't typically supported because apt usually installs the latest version available in the repository. However, you can follow these steps to install Maven 3.9.5 on a Linux system:

### Step 1: Remove Existing Maven Installation (if necessary)

If you already have Maven installed and want to remove it, run:
```
bash

sudo apt remove maven
```

### Step 2: Install Required Dependencies

Make sure you have wget and unzip installed:

```
sudo apt update
sudo apt install wget unzip
```

### Step 3: Download Maven 3.9.5

You can download Maven 3.9.5 from the Apache Maven website:

```
wget https://downloads.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip
```

### Step 4: Unzip the Downloaded File

Unzip the downloaded Maven package:

```
unzip apache-maven-3.9.5-bin.zip
```

### Step 5: Move Maven to the /opt Directory

You can move the unzipped folder to the /opt directory (or any other directory of your choice):

```
sudo mv apache-maven-3.9.5 /opt/
```

### Step 6: Set Up Environment Variables

Now, you need to set up environment variables to use this Maven installation. You can do this by editing your shell profile file (e.g., .bashrc, .bash_profile, or .zshrc):

```
nano ~/.bashrc
```
Add the following lines at the end of the file:

```
export M2_HOME=/opt/apache-maven-3.9.5
export PATH=$M2_HOME/bin:$PATH
```

After saving the file, apply the changes:

```
source ~/.bashrc
```

Step 7: Verify the Installation

Check if Maven is installed correctly and see the version:

```
mvn -v
```

Summary

These steps will install Maven 3.9.5 on your system. If you encounter any issues during the installation or have questions, feel free to ask!