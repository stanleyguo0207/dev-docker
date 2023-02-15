# image debian:11.6
FROM debian:11.6

# expose port
EXPOSE 22

# work directory /root
WORKDIR /root

SHELL ["/bin/bash", "-c"]
RUN echo I am using bash, which is now the default

RUN apt update
RUN apt install -y systemd wget apt-transport-https ca-certificates gnupg gnupg1 gnupg2

RUN wget -O - 'https://apt.llvm.org/llvm-snapshot.gpg.key' | apt-key add -

# sources.list
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" \
         $'\n'"# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" \
         $'\n'"deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" \
         $'\n'"# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" \
         $'\n' \
         $'\n'"deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" \
         $'\n'"# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" \
         $'\n' \
         $'\n'"deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" \
         $'\n'"# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" \
         $'\n' \
         $'\n'"deb http://mirrors.ustc.edu.cn/debian stable main contrib non-free" \
         $'\n'"# deb-src http://mirrors.ustc.edu.cn/debian stable main contrib non-free" \
         $'\n'"deb http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free" \
         $'\n'"# deb-src http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free" \
         $'\n' \
         $'\n'"deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" \
         $'\n'"deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" \
         $'\n' \
         $'\n'"deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main" \
         $'\n'"deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main" \
         >> /etc/apt/sources.list

# limits.conf
RUN mv /etc/security/limits.conf /etc/security/limits.conf.bak && \
    echo "*"$'\t'"soft"$'\t'"core"$'\t'"unlimited" \
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

RUN apt update && apt upgrade -y
RUN apt install -y zsh curl vim git git-lfs cmake autoconf automake sudo passwd tmux htop texinfo doxygen \
                   openssl openssh-server openssh-client \
                   net-tools rsync tar bzip2 zip unzip lrzsz lsof telnet graphviz
RUN apt install -y build-essential gdb nodejs python3 python3-venv python3-pip ninja-build pkg-config libx11-dev \
                   libxft-dev libxext-dev libtool
RUN apt install -y libllvm-15-ocaml-dev libllvm15 llvm-15 llvm-15-dev llvm-15-doc llvm-15-examples llvm-15-runtime \
                   clang-15 clang-tools-15 clang-15-doc libclang-common-15-dev libclang-15-dev libclang1-15 \
                   clang-format-15 python3-clang-15 clangd-15 clang-tidy-15 libfuzzer-15-dev lldb-15 lld-15 \
                   libc++-15-dev libc++abi-15-dev libomp-15-dev libclc-15-dev libunwind-15-dev libmlir-15-dev \
                   mlir-15-tools libbolt-15-dev bolt-15

# local time
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# ssh config
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak && \
    sed -e 's|#GSSAPIAuthentication no|GSSAPIAuthentication no|g' \
        -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|g' \
        -e 's|#PasswordAuthentication yes|PasswordAuthentication yes|g' \
        -e '/#PermitRootLogin prohibit-password/a\PermitRootLogin yes' \
        -i /etc/ssh/sshd_config