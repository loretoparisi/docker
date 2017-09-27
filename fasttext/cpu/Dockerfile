#
# FastText CPU Dockerfile
# @author Loreto Parisi (loretoparisi at gmail dot com)
# @see https://github.com/facebookresearch/fastText
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:16.04


MAINTAINER Loreto Parisi loretoparisi@gmail.com

# working directory
WORKDIR /fasttext

# install
RUN \
	apt-get update && apt-get install -y \
	autoconf \
    automake \
	libtool \
	build-essential \
	git \
	wget \
	unzip

# build fasttext
RUN \
	git clone https://github.com/facebookresearch/fastText.git && \
	cd fastText && \
	make

# defaults command
CMD ["bash"]

