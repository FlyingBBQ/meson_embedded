FROM ubuntu:latest

# install required dependencies
RUN apt-get update
RUN apt-get -y install \
    build-essential \
    curl \
    git \
    python3 \
    python3-pip \
    ninja-build \
    binutils-arm-none-eabi \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    doxygen \
    graphviz

# install (latest) version of Meson
RUN pip3 install meson
