#
# DPGAN
# Tensorflow
#
# @see https://github.com/lancopku/DPGAN
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM tensorflow/tensorflow:1.3.0-py3

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

# matplotlib
RUN \
    apt-get install -y \
    libfreetype6-dev \
    libxft-dev && \
    pip install matplotlib

RUN yes | pip install \
    nltk

COPY src/ $HOME

CMD ["bash"]
