#!/bin/bash

IMAGE=sockeye-gpu
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
