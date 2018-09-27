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
	gobject-introspection \
	locate

RUN apt-get install -y \
	git	\
	wget

RUN add-apt-repository ppa:vala-team
RUN apt-get install -y valac

# dictionaries
RUN \
	git clone https://github.com/skk-dev/dict.git

# build libskk
RUN \
	git clone https://github.com/ueno/libskk.git && \
	export PATH=${PATH}:/usr/local/opt/gettext/bin && \
    cd libskk/ && \
	./autogen.sh && \
	make && \
	make install

# build kakasi
RUN \
	git clone https://github.com/loretoparisi/kakasi.git && \
	cd kakasi/ && \
	./configure && \
	make && \
	make install
	
# lib
RUN updatedb
RUN ldconfig /usr/local/lib/

# export env
ENV DICT /root/dict

# test skk
RUN  \
	echo "A i SPC" | skk -f $DICT/SKK-JISYO.L && \
	echo "K a p a SPC K a SPC" | skk -f $DICT/SKK-JISYO.L && \
	echo "r k" | skk -r tutcode -f $DICT/SKK-JISYO.L && \
	echo "a (usleep 50000) b (usleep 200000)" | skk -r nicola -f $DICT/SKK-JISYO.L

# test kakasi
RUN \
	echo "日本が好きです。" | iconv -f utf8 -t eucjp | kakasi -i euc -Ha -Ka -Ja -Ea -ka && \
	echo "日本が好きです。" | iconv -f utf8 -t eucjp | kakasi -i euc -w | kakasi -i euc -Ha -Ka -Ja -Ea -ka && \
	echo "退屈であくびばっかしていた毎日" | iconv -f utf8 -t eucjp | kakasi -i euc -Ha -Ka -Ja -Ea -ka -s && \
	echo "7月31日" | iconv -f utf8 -t shift-jis | kakasi -Ja -Ha -Ka -Ea -s | iconv -f shift-jis -t utf8 && \
	echo "7月31日" | iconv -f utf8 -t shift-jis | kakasi -JH -KH -Ea -s | iconv -f shift-jis -t utf8 && \
	echo "7月31日" | kakasi -JH -KH -Ea -s -iutf8 -outf8

# defaults command
CMD ["bash"]

