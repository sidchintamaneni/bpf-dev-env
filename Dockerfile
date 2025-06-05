FROM ubuntu:24.04 AS bpf-linux-builder

ENV LINUX=/linux 

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y git build-essential gcc g++ fakeroot libncurses5-dev libssl-dev ccache dwarves libelf-dev \
 cmake mold \
 libdw-dev libdwarf-dev \
 bpfcc-tools libbpfcc-dev libbpfcc \
 linux-headers-generic \
 libtinfo-dev \
 libstdc++-11-dev libstdc++-12-dev \
 bc \
 flex bison \
 rsync \
 libcap-dev libdisasm-dev binutils-dev unzip \
 pkg-config lsb-release wget software-properties-common gnupg zlib1g llvm \
 qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon xterm attr busybox openssh-server \
 iputils-ping kmod

# clang and llvm
RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 20
RUN ln -s /usr/bin/clang-20 /usr/bin/clang
RUN ln -s /usr/bin/clang++-20 /usr/bin/clang++
RUN ln -s /usr/bin/ld.lld-20 /usr/bin/ld.lld

# Essentials
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y iputils-ping kmod curl autoconf gdb

# SCX tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y protobuf-compiler

# SCX tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-docutils

# Pahole versin update for bpf selftests build
RUN git clone --depth=1 --branch=v1.29 https://git.kernel.org/pub/scm/devel/pahole/pahole.git && \
cd pahole && mkdir build && cd build && cmake .. && make -j$(nproc) && make install && cp ./pahole /usr/local/bin/pahole && pahole --version

