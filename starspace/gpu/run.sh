#!/bin/bash
#
# Starspace GPU Run Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2016 Loreto Parisi (loretoparisi at gmail dot com)
#

IMAGE=starspace_gpu
CMD=bash

docker run --rm -it --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia0 -v nvidia_driver_384.66:/usr/local/nvidia:ro --name $IMAGE $IMAGE $CMD

