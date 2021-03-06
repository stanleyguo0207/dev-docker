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

sed -e '$a*\tsoft\tcore\tunlimited' \
	-e '$a*\thard\tcore\tunlimited' \
	-e '$a*\tsoft\tnofile\t1048576' \
	-e '$a*\thard\tnofile\t1048576' \
	-e '$a*\tsoft\tnproc\t102400' \
	-e '$a*\thard\tnproc\t102400' \
	-e '$root*\tsoft\tcore\tunlimited' \
	-e '$root*\thard\tcore\tunlimited' \
	-e '$root*\tsoft\tnofile\t1048576' \
	-e '$root*\thard\tnofile\t1048576' \
	-e '$root*\tsoft\tnproc\t102400' \
	-e '$root*\thard\tnproc\t102400' \
	-i /etc/security/limits.conf
echo "ulimit modification is done !"

echo "core-%e-%p-%t" > /proc/sys/kernel/core_pattern
echo "core_pattern modification is done !"

sed -e '$a140.82.112.3\tgithub.com' \
	-e '$a140.82.113.3\tgithub.com' \
	-e '$a140.82.114.5\tapi.github.com' \
	-e '$a185.199.108.153\tgithub.io' \
	-e '$a199.232.69.194\tgithub.global.ssl.fastly.net' \
	-e '$a185.199.108.133\traw.github.com' \
	-e '$a185.199.108.133\traw.githubusercontent.com' \
	-e '$a185.199.109.133\traw.githubusercontent.com' \
	-e '$a185.199.110.133\traw.githubusercontent.com' \
	-e '$a185.199.111.133\traw.githubusercontent.com' \
	-e '$a2606:50c0:8000::154\traw.githubusercontent.com' \
	-e '$a2606:50c0:8001::154\traw.githubusercontent.com' \
	-e '$a2606:50c0:8002::154\traw.githubusercontent.com' \
	-e '$a2606:50c0:8003::154\traw.githubusercontent.com' \
	-e '$a185.199.108.153\tassets-cdn.github.com' \
	-e '$a185.199.109.153\tassets-cdn.github.com' \
	-e '$a185.199.110.153\tassets-cdn.github.com' \
	-e '$a185.199.111.153\tassets-cdn.github.com' \
	-e '$a2606:50c0:8000::153\tassets-cdn.github.com' \
	-e '$a2606:50c0:8001::153\tassets-cdn.github.com' \
	-e '$a2606:50c0:8002::153\tassets-cdn.github.com' \
	-e '$a2606:50c0:8003::153\tassets-cdn.github.com' \
	-i /etc/hosts
echo "hosts modification is done !"

hostnamectl set-hostname stanleyguo0207
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
dnf install -y git git-lfs chrony docker-ce zsh net-tools
systemctl start chronyd
systemctl enable chronyd
sed -e 's|pool 2.|# pool 2.|g' \
	-e '/# pool 2./a\server ntp.aliyun.com iburst' \
	-e '/# pool 2./a\server cn.ntp.org.cn iburst' \
	-i /etc/chrony.conf
systemctl restart chronyd.service
systemctl start docker
systemctl enable docker
echo "docker install is done !"

# git config
git config --global user.name stanleyguo0207
git config --global user.email stanleyguo0207@163.com
git config --global core.editor vi
ssh-keygen -t rsa -C stanleyguo0207@163.com
git clone git@github.com:stanleyguo0207/dev-docker.git /root/dev-docker
git config --global commit.template /root/dev-docker/commit.template

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed 's|^ZSH_THEME=".*$|ZSH_THEME="powerlevel10k\/powerlevel10k"|' -i /root/.zshrc