#
# g2p-seq2seq
# G2P with Tensorflow
# The tool does Grapheme-to-Phoneme (G2P) conversion using recurrent neural network (RNN) 
# with long short-term memory units (LSTM).
#
# @see https://github.com/cmusphinx/g2p-seq2seq
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Loreto Parisi loretoparisi@gmail.com

# working directory
ENV HOME /root
WORKDIR $HOME

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    vim

# pip
RUN pip install --upgrade pip

# tensorflow >= 1.3.0 and tensor2tensor >= 1.4.0
RUN \
    pip install tensorflow-gpu && \
    pip install tensor2tensor

# download CMU Dict
RUN \
    git clone https://github.com/cmusphinx/cmudict

# clone g2p-seq2seq.git fork
RUN \
    git clone https://github.com/ParisiLabs/g2p-seq2seq && \
    cd g2p-seq2seq/ && \
    python setup.py install && \
    cd -

# check tensorflow version
RUN python -c 'import tensorflow as tf; print(tf.__version__)'

CMD ["bash"]
