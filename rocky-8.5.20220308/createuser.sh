#!/bin/bash

UserName="$1"
UserId="$2"
useradd -m -d /opt/docker_home -u $UserId -G root -s /bin/zsh $UserName
echo "root" | passwd --stdin root
echo "$1" | passwd --stdin "$1"