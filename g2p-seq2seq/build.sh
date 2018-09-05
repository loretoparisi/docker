#!/bin/bash
#
# G2P TensorFlow
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#
DOCKERFILE=$1
IMAGE=$2

if [ -z "$DOCKERFILE" ]; then
    DOCKERFILE=Dockerfile
fi

if [ -z "$IMAGE" ]; then
    IMAGE=g2p-seq2seq
fi

docker build -f $DOCKERFILE -t $IMAGE .
