#!/bin/bash

IMAGE=theanogru-gpu
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
