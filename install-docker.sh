#!/bin/bash
#check whether root user or not
USER=$(id -u)
if [ $USER -ne 0 ]
then
    echo -e "$R please run the script using sudo access $N"
    exit 1
fi

validate(){
if [ $1 -eq 0 ]
then
    echo -e "$G $2 is........SUCCESS $N"
else
    echo -e "$R $2 is.........FAILUER $N"
fi
}

R="\e[31m"
N="\e[0m"
G="\e[32m"

#steps to install and enable docker
yum install -y yum-utils
validate $? "installation of yum-utils"

yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
validate $? "adding repo"

yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
validate $? "installing docker"

systemctl start docker
validate $? "starting docker"

systemctl enable docker
validate $? "enabling docker"

#to add ec2-user to docker group so that ec2-user can run the docker commands
usermod -aG docker ec2-user
validate $? "adding ec2-user to the docker group"

#once the ec2-user is added to the docker group he need to logout and login to run the docker commands
echo -e "$R logout and login again to run docker commands $N"