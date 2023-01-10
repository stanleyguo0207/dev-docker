# image debian:11.6
FROM debian:11.6

# expose port
EXPOSE 22

# work directory /root
WORKDIR /root

RUN apt update
RUN apt install -y vim wget curl apt-transport-https ca-certificates

# sources.list
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" \
         $'\n'"deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free" \
         $'\n'"deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" \
         $'\n'"deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free" \
         $'\n' \
         $'\n'"deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" \
         $'\n'"deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free" \
         $'\n' \
         $'\n'"deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" \
         $'\n'"deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free" \
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

RUN apt update && apt upgrade
RUN apt install -y git git-lfs cmake autoconf automake sudo passwd tmux htop texinfo doxygen \
                   openssl openssh-server openssh-client \
                   net-tools rsync tar bzip2 zip unzip lrzsz lsof telnet graphviz
RUN apt install -y build-essential gdb clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 \
                   libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 \
                   lld lldb llvm-dev llvm-runtime llvm python3-clang nodejs ninja-build

# local time
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# ssh config
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak && \
    sed -e 's|#GSSAPIAuthentication no|GSSAPIAuthentication no|g' \
        -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|g' \
        -i /etc/ssh/sshd_config