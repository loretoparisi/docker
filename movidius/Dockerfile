#
# movidius NCSDK
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
      build-essential \
      git \
      lsb-release \
      sudo \
      udev \
      usbutils \
      wget \
    && apt-get clean all

RUN useradd -c "Movidius User" -m movidius

COPY 10-installer /etc/sudoers.d/
RUN mkdir -p /etc/udev/rules.d/
USER movidius
WORKDIR /home/movidius
RUN git clone https://github.com/movidius/ncsdk.git
WORKDIR /home/movidius/ncsdk
RUN make install
RUN make examples

CMD ["bash"]