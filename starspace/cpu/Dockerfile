#
# Starspace CPU Dockerfile
# @author Loreto Parisi (loretoparisi at gmail dot com)
# @see https://github.com/facebookresearch/Starspace
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:16.04


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
	unzip \
	git \
	wget

# build boost lib
RUN \
 wget https://dl.bintray.com/boostorg/release/1.63.0/source/boost_1_63_0.zip && \
 unzip boost_1_63_0.zip && \
 mv boost_1_63_0 /usr/local/bin

# build starspace
RUN \
	git clone https://github.com/facebookresearch/Starspace.git && \
	cd Starspace && \
	make && \
	make embed_doc && \
	make query_nn && \
	make print_ngrams && \
	make query_predict

# defaults command
CMD ["bash"]

