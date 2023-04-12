#!/bin/bash

if [ $# != 2 ]; then
  echo "Usage: createuser.sh [user_name] [uid]"
  exit 1
fi

user_name="$1"
uid="$2"

# room passwd
echo "root:root" | chpasswd

# create user
groupadd -g $uid $user_name
useradd -d /opt/docker_home -s $(which zsh) -g $user_name -u $uid $user_name
echo "$user_name:$user_name" | chpasswd
usermod -aG sudo $user_name
cd /opt/docker_home

# now in /opt/docker_home
# ==============================================================================

cp -R /etc/skel/. .
if [ ! -d .ssh ]; then
  mkdir .ssh
fi
chmod 700 .ssh
echo "" >>.ssh/authorized_keys
chmod 600 .ssh/authorized_keys

# tools
tar -zxf tools/gdb/gdbinit.tar.gz -C /opt/docker_home/tools/gdb
mv tools/gdb/.gdbinit .
mkdir .gdb && mv tools/gdb/python .gdb
mv tools/debian ./init_dev

rm -rf tools

# chown
chown -R $user_name:$user_name /opt/docker_home
