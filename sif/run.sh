#!/bin/bash

IMAGE=sif-gpu
if [ "$1" == "train" ]; then
CMD=./train.sh
elif [ "$1" == "demo" ]; then
CMD=./demo.sh
else
CMD=bash
fi

docker run -it $IMAGE $CMD
