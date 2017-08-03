#
# SIF: Sentence embedding by Smooth Inverse Frequency weighting scheme
# PrincetonML
# Code for the paper: "A Simple but Tough-to-Beat Baseline for Sentence Embeddings".
# @see https://openreview.net/forum?id=SyK00v5xx
# @see https://github.com/PrincetonML/SIF
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

ENV HOME /root
WORKDIR $HOME

# Install base packages: python3
RUN apt-get update && apt-get install -y \
  git \
  sudo \
  curl \
  wget \
  unzip \
  python-pip

#  upgrade pip
RUN pip install --upgrade pip
# dependencies: lasagne need master
# @see https://github.com/Lasagne/Lasagne/issues/867
RUN \
    pip install numpy scipy sklearn theano && \
    pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

RUN \
    git clone https://github.com/PrincetonML/SIF.git && \
    mkdir SIF/examples/log

# test nvidia docker
CMD nvidia-smi -q

# copy run script
COPY train.sh $HOME/train.sh
COPY demo.sh $HOME/demo.sh
COPY theanorc $HOME/.theanorc

# defaults command
CMD ["train.sh"]
