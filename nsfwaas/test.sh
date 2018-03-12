#!/bin/bash

#
# Yahoo! Open NSFW Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

PORT=$1
DATA=$2

if [ -z "$PORT" ]; then
PORT=9080
fi

if [ -z "$DATA" ]; then
DATA=data/
fi

# go throuh images folder and test
for FILE in $DATA/*; do
    FBASE=$(basename "$FILE")
    EXT="${FBASE##*.}"
    FNAME="${FBASE%.*}"
    OUT=`curl -s -X POST -F "image=@$FILE" http://localhost:$PORT/classify`
    echo $FNAME.$EXT $OUT
done