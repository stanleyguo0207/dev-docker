# image rockylinux:8.5.20220308
FROM rockylinux:8.5.20220308

# expose port
EXPOSE 22

WORKDIR /root

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
RUN dnf install -y gcc-toolset-11 gcc-toolset-11-libasan-devel gcc-toolset-11-libtsan-devel gcc-toolset-11-ltrace \
gcc-toolset-11-gcc gcc-toolset-11-gcc-c++ gcc-toolset-11-gcc-gdb-plugin gcc-toolset-11-libstdc++-devel \
gcc-toolset-11-perftools gcc-toolset-11-strace gcc-toolset-11-valgrind \
llvm-toolset llvm-devel clang-devel \
git git-lfs cmake autoconf automake mariadb-server mariadb-devel \
openssl openssh openssh-server openssh-clients \
libuuid libuuid-devel libunwind libunwind-devel libsodium libX11-devel libXext-devel \
wget vim neovim python3-neovim zsh python39 python39-devel openldap-devel util-linux-user sudo \
passwd tmux htop net-tools rsync tar bzip2 xz zip unzip lrzsz perf lsof telnet graphviz &&\
git lfs install &&\
chsh -s /bin/zsh

RUN dnf --enablerepo=powertools install -y texinfo doxygen

# hosts
RUN echo "140.82.112.3"$'\t'"github.com" \
         $'\n'"140.82.113.3"$'\t'"github.com" \
         $'\n'"140.82.114.5"$'\t'"api.github.com" \
         $'\n'"185.199.108.153"$'\t'"github.io" \
         $'\n'"199.232.69.194"$'\t'"github.global.ssl.fastly.net" \
         $'\n'"185.199.108.133"$'\t'"raw.github.com" \
         $'\n'"185.199.108.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.109.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.110.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.111.133"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8000::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8001::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8002::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"2606:50c0:8003::154"$'\t'"raw.githubusercontent.com" \
         $'\n'"185.199.108.153"$'\t'"assets-cdn.github.com" \
         $'\n'"185.199.109.153"$'\t'"assets-cdn.github.com" \
         $'\n'"185.199.110.153"$'\t'"assets-cdn.github.com" \
         $'\n'"185.199.111.153"$'\t'"assets-cdn.github.com" \
         $'\n'"2606:50c0:8000::153"$'\t'"assets-cdn.github.com" \
         $'\n'"2606:50c0:8001::153"$'\t'"assets-cdn.github.com" \
         $'\n'"2606:50c0:8002::153"$'\t'"assets-cdn.github.com" \
         $'\n'"2606:50c0:8003::153"$'\t'"assets-cdn.github.com" \
         >> /etc/hosts

# ulimit
RUN echo "*"$'\t'"soft"$'\t'"core"$'\t'"unlimited" \
         $'\n'"*"$'\t'"hard"$'\t'"core"$'\t'"unlimited" \
         $'\n'"*"$'\t'"soft"$'\t'"nofile"$'\t'"1048576" \
         $'\n'"*"$'\t'"hard"$'\t'"nofile"$'\t'"1048576" \
         $'\n'"*"$'\t'"soft"$'\t'"nproc"$'\t'"102400" \
         $'\n'"*"$'\t'"hard"$'\t'"nproc"$'\t'"102400" \
         $'\n'"root*"$'\t'"soft"$'\t'"core"$'\t'"unlimited" \
         $'\n'"root*"$'\t'"hard"$'\t'"core"$'\t'"unlimited" \
         $'\n'"root*"$'\t'"soft"$'\t'"nofile"$'\t'"1048576" \
         $'\n'"root*"$'\t'"hard"$'\t'"nofile"$'\t'"1048576" \
         $'\n'"root*"$'\t'"soft"$'\t'"nproc"$'\t'"102400" \
         $'\n'"root*"$'\t'"hard"$'\t'"nproc"$'\t'"102400" \
         >> /etc/security/limits.conf

# ninja
COPY tools/ninja /bin/ninja
RUN chmod 755 /bin/ninja &&\
chown root:root /bin/ninja

# fonts-linux
COPY tools/fonts-linux /root/tools/fonts-linux
COPY tools/50-enable-terminess-powerline.conf /root/tools/
RUN /root/tools/fonts-linux/install.sh &&\
mkdir -p /root/.config/fontconfig/conf.d &&\
cp /root/tools/50-enable-terminess-powerline.conf /root/.config/fontconfig/conf.d/ &&\
fc-cache -vf ~/.local/share/fonts-linux/

# ccls
COPY tools/ccls /root/tools/ccls
RUN cd /root/tools/ccls &&\
cmake \
    -H. \
    -BRelease \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=lld \
    -DCMAKE_PREFIX_PATH=/usr &&\
cmake --build Release --parallel &&\
cmake --install Release

# pip3
RUN ln -s /bin/pip3 /bin/pip &&\
pip install ranger-fm ueberzug pynvim

# oh-my-zsh
COPY tools/omz /root/tools/omz
RUN /bin/zsh &&\
/root/tools/omz/omz.sh "/root" &&\
cp /root/tools/omz/.p10k.zsh /root &&\
cp /root/tools/omz/.zshrc /root

# root passwd
RUN echo "root" | passwd --stdin root

# ssh
RUN mkdir -p /root/.ssh &&\
echo "" >> /root/.ssh/authorized_keys

# nodejs
COPY tools/nodejs /root/tools/nodejs
RUN tar -Jxf /root/tools/nodejs/node-v17.9.0-linux-x64.tar.xz -C /opt/ &&\
mv /opt/node-v17.9.0-linux-x64 /opt/node &&\
mv /root/tools/nodejs/enable /opt/node &&\
mv /root/tools/nodejs/install-npm.sh /opt/node

# vscode
COPY tools/vscode /opt/vscode

# opt
COPY tools/init_dev.sh /opt

# local time
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
# ssh config
sed -e 's|GSSAPIAuthentication yes|GSSAPIAuthentication no|g' \
    -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|g' \
    -i /etc/ssh/sshd_config &&\
# gcc-toolset-11
sed -e '/# You might want/i\    source /opt/rh/gcc-toolset-11/enable' \
    -e '/# You might want/i\    source /opt/node/enable' \
    -e '/# You might want/i\    source /root/.zshrc' \
    -i /etc/bashrc

# clean
RUN rm -rf /root/tools