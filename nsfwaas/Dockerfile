#
# Yahoo! Open NSFW Web Service
# Not Suitable for Work (NSFW) classification using deep neural network Caffe models
# Adapted from https://github.com/loretoparisi/nsfwaas
# @see https://github.com/loretoparisi/nsfwaas
# @see https://github.com/yahoo/open_nsfw
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM ubuntu:16.04

# To build for GPU
# FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Loreto Parisi loretoparisi@gmail.com

# Based on CAFFE's CPU container

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python-dev \
    python-setuptools \
    python-numpy \
    python-pip \
    python-scipy \
	cython \
	python-skimage \
	python-matplotlib \
	ipython \
	python-h5py \
	python-leveldb \
	python-networkx \
	python-nose \
	python-pandas \
	python-dateutil \
	python-protobuf \
	python-gflags \
	python-yaml \
	python-pil \
	python-six \
	python-flask \
    python-tornado \
	apache2 \
	libapache2-mod-wsgi \
	supervisor && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Build Caffe
ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: clone a specific git tag and use ARG instead of ENV once DockerHub supports this.
ENV CLONE_TAG=master

RUN pip install --upgrade pip

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 .. && \
    make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# Web Server config
ARG PORT
ARG DIST
ENV PORT $PORT
ENV DIST $DIST

WORKDIR /workspace

# Copy the model and deploy the app server
#RUN git clone https://github.com/yahoo/open_nsfw.git
COPY open_nsfw /workspace/open_nsfw
COPY nsfwnet.py /workspace/
COPY nsfwaas.py /workspace/

# Set up Apache
RUN a2enmod wsgi
RUN a2dissite 000*
# copy virtual host and replace port
COPY nsfwaas.conf /workspace/nsfwaas.conf
RUN sed "s/\$PORT/$PORT/g" /workspace/nsfwaas.conf > /etc/apache2/sites-available/nsfwaas.conf
RUN sed -i "s/80/$PORT/g" /etc/apache2/ports.conf
COPY config.py /workspace/
RUN a2ensite nsfwaas

# Configure supervisord
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the webserver
EXPOSE $PORT

# Start supervisord
CMD ["/usr/bin/supervisord"]
