#!/bin/bash
#
# G2P TensorFlow
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

DATA_HOST=$1
IMAGE=$2

if [ -z "$DATA_HOST" ]; then
    echo Please specify the data folder
    exit
fi

if [ -z "$IMAGE" ]; then
    IMAGE=g2p-seq2seq
fi

# run as daemon to support async training
echo "Running $IMAGE data folder $DATA_HOST..."
nvidia-docker run -td -v $DATA_HOST:/root/data $IMAGE
