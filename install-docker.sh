#!/bin/bash
#check whether root user or not
R="\e[31m"
N="\e[0m"

#steps to install and enable docker
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
systemctl start docker
systemctl status docker
systemctl enable docker

#to add ec2-user to docker group so that ec2-user can run the docker commands
usermod -aG docker ec2-user

#once the ec2-user is added to the docker group he need to logout and login to run the docker commands
echo -e "$R logout and login again to run docker commands $N"