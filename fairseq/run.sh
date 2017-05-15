#!/bin/bash
#
# Facebook FairSeq
# Sequence-to-sequence Toolkit
#
# @see https://github.com/facebookresearch/fairseq
#
IMAGE=fairseq
CMD=bash

if [ -z ${BACKEND} ]; then 
    echo "Setting backend: CPU [default]"
    docker run --rm -it $IMAGE $CMD
else
    echo "Setting backend: GPU/NVIDIA"
    # execute docker run with nvidia driver and device
    docker run -it --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia0 --volume-driver nvidia-docker -v nvidia_driver_367.57:/usr/local/nvidia:ro $IMAGE $CMD
fi