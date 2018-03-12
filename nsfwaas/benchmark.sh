#!/bin/bash

#
# Yahoo! Open NSFW Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

PORT=$1

if [ -z "$PORT" ]; then
PORT=9080
fi

ab -n 1 -p data/jennanude.jpg "http://localhost:$PORT/classify"
ab -n 10 -p data/jennanude.jpg "http://localhost:$PORT/classify"
ab -n 100 -p data/jennanude.jpg "http://localhost:$PORT/classify"