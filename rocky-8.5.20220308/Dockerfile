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
RUN dnf install -y gcc-toolset-11 llvm-toolset llvm-devel clang-devel \
git git-lfs cmake autoconf automake mariadb-server mariadb-devel \
openssl openssh openssh-server openssh-clients \
libuuid libuuid-devel libunwind libunwind-devel libsodium \
wget vim zsh python39 python39-devel openldap-devel util-linux-user sudo \
passwd tmux htop net-tools rsync tar bzip2 xz zip unzip lrzsz perf lsof telnet graphviz &&\
git lfs install

RUN dnf --enablerepo=powertools install -y texinfo doxygen

# hosts
RUN echo "140.82.112.3"$'\t'"github.com" \
         $'\n'"140.82.114.5"$'\t'"api.github.com" \
         $'\n'"185.199.108.153"$'\t'"github.io" \
         $'\n'"185.199.108.133"$'\t'"raw.github.com" \
         $'\n'"185.199.108.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.109.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.110.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.111.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8000::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8001::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8002::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8003::154"$'\t'"raw.githubusercontent.com" \
         >> /etc/hosts

# tools
COPY tools /root/tools

# tools
RUN mv -f /root/tools/ninja /bin/ninja &&\
chmod 755 /bin/ninja &&\
chown root:root /bin/ninja &&\
# oh-my-zsh
cp /root/tools/omz.sh /root/ &&\
mkdir -p /root/omz/ &&\
tar -Jxf /root/tools/powerlevel10k.tar.xz -C /root/omz/ &&\
tar -Jxf /root/tools/omz_plugins.tar.xz -C /root/omz/ &&\
# fonts
tar -Jxf /root/tools/fonts.tar.xz -C /root/tools/ &&\
/root/tools/fonts/install.sh &&\
mkdir -p /root/.config/fontconfig/conf.d &&\
cp /root/tools/50-enable-terminess-powerline.conf /root/.config/fontconfig/conf.d/ &&\
fc-cache -vf ~/.local/share/fonts/ &&\
# ccls
tar -Jxf /root/tools/ccls.tar.xz -C /opt/ &&\
cd /opt/ccls &&\
cmake \
    -H. \
    -BRelease \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=lld \
    -DCMAKE_PREFIX_PATH=/usr &&\
cmake --build Release --parallel &&\
cmake --install Release &&\
rm -rf /opt/ccls

# pip3
RUN ln -s /bin/pip3 /bin/pip &&\
pip install ranger-fm

# remove
RUN rm -rf /root/tools

# local time
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
# ssh config
sed -e 's|GSSAPIAuthentication yes|GSSAPIAuthentication no|g' \
    -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|g' \
    -i /etc/ssh/sshd_config &&\
# gcc-toolset-11
sed -e '/# You might want/i\    source /opt/rh/gcc-toolset-11/enable' \
    -i /etc/bashrc