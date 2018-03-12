#!/bin/bash

#
# Yahoo! Open NSFW Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

PORT=$1
IMAGE=nsfwaas

if [ -z "$PORT" ]; then
PORT=9080
fi

# bind port and run as a detached web service
docker run -td -p $PORT:$PORT/tcp $IMAGE
