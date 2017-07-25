#
# GRU4Rec - "Session-based Recommendations With Recurrent Neural Networks". 
# @see https://github.com/hidasib/GRU4Rec
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# Install base packages: python3
RUN apt-get update && apt-get install -y \
  git \
  sudo \
  curl \
  software-properties-common \
  python-pip \
  python-dev \
  p7zip-full

ENV HOME /root
WORKDIR $HOME

# RecSys Challenge 2015
# http://2015.recsyschallenge.com/challenge.html
RUN \
    curl -Lo yoochoose-data.7z https://s3-eu-west-1.amazonaws.com/yc-rdata/yoochoose-data.7z && \
    7z x yoochoose-data.7z

# GRU4Rec
RUN git clone https://github.com/hidasib/GRU4Rec.git

# upgrade pip
RUN pip install --upgrade pip
# install theano and dependencies
RUN pip install scipy numpy

# anaconda
RUN \
    curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    yes "yes" | bash Anaconda3-4.2.0-Linux-x86_64.sh && \
    sudo -s source $HOME/.bashrc

# conda dependencies: Intel MKL
# @see https://unix.stackexchange.com/questions/379816/install-anaconda-in-ubuntu-docker
RUN \
    /root/yes/bin/conda install -c anaconda mkl-service && \
    /root/yes/bin/conda install theano

# test nvidia docker
CMD nvidia-smi -q

# copy scripts
COPY theanorc $HOME/.theanorc
COPY train.sh $HOME/train.sh
COPY process.sh $HOME/process.sh
COPY gpu_test.py $HOME/gpu_test.py
COPY rsc15 GRU4Rec/examples/rsc15

# defaults command
CMD ["bash"]
