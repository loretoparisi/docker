#
# libskk CPU Dockerfile
# @author Loreto Parisi (loretoparisi at gmail dot com)
# @see https://github.com/ueno/libskk
# v1.0.0
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:18.04

MAINTAINER Loreto Parisi loretoparisi@gmail.com

# working directory
WORKDIR /root

# install dependencies
RUN \
	apt-get update && apt-get install -y \
	software-properties-common \
	autoconf \
	autogen \
	automake \
	libtool \
	autopoint \
	libgee-0.8* \
	libjson-glib-dev \
	libxkbcommon-dev \
	gettext-base \
	gobject-introspection

RUN apt-get install -y \
	git	\
	wget

RUN add-apt-repository ppa:vala-team
RUN apt-get install -y valac

	# dictionaries
RUN \
	git clone https://github.com/skk-dev/dict.git

# # build libskk
RUN \
	git clone https://github.com/ueno/libskk.git && \
	export PATH=${PATH}:/usr/local/opt/gettext/bin && \
    cd libskk/ && \
	./autogen.sh && \
	make && \
	make install

ENV DICT /root/dict

# defaults command
CMD ["bash"]

