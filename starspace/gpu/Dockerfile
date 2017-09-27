#
# Starspace GPU Dockerfile
# @author Loreto Parisi (loretoparisi at gmail dot com)
# @see https://github.com/facebookresearch/Starspace
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04


MAINTAINER Loreto Parisi loretoparisi@gmail.com

# working directory
WORKDIR /starspace

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

# build boost lib
RUN \
 wget https://dl.bintray.com/boostorg/release/1.63.0/source/boost_1_63_0.zip && \
 unzip boost_1_63_0.zip && \
 mv boost_1_63_0 /usr/local/bin

# build starspace
RUN \
	git clone https://github.com/facebookresearch/Starspace.git && \
	cd Starspace && \
	make

# test nvidia docker
CMD nvidia-smi -q

# defaults command
CMD ["bash"]

