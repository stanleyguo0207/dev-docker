FROM gcc:12-bullseye

USER root

RUN set -ex; \
  # update
  apt update; \
  # llvm gpg
  wget -O - 'https://apt.llvm.org/llvm-snapshot.gpg.key' | apt-key add -; \
  # sources.list
  mv /etc/apt/sources.list /etc/apt/sources.list.bak; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list; \
  echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list; \
  echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-16 main" >> /etc/apt/sources.list; \
  echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-16 main" >> /etc/apt/sources.list; \
  # update
  apt update; \
  apt upgrade -y; \
  # software
  apt install -y --no-install-recommends \
  init \
  systemd \
  zsh \
  curl \
  vim \
  git \
  git-lfs \
  cmake \
  autoconf \
  automake \
  sudo \
  passwd \
  tmux \
  htop \
  texinfo \
  doxygen \
  openssl \
  openssh-server \
  openssh-client \
  locales \
  locales-all \
  net-tools \
  rsync \
  tar \
  bzip2 \
  zip \
  unzip \
  lrzsz \
  lsof \
  telnet \
  graphviz \
  gdb \
  nodejs \
  python3 \
  python3-venv \
  python3-pip \
  ninja-build \
  pkg-config \
  libx11-dev \
  libxft-dev \
  libxext-dev \
  libtool \
  # llvm
  libllvm-16-ocaml-dev \
  libllvm16 \
  llvm-16 \
  llvm-16-dev \
  llvm-16-doc \
  llvm-16-examples \
  llvm-16-runtime \
  clang-16 \
  clang-tools-16 \
  clang-16-doc \
  libclang-common-16-dev \
  libclang-16-dev \
  libclang1-16 \
  clang-format-16 \
  python3-clang-16 \
  clangd-16 \
  clang-tidy-16 \
  libclang-rt-16-dev \
  libpolly-16-dev \
  libfuzzer-16-dev \
  lldb-16 \
  lld-16 \
  libc++-16-dev \
  libc++abi-16-dev \
  libomp-16-dev \
  libclc-16-dev \
  libunwind-16-dev \
  libmlir-16-dev \
  mlir-16-tools \
  libbolt-16-dev \
  bolt-16 \
  flang-16 \
  libclang-rt-16-dev-wasm32 \
  libclang-rt-16-dev-wasm64 \
  libc++-16-dev-wasm32 \
  libc++abi-16-dev-wasm32 \
  libclang-rt-16-dev-wasm32 \
  libclang-rt-16-dev-wasm64; \
  # limits.conf
  mv /etc/security/limits.conf /etc/security/limits.conf.bak; \
  echo "*       soft    core    unlimited" >> /etc/security/limits.conf; \
  echo "*       hard    core    unlimited" >> /etc/security/limits.conf; \
  echo "*       soft    nofile  1048576" >> /etc/security/limits.conf; \
  echo "*       hard    nofile  1048576" >> /etc/security/limits.conf; \
  echo "*       soft    nproc   102400" >> /etc/security/limits.conf; \
  echo "*       hard    nproc   102400" >> /etc/security/limits.conf; \
  echo "root*   soft    core    unlimited" >> /etc/security/limits.conf; \
  echo "root*   hard    core    unlimited" >> /etc/security/limits.conf; \
  echo "root*   soft    nofile  1048576" >> /etc/security/limits.conf; \
  echo "root*   hard    nofile  1048576" >> /etc/security/limits.conf; \
  echo "root*   soft    nproc   102400" >> /etc/security/limits.conf; \
  echo "root*   hard    nproc   102400" >> /etc/security/limits.conf; \
  # localtime
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
  # sshd_config
  sed -e 's|#GSSAPIAuthentication no|GSSAPIAuthentication no|g' \
  -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|g' \
  -e 's|#PasswordAuthentication yes|PasswordAuthentication yes|g' \
  -e '/#PermitRootLogin prohibit-password/a\PermitRootLogin yes' \
  -i /etc/ssh/sshd_config;

ENV GAMEMASTER_HOME /opt/docker_home
RUN set -ex; \
  mkdir -p $GAMEMASTER_HOME; \
  cp -R /etc/skel/. $GAMEMASTER_HOME; \
  groupadd -r -g 1024 gamemaster; \
  useradd -r -d $GAMEMASTER_HOME -s $(which zsh) -g gamemaster -u 1024 gamemaster;\
  usermod -aG sudo gamemaster;

VOLUME /opt/docker_home
ADD gamemaster-init.tar.gz /opt/docker_home
RUN set -ex; \
  chown -R gamemaster:gamemaster $GAMEMASTER_HOME;

USER gamemaster
WORKDIR /opt/docker_home

RUN set -ex; \
  mkdir -p .ssh; \
  chmod 700 .ssh; \
  echo "" >> .ssh/authorized_keys; \
  chmod 600 .ssh/authorized_keys; \
  echo "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" >> .vimrc; \
  echo "set termencoding=utf-8" >> .vimrc; \
  echo "set encoding=utf-8" >> .vimrc; \
  sh install-ohmyzsh.sh --unattended; \
  rm -f install-ohmyzsh.sh; \
  mv powerlevel10k .oh-my-zsh/custom/themes/powerlevel10k;\
  sed -e 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|g' -i .zshrc; \
  mkdir -p .vscode-server/data/Machine; \
  mv settings.json .vscode-server/data/Machine/;

USER root
WORKDIR /root
