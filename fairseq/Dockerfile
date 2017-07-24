#
# Facebook FairSeq
# Sequence-to-sequence Toolkit
#
# @see https://github.com/facebookresearch/fairseq
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# Install git, apt-add-repository and dependencies for iTorch
RUN apt-get update && apt-get install -y \
  git \
  software-properties-common \
  ipython3 \
  libssl-dev \
  libzmq3-dev \
  python-dev \
  python-pip \
  python-zmq \
  sudo

# Install Jupyter Notebook for iTorch
RUN pip install --upgrade pip
RUN pip install jupyter

# Install Nvidia NCCL
RUN git clone https://github.com/NVIDIA/nccl.git /root/nccl && cd /root/nccl && \
    sudo make install -j4

# Run Torch7 installation scripts (dependencies only)
RUN git clone https://github.com/torch/distro.git /root/torch --recursive && cd /root/torch && \
  bash install-deps

# Run Torch7 installation scripts
RUN cd /root/torch && \
# Run without nvcc to prevent timeouts
  sed -i 's/path_to_nvcc=$(which nvcc)/path_to_nvcc=$(which no_nvcc)/g' install.sh && \
  sed -i 's,path_to_nvcc=/usr/local/cuda/bin/nvcc,path_to_nvcc=,g' install.sh && \
  ./install.sh

  # Export environment variables manually
ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH

# Set ~/torch as working directory
WORKDIR /root/torch

# Restore Torch7 installation script
RUN sed -i 's/path_to_nvcc=$(which no_nvcc)/path_to_nvcc=$(which nvcc)/g' install.sh

# Install CUDA libraries
RUN luarocks install torch && \
  luarocks install cutorch && \
  luarocks install cunn && \
  luarocks install cudnn && \
  luarocks install nn

# install R6 branch for cudnn6
RUN \
    git clone https://github.com/soumith/cudnn.torch && \
    cd cudnn.torch && \
    git checkout origin/R6 && \
    luarocks make cudnn-scm-1.rockspec

# anaconda
RUN \
    curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    yes "yes" | bash Anaconda3-4.2.0-Linux-x86_64.sh && \
    source ~/.bashrc

# conda dependencies: Intel MKL
RUN conda install -c anaconda mkl-service

WORKDIR /root/

# install Facebook fairseq
RUN \
    git clone https://github.com/facebookresearch/fairseq.git && \
    cd fairseq && \
    luarocks make rocks/fairseq-scm-1.rockspec

CMD nvidia-smi -q
CMD ["bash"]