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
# command to launch
CMD=$3

# image root folder
HOST_VOLUME=/root/data
IMAGE=sparql

if [ -z "$PORT" ]; then
PORT=9999
fi

# bind port, attach volume and run as daemon
docker run -td -v $LOCAL_VOLUME:$HOST_VOLUME -p $PORT:$PORT/tcp $IMAGE