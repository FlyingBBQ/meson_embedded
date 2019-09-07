FROM ubuntu:latest

# install required dependencies
RUN apt-get update
RUN apt-get -y install \
        build-essential \
        pkg-config \
        curl \
        git \
        python3 \
        python3-pip \
        binutils-arm-none-eabi \
        gcc-arm-none-eabi \
        libnewlib-arm-none-eabi \
        clang \
        clang-tools \
        libcpputest-dev \
        doxygen \
        graphviz

# install (latest version of) Meson and Ninja
RUN pip3 install ninja meson
