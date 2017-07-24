#
# Darkenet CPU Dockerfile
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:16.04


MAINTAINER Loreto Parisi loretoparisi@gmail.com

# working directory
WORKDIR /root

# install
RUN \
	apt-get update && apt-get install -y \
	autoconf \
        automake \
	libtool \
	build-essential \
	git

# addons
RUN \
	apt-get install -y \
	wget

# build repo
RUN \
	git clone https://github.com/pjreddie/darknet && \
	cd darknet && \
	make

# download weights full (accurate most) and tiny (faster , less accurate) models
# darknet rnns
RUN \ 
	wget http://pjreddie.com/media/files/yolo.weights >/dev/null 2>&1 && \
	wget http://pjreddie.com/media/files/tiny-yolo-voc.weights >/dev/null 2>&1
	
# darknet nightmare	
RUN \ 
	wget http://pjreddie.com/media/files/vgg-conv.weights >/dev/null 2>&1

# darknet rnns
RUN \
	wget http://pjreddie.com/media/files/shakespeare.weights >/dev/null 2>&1 && \
	wget http://pjreddie.com/media/files/grrm.weights >/dev/null 2>&1 && \
	wget http://pjreddie.com/media/files/tolstoy.weights >/dev/null 2>&1 && \
	wget http://pjreddie.com/media/files/kant.weights >/dev/null 2>&1

# darknet rnns train shakespeare
RUN \
	wget https://ocw.mit.edu/ans7870/6/6.006/s08/lecturenotes/files/t8.shakespeare.txt >/dev/null 2>&1

# darknet go
RUN \
	wget pjreddie.com/media/files/go.weights >/dev/null 2>&1

# test executable
RUN \	
	cd darknet/ && \
	./darknet && \
# test yolo
	./darknet detector test cfg/coco.data cfg/yolo.cfg /root/yolo.weights data/dog.jpg && \
# test rnns
	./darknet rnn generate cfg/rnn.cfg /root/shakespeare.weights -srand 0 -seed CLEOPATRA -len 300

# defaults command
CMD ["bash"]

