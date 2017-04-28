#!/bin/bash

IMAGE=darkflow-gpu
VIDEO=$1

fname=$(basename "$VIDEO")
extension="${fname##*.}"
fname="${fname%.*}"

CONTAINER_ID=$(docker ps -a | grep $IMAGE | awk '{print $1}')
echo Uploading $VIDEO as $fname.$extension to $CONTAINER_ID...
docker cp $VIDEO $CONTAINER_ID:/darkflow/darkflow/samples/$NAME