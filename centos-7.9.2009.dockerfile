# image centos:centos7.9.2009
FROM centos:centos7.9.2009

# expose port
EXPOSE 22

# base tools
RUN yum install wget -y

# backup repos
RUN mkdir /etc/yum.repos.d/backup &&\
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup

# huaweicloud centos
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo &&\
yum clean all &&\
yum makecache &&\
yum install deltarpm centos-release-scl -y &&\
# huaweicloud epel
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y &&\
cp -a /etc/yum.repos.d/epel.repo /etc/yum.repos.d/backup/epel.repo &&\
mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/backup/epel-testing.repo &&\
sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/epel.repo &&\
sed -i 's/metalink/#metalink/g' /etc/yum.repos.d/epel.repo &&\
sed -i 's@https\?://download.example/pub@https://repo.huaweicloud.com@g' /etc/yum.repos.d/epel.repo &&\
yum update -y &&\
# packages-microsoft-prod
rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm &&\
rm -rf /var/cache/yum &&\
yum makecache

# dev tools
RUN yum install devtoolset-10-gcc devtoolset-10-gcc-c++ devtoolset-10-libstdc++-devel \
devtoolset-10-gdb devtoolset-10-gcc-gdb-plugin devtoolset-10-make \
devtoolset-10-valgrind devtoolset-10-strace devtoolset-10-ltrace \
devtoolset-10-libasan-devel devtoolset-10-libtsan-devel \
cmake cmake3 autoconf automake mariadb-server mariadb-libs mariadb-devel \
rh-git218 rh-git218-git-lfs rh-redis5 openssl openssh openssh-server openssh-clients \
libuuid libuuid-devel libunwind libunwind-devel libiconv libsodium \
python-devel openldap-devel passwd tmux htop bzip2 net-tools vim rsync zip \
unzip texinfo gitlab-runner cppcheck \
dos2unix lrzsz curl tar dotnet dotnet-runtime-3.1 perf lsof telnet -y

# pip3
RUN ln -s /bin/pip3 /bin/pip &&\
pip3 install conan cpplint gcovr mkdocs

# ssh config
RUN sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config &&\
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config &&\
# local time
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime