#
# Facebook FAIR SentEval
# A python tool for evaluating the quality of sentence embeddings.
#
# @see https://github.com/facebookresearch/SentEval
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# Install base packages
RUN apt-get update && apt-get install -y \
  git \
  software-properties-common \
  python-dev \
  python-pip \
  cabextract \
  sudo

# install dependencies
RUN pip install numpy scipy nltk

WORKDIR /root/

# InferSent
RUN git clone https://github.com/facebookresearch/InferSent.git

# download dataset and models
RUN \
    cd InferSent/dataset && \
    ./get_data.bash && \
    cd ../encoder && \
    curl -Lo encoder/infersent.allnli.pickle https://s3.amazonaws.com/senteval/infersent/infersent.allnli.pickle

# test nvidia docker
CMD nvidia-smi -q

# defaults command
CMD ["bash"]