#!/bin/bash

IMAGE=fairseq
# execute docker run with nvidia driver and device
docker build -t $IMAGE .
