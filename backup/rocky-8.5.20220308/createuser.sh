#!/bin/bash

UserName="$1"
UserId="$2"
UserHome="/opt/docker_home"

groupadd $UserName
useradd -d $UserHome -u $UserId -g $UserName -s /bin/bash $UserName

echo "root" | passwd --stdin root
echo "$1" | passwd --stdin "$1"

mkdir -p $UserHome/omz/
tar -Jxf /opt/omz.tar.xz -C $UserHome/omz/

chown -R $UserName $UserHome
chgrp -R $UserName $UserHome