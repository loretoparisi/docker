#!/bin/bash

IMAGE=darkflow-gpu
VIDEO=video.avi
VIDEO_OUT=$1

CONTAINER_ID=$(docker ps -a | grep $IMAGE | awk '{print $1}')
echo Downloading $VIDEO from $CONTAINER_ID as $VIDEO_OUT...
docker cp $CONTAINER_ID:/darkflow/darkflow/$VIDEO $VIDEO_OUT