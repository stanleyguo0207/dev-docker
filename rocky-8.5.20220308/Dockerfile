# image rockylinux:8.5.20220308
FROM rockylinux:8.5.20220308

# expose port
EXPOSE 22

# replace repo
RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
	-e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
	-i.bak \
	/etc/yum.repos.d/Rocky-*.repo &&\
dnf install -y https://mirrors.aliyun.com/epel/epel-release-latest-8.noarch.rpm &&\
sed -e 's|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com|' \
    -e 's|^metalink|#metalink|' \
    -i /etc/yum.repos.d/epel* &&\
dnf makecache &&\
dnf update -y

# development tools
RUN dnf install -y gcc-toolset-11-gcc gcc-toolset-11-gcc-c++ gcc-toolset-11-libstdc++-devel \
gcc-toolset-11-gdb gcc-toolset-11-gcc-gdb-plugin gcc-toolset-11-make \
gcc-toolset-11-valgrind gcc-toolset-11-strace gcc-toolset-11-ltrace \
gcc-toolset-11-libasan-devel gcc-toolset-11-libtsan-devel \
git cmake autoconf automake mariadb-server mariadb-devel \
openssl openssh openssh-server openssh-clients \
libuuid libuuid-devel libunwind libunwind-devel libsodium \
vim python39 python39-devel openldap-devel \
passwd tmux htop bzip2 net-tools vim rsync tar zip unzip lrzsz perf lsof telnet graphviz

RUN dnf --enablerepo=powertools install -y texinfo doxygen

# local time
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
# ssh config
sed -e 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' \
    -e 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' \
    -i /etc/ssh/sshd_config &&\
# gcc-toolset-11
sed -e '/# You might want/i\ \ source\ \/opt\/rh\/gcc-toolset-11\/enable' \
    -i /etc/bashrc