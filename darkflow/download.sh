#!/bin/bash

IMAGE=darkflow-gpu
VIDEO=video.avi

CONTAINER_ID=$(docker ps -a | grep $IMAGE | awk '{print $1}')
echo Downloading $VIDEO from $CONTAINER_ID...
docker cp $CONTAINER_ID:/darkflow/darkflow/$VIDEO ./$VIDEO