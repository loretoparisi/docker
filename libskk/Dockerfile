#
# libskk CPU Dockerfile
# @author Loreto Parisi (loretoparisi at gmail dot com)
# @see https://github.com/ueno/libskk
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:16.04


MAINTAINER Loreto Parisi loretoparisi@gmail.com

# working directory
WORKDIR /root

# install dependencies
RUN \
	apt-get update && apt-get install -y \
	apt-utils \
	autoconf \
	autogen \
	automake \
	libtool \
	autopoint \
	gettext \
	libgee-0.8* \
	libjson-glib-dev \
	libxkbcommon-dev

RUN apt-get install -y \
	git	\
	wget

# manually updated gettext to latest
RUN \
	wget http://archive.ubuntu.com/ubuntu/pool/main/g/gettext/gettext_0.19.8.1-4ubuntu1_amd64.deb && \
	dpkg -i gettext_0.19.8.1-4ubuntu1_amd64.deb && \
	apt-get update && \
	apt show gettext

# build libskk
RUN \
	git clone https://github.com/ueno/libskk.git && \
	export PATH=${PATH}:/usr/local/opt/gettext/bin && \
    cd libskk/ && \
	./autogen.sh && \
	make && \
	make install

# dictionaries
RUN \
	git clone https://github.com/skk-dev/dict.git

ENV DICT /root/dict

# defaults command
CMD ["bash"]

