#!/bin/bash

if [ $# != 2 ]
then
    echo "Usage: createuser.sh [user_name] [uid]"
    exit 1
fi

UserName="$1"
Uid="$2"

# room passwd
echo "root:root" | chpasswd 

# create user
groupadd -g $Uid $UserName
useradd -d /opt/docker_home -s $(which zsh) -g $UserName -u $Uid $UserName
echo "$UserName:$UserName" | chpasswd
usermod -aG sudo $UserName
cd /opt/docker_home
cp -R /etc/skel/. .
if [ ! -d .ssh ]; then
    mkdir .ssh
fi
chmod 700 .ssh
# chown $UserName .ssh
echo "" >> .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
# chown $UserName .ssh/authorized_keys
chown -R $UserName /opt/docker_home