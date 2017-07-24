#
# Train Neural Machine Translation Models with Sockeye
# @see https://aws.amazon.com/it/blogs/ai/train-neural-machine-translation-models-with-sockeye/
# @see https://github.com/awslabs/sockeye
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
  software-properties-common \
  ipython3 \
  python-dev \
  python3-pip \
  python3-numpy

# install sockeye with mxnet gpu cuda8.0
RUN pip3 install --upgrade pip
RUN \
    curl -Lo requirements.gpu-cu80.txt https://raw.githubusercontent.com/awslabs/sockeye/master/requirements.gpu-cu80.txt && \
    pip3 install sockeye --no-deps -r requirements.gpu-cu80.txt && \
    rm requirements.gpu-cu80.txt

RUN \
    curl http://data.statmt.org/wmt17/translation-task/preprocessed/de-en/corpus.tc.de.gz | gunzip | head -n 1000000 > train.de && \
    curl http://data.statmt.org/wmt17/translation-task/preprocessed/de-en/corpus.tc.en.gz | gunzip | head -n 1000000 > train.en && \
    curl http://data.statmt.org/wmt17/translation-task/preprocessed/de-en/dev.tgz | tar xvzf -

# test nvidia docker
CMD nvidia-smi -q

# copy run script
COPY train.sh $HOME/train.sh

# defaults command
CMD ["train.sh"]
