#
# pytorch
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#
FROM pytorch/pytorch

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# working directory
ENV HOME /root
ENV DISPLAY :0.0
WORKDIR $HOME

# packages list
RUN \
	apt-get update && apt-get install -y \
    python-dev \
    python-pip \
    curl \
    git

# pip
RUN pip install --upgrade pip

# matplotlib
RUN \
    apt-get install -y \
    libfreetype6-dev \
    libxft-dev && \
    pip install matplotlib

COPY TCN/ $HOME

CMD ["bash"]
