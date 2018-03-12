#!/bin/bash

#
# Yahoo! Open NSFW Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

PORT=$1
DIST=$2
IMAGE=nsfwaas

if [ -z "$PORT" ]; then
PORT=9080
fi

if [ -z "$ENV" ]; then
DIST='prod'
fi

docker build --build-arg DIST=$DIST --build-arg PORT=$PORT -t $IMAGE .