#!/bin/bash

IMAGE=openpose
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
