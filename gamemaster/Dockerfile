FROM gcc:12-bullseye

RUN set -ex; \
  apt update;

RUN set -ex; \
  wget -O - 'https://apt.llvm.org/llvm-snapshot.gpg.key' | apt-key add -;

RUN set -ex; \
  mv /etc/apt/sources.list /etc/apt/sources.list.bak; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list; \
  echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list; \
  echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list; \
  echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-16 main" >> /etc/apt/sources.list; \
  echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-16 main" >> /etc/apt/sources.list;

RUN set -ex; \
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
  echo "root*   hard    nproc   102400" >> /etc/security/limits.conf;

RUN set -ex; \
  apt update; \
  apt upgrade -y;

RUN set -ex; \
  apt install -y --no-install-recommends \
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
  libclang-rt-16-dev-wasm64;

RUN set -ex; \
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;

RUN set -ex; \
  sed -e 's|#GSSAPIAuthentication no|GSSAPIAuthentication no|g' \
  -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|g' \
  -e 's|#PasswordAuthentication yes|PasswordAuthentication yes|g' \
  -e '/#PermitRootLogin prohibit-password/a\PermitRootLogin yes' \
  -i /etc/ssh/sshd_config;
