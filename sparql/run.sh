#!/bin/bash
#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# wikidata dump volume folder
LOCAL_VOLUME=$1
# service port
PORT=$2
# blazegraph host in the docker container
# must listen on all interfaces
# to accept incoming connections from the HOST IP
HOST=0.0.0.0
# command to launch
CMD=$3

# image root folder
HOST_VOLUME=/root/data
IMAGE=sparql

if [ -z "$PORT" ]; then
PORT=9999
fi

export HOST=$HOST

if [ -z "$CMD" ]; then
    echo "Running on $HOST:$PORT"
    CMD="bash ./runBlazegraph.sh 2>&1 >> ./out.log &"
fi

# bind port, attach volume and run
# docker run -it --rm -v /home/ubuntu/wikidata/:/root/data -p 9999:9999/tcp sparql bash
docker run -it --rm -v $LOCAL_VOLUME:$HOST_VOLUME -p $PORT:$PORT/tcp $IMAGE $CMD