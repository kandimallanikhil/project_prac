#! /bin/bash
# installing of jfrog
sudo apt install openjdk-11-jdk -y
sudo wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip
sudo apt install unzip -y
sudo unzip  jfrog-artifactory-oss-6.9.6.zip
sudo sh /root/artifactory-oss-6.9.6/bin/artifactory.sh
