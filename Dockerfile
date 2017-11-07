### Setup ###

FROM ubuntu:16.04
SHELL [ "/bin/bash", "-c" ]

### Install packages for Debian-based OS ###

RUN apt-get update && \
  apt-get install -yq autoconf-archive bison build-essential cmake curl flex git gperf joe libboost-all-dev libcap-dev libdouble-conversion-dev libevent-dev libgflags-dev libgoogle-glog-dev libkrb5-dev libnuma-dev libsasl2-dev libsnappy-dev libsqlite3-dev libssl-dev libtool netcat-openbsd pkg-config unzip wget gcc-5 g++-5 ccache && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 40 --slave /usr/bin/g++ g++ /usr/bin/g++-5 && \
  update-alternatives --config gcc

### Build FB packages ###

ENV FOLLY_VERSION=05a56e4c1e3313f38f4f891a0b8db684004555e1
ENV WANGLE_VERSION=388825e1e9770cea7d1a3a14fe6f724322fde8e3
ENV PROXYGEN_VERSION=4139e3610ab80853dcdabb32f8c77ff30f6c0f5e

RUN mkdir -p /fb && cd /fb && \
    git clone https://github.com/facebook/folly && \
      cd /fb/folly/folly && \
      git checkout $FOLLY_VERSION && \
      autoreconf -ivf && ./configure && \
      make -j 2 && make install && cd /fb && \
    git clone https://github.com/facebook/wangle && \
      mkdir -p /fb/wangle/wangle/build && cd /fb/wangle/wangle/build && \
      git checkout $WANGLE_VERSION && \
      cmake -D'BUILD_TESTS'='OFF' .. && \
      make -j 2 && make install && cd /fb && \
    git clone https://github.com/facebook/proxygen && \
      cd /fb/proxygen/proxygen && \
      git checkout $PROXYGEN_VERSION && \
      autoreconf -ivf && ./configure && \
      make -j 2 && make install && cd / && \
    rm -rf /fb

### Setup dockerize and ccache ###

ENV CCACHE_DIR=/ccache CC="ccache gcc" CXX="ccache g++" CCACHE_LOGFILE=/tmp/ccache.log

RUN apt-get remove -yq docker docker-engine docker.io && apt-get install -yq lsb-release python-pip software-properties-common apt-transport-https && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && apt-get install -yq docker-ce && \
    pip install dockerize && \
    mkdir -p /ccache && ccache -s && ccache -z && \
    ln -s /usr/lib/x86_64-linux-gnu/libunwind.so.8 /usr/lib/x86_64-linux-gnu/libunwind.so # libunwind is weirdly broken for linking

VOLUME [ "/ccache" ]
