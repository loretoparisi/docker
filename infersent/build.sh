#!/bin/bash

IMAGE=infersent-gpu
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
