#
# Facebook FairSeq
# Sequence-to-sequence Toolkit
#
# @see https://github.com/facebookresearch/fairseq
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
RUN pip install numpy scipy scikit-learn sklearn

WORKDIR /root/

# SentEval
RUN git clone https://github.com/facebookresearch/SentEval.git

# download dataset and models
RUN \
    cd SentEval/data && \
    ./get_transfer_data.bash && \
    cd .. && \
    curl -Lo examples/infersent.allnli.pickle https://s3.amazonaws.com/senteval/infersent/infersent.allnli.pickle && \
    curl -Lo examples/infersent.snli.pickle https://s3.amazonaws.com/senteval/infersent/infersent.snli.pickle && \
    cd examples/ && \
    ./get_glove.bash

# test gloVe
RUN python bow.py

# test infersent tasks
RUN python infersent.py

# test nvidia docker
CMD nvidia-smi -q

# defaults command
CMD ["bash"]