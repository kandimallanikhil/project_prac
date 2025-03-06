#! /bin/bash
# installing of jfrog
sudo apt install openjdk-11-jdk -y
sudo wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip
sudo apt install unzip -y
sudo unzip  jfrog-artifactory-oss-6.9.6.zip
sudo sh /root/artifactory-oss-6.9.6/bin/artifactory.sh
===============================================================================
#!/bin/bash

# Enable debug mode to print each command as it is executed
set -x

# Step 1: Update package lists and install necessary dependencies
echo "Step 1: Updating package lists and installing OpenJDK 11"
sudo apt update

# Install OpenJDK 11 (Ubuntu should have it in its default repository)
echo "Step 2: Installing OpenJDK 11"
sudo apt install openjdk-11-jdk -y

# If the above command doesn't work, try installing the headless version of OpenJDK
# echo "Installing OpenJDK 11 headless"
# sudo apt install openjdk-11-jdk-headless -y

# Step 2: Install unzip to extract the JFrog Artifactory ZIP file
echo "Step 3: Installing unzip to extract the JFrog Artifactory ZIP"
sudo apt install unzip -y

# Step 3: Download the JFrog Artifactory OSS ZIP file
echo "Step 4: Downloading JFrog Artifactory OSS"
wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip

# Step 4: Extract the JFrog Artifactory ZIP file
echo "Step 5: Extracting JFrog Artifactory ZIP file"
sudo unzip jfrog-artifactory-oss-6.9.6.zip -d /root/

# Step 5: Move to the Artifactory directory
cd /root/artifactory-oss-6.9.6/

# Step 6: Run the Artifactory installation script
echo "Step 6: Running Artifactory installation script"
sudo bash /root/artifactory-oss-6.9.6/bin/artifactory.sh

# Step 7: Verify if Artifactory is running
echo "Step 7: Verifying if Artifactory is running"
ps aux | grep artifactory

# Disable debug mode (optional)
set +x

