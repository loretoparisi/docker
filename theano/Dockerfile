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
  build-essential \
  software-properties-common \
  cmake \
  python3-pip \
  p7zip-full

ENV HOME /root
WORKDIR $HOME

# upgrade pip
RUN pip3 install --upgrade pip
# install theano and dependencies
RUN pip3 install scipy numpy cython nose pandas

# anaconda
# RUN \
#     curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
#     yes "yes" | bash Anaconda3-4.2.0-Linux-x86_64.sh && \
#     sudo -s source $HOME/.bashrc

# # conda dependencies: Intel MKL
# # @see https://unix.stackexchange.com/questions/379816/install-anaconda-in-ubuntu-docker
# RUN \
#     /root/yes/bin/conda install -c anaconda mkl-service && \
#     /root/yes/bin/conda install pygpu && \
#     /root/yes/bin/conda install theano

# if using anaconda comment the following line
RUN pip3 install theano

# test nvidia docker
CMD nvidia-smi -q

# libgpuarray
# @see http://deeplearning.net/software/libgpuarray/installation.html
RUN \
    git clone https://github.com/Theano/libgpuarray.git && \
    cd libgpuarray && \
    mkdir Build && \
    cd Build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make && \
    sudo make install && \
    cd .. && \    
    python3 setup.py build && \
    python3 setup.py install && \
    sudo ldconfig

# GRU4Rec
RUN git clone https://github.com/loretoparisi/GRU4Rec.git

# RecSys Challenge 2015
# http://2015.recsyschallenge.com/challenge.html
RUN \
    curl -Lo yoochoose-data.7z https://s3-eu-west-1.amazonaws.com/yc-rdata/yoochoose-data.7z && \
    7z x yoochoose-data.7z

# copy scripts
COPY theanorc $HOME/.theanorc
COPY train.sh $HOME/train.sh
COPY process.sh $HOME/process.sh
COPY gpu_test.py $HOME/gpu_test.py
COPY rsc15 GRU4Rec/examples/rsc15

# defaults command
CMD ["bash"]
