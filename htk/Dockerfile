#
# numpy, scipy, theano, lasagne, pdnn, and htk
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#
FROM ubuntu:16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# working directory
ENV HOME /root
WORKDIR $HOME

# packages list
RUN \
	apt-get update && apt-get install -y \
    libx11-dev \
    gawk \
    python-dev \
    python-pip \
    curl \
    git

# pip
RUN pip install --upgrade pip

# copy & install compat-gcc-34-c++ compat-gcc-34
#COPY lib/*.deb $HOME/
#RUN \
#    dpkg -i $HOME/compat-gcc-34-c++_3.4.6-20_amd64.deb && \
#    dpkg -i $HOME/compat-gcc-34-c++_3.4.6-20_amd64.deb

# numlib
RUN pip install numpy scipy 
# theano and lasagne
RUN pip install theano
RUN pip install https://github.com/Lasagne/Lasagne/archive/master.zip # last working version of Lasagne

# utility dependencies
RUN pip install python-Levenshtein sklearn

# HTK
RUN \
    git clone https://github.com/loretoparisi/htk.git && \
    cd $HOME/htk && \
    ./configure --disable-hslab && \
    make all && \
    make install

# pdnn
# @see https://www.cs.cmu.edu/~ymiao/pdnntk.html
RUN git clone https://github.com/yajiemiao/pdnn

# env
ENV PYTHONPATH $HOME/pdnn:$PYTHONPATH

CMD ["bash"]
