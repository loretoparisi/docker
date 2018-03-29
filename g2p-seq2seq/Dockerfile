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

FROM tensorflow/tensorflow:1.5.0

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

# download pretrained model
RUN \
    wget -q -O g2p-seq2seq-cmudict.tar.gz https://sourceforge.net/projects/cmusphinx/files/G2P%20Models/g2p-seq2seq-cmudict.tar.gz/download && \
    tar xf g2p-seq2seq-cmudict.tar.gz

# download CMU Dict
RUN \
    git clone https://github.com/cmusphinx/cmudict

# clone g2p-seq2seq.git fork
RUN \
    git clone https://github.com/loretoparisi/g2p-seq2seq.git && \
    cd g2p-seq2seq/ && \
    python setup.py install && \
    cd -

CMD ["bash"]
