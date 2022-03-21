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
git git-lfs cmake autoconf automake mariadb-server mariadb-devel \
openssl openssh openssh-server openssh-clients \
libuuid libuuid-devel libunwind libunwind-devel libsodium \
wget vim python39 python39-devel openldap-devel \
passwd tmux htop net-tools rsync tar bzip2 xz zip unzip lrzsz perf lsof telnet graphviz

RUN dnf --enablerepo=powertools install -y texinfo doxygen

# tools
COPY tools /root/tools

# tools
RUN mv -f /root/tools/ninja /bin/ninja &&\
chmod 755 /bin/ninja &&\
chown root:root /bin/ninja &&\
tar -Jxf /root/tools/ccls.tar.xz -C /opt/
tar -Jxf /root/tools/llvm-project-13.0.1.tar.xz -C /opt/

# pip3
RUN ln -s /bin/pip3 /bin/pip &&\
pip install ranger-fm

# remove
RUN rm -rf /root/tools

# local time
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
# ssh config
sed -e 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' \
    -e 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' \
    -i /etc/ssh/sshd_config &&\
# gcc-toolset-11
sed -e '/# You might want/i\    source opt/rh/gcc-toolset-11/enable' \
    -i /etc/bashrc
    