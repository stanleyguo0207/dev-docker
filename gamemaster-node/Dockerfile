FROM node:18.15-bullseye


RUN set -ex; \
  # update
  apt update; \
  # sources.list
  mv /etc/apt/sources.list /etc/apt/sources.list.bak; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list; \
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
  python3 \
  python3-venv \
  python3-pip \
  ninja-build \
  pkg-config \
  libx11-dev \
  libxft-dev \
  libxext-dev \
  libtool; \
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
