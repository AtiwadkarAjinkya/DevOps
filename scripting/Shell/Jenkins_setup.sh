#!/bin/bash

# @author:  Ajinkya Atiwadkar
# @Summary: This script will install Jenkins on Ubuntu
# @Usage: sudo ./Jenkins_setup.sh

set -e 
set -o pipefail

echo -e "\e[1;33m Updating Packages \e[0m"
sudo apt update -y  
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Packages Updated Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed while updating packages \e[0m" 
fi

echo -e "\e[1;33m Upgrading Packages \e[0m"
sudo apt upgrade -y
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Packages Upgraded Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed while upgrading packages \e[0m" 
fi

echo -e "\e[1;33m Installing Java \e[0m"
sudo apt-get install openjdk-11-jdk -y
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Java Installtion Successful \e[0m" 
else 
    echo -e "\e[1;31m Java Installtion Failed \e[0m" 
fi

echo -e "\e[1;33m Set Java Home \e[0m"
sudo echo 'JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> /etc/environment && \
source /etc/environment
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Java Home Set Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed  to set Java Home \e[0m" 
fi

echo -e "\e[1;33m Add Jenkins Repo \e[0m"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - && \
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Jenkins Repo added Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed  to add Jenkins Repo \e[0m" 
fi

echo -e "\e[1;33m Updating Packages \e[0m"
sudo apt update -y  
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Packages Updated Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed while updating packages \e[0m" 
fi

echo -e "\e[1;33m Installing Jenkins \e[0m"
sudo apt-get install jenkins -y
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Jenkins Installtion Successful \e[0m" 
else 
    echo -e "\e[1;31m Jenkins Installtion Failed \e[0m" 
fi

echo -e "\e[1;33m Start Jenkins Service \e[0m"
sudo systemctl start jenkins
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Jenkins service started Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed to start Jenkins service \e[0m" 
fi

echo -e "\e[1;33m Enable Jenkins Service \e[0m"
sudo systemctl enable jenkins
if [ $? -eq 0 ]; then 
    echo -e "\e[1;32m Jenkins service enabled Successfully \e[0m" 
else 
    echo -e "\e[1;31m Failed to enable Jenkins service \e[0m" 
fi

echo -e "\e[1;33m Jenkins Password \e[0m"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
