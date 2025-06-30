#!/bin/bash

# Update and install necessary packages
sudo yum update -y
sudo yum install -y git

# Install Java 21 (Amazon Linux doesn't have OpenJDK 21 by default, use Amazon Corretto)
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-21-amazon-corretto-devel

# Install Maven
sudo yum install -y maven

# Clone your GitHub repo
cd /home/ec2-user
git clone https://github.com/sam810630/devops-assignment.git

# Go into project directory
cd devops-assignment/myapp

# Load config
source ../dev_config.properties

# Build the project
mvn clean install

# Run the app
java -jar target/*.jar --server.port=$app_port --spring.profiles.active=$app_environment