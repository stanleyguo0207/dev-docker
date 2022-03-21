#!/bin/bash

sed -e '$aIPADDR=192.168.200.201' \
	-e '$aGATEWAY=192.168.200.2' \
	-e '$aNETMASK=255.255.255.0' \
	-e '$aDNS1=114.114.114.114' \
	-e '$aDNS2=8.8.8.8' \
	-e '/BOOTPROTO/c BOOTPROTO=static' \
	-e '/ONBOOT/c ONBOOT=yes' \
	-i.bak \
	/etc/sysconfig/network-scripts/ifcfg-ens160
nmcli connection reload
ifdown ens160
ifup ens160
echo "ifcfg modification is done !"

sed -e '/# End of file/i\* soft nproc 65535' \
	-e '/# End of file/i\* hard nproc 65535' \
	-e '/# End of file/i\* soft nofile 6553500' \
	-e '/# End of file/i\* soft nofile 6553500' \
	-i /etc/security/limits.conf

hostnamectl set-hostname stanleyguo0207
sed -i '$a192.168.200.201\tstanleyguo0207' \
	/etc/hosts
echo "hostname modification is done !"

sed -e 's|^mirrorlist=|#mirrorlist=|g' \
	-e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
	-i.bak \
	/etc/yum.repos.d/Rocky-*.repo
dnf makecache
echo "repo replace aliyun repo is done !"

dnf install -y yum-utils device-mapper-persistent-data lvm2
dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sed -i 's+download.docker.com+mirrors.aliyun.com/docker-ce+' \
	/etc/yum.repos.d/docker-ce.repo
dnf update -y
dnf install -y docker-ce
systemctl start docker
systemctl enable docker
echo "docker install is done !"

dnf install -y git

# git config
git config --global user.name stanleyguo0207
git config --global user.email stanleyguo0207@163.com
git config --global core.editor vi
ssh-keygen -t rsa -C stanleyguo0207@163.com
git clone git@github.com:stanleyguo0207/dev-docker.git /root/dev-docker
git config --global commit.template /root/dev-docker/commit.template