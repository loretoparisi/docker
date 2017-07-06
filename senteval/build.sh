#!/bin/bash

IMAGE=senteval-gpu
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
