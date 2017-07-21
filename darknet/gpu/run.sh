#!/bin/bash
#
# Darkenet GPU Run Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2016 Loreto Parisi (loretoparisi at gmail dot com)
#

IMAGE=darknet_gpu
if [ $1="train" ]; then
CMD=./train.sh
else
CMD=bash
fi

docker run --rm -it --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia0 -v nvidia_driver_367.57:/usr/local/nvidia:ro --name $IMAGE $IMAGE $CMD

