#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# wikidata dump volume folder
LOCAL_VOLUME=$1
# service port
PORT=$2
# image root folder
HOST_VOLUME=/root/data
IMAGE=sparql

if [ -z "$PORT" ]; then
PORT=9999
fi

if [ -z "$CMD" ]; then
CMD="bash ./runBlazegraph.sh"
fi

# bind port, attach volume and run
docker run -it --rm -v $LOCAL_VOLUME:$HOST_VOLUME -p $PORT:$PORT/tcp $IMAGE $CMD