#!/bin/bash

IMAGE=opencv
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
