#
# GRU4Rec - "Session-based Recommendations With Recurrent Neural Networks". 
# @see https://github.com/hidasib/GRU4Rec
#

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# Install base packages: python3
RUN apt-get update && apt-get install -y \
  git \
  sudo \
  curl \
  software-properties-common \
  ipython3 \
  python-dev \
  python-pip \
  p7zip-full


# install theano and dependencies
RUN pip install numpy scipy theano

ENV HOME /root
WORKDIR $HOME

# RecSys Challenge 2015
# http://2015.recsyschallenge.com/challenge.html
RUN \
    curl -Lo yoochoose-data.7z https://s3-eu-west-1.amazonaws.com/yc-rdata/yoochoose-data.7z && \
    7z x yoochoose-data.7z

# GRU4Rec
RUN git clone https://github.com/hidasib/GRU4Rec.git

# anaconda
RUN \
    curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    yes "yes" | bash Anaconda3-4.2.0-Linux-x86_64.sh
# update env
RUN sudo bash -c ~/.bashrc

# conda dependencies: Intel MKL
RUN conda install -c anaconda mkl-service

# test nvidia docker
CMD nvidia-smi -q

# defaults command
CMD ["bash"]
