#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# wikidata dump volume folder
VOLUME=$1
# service port
PORT=$2
# image root folder
ROOT=/root
IMAGE=sparql

# attach volume and run import script
docker run -v $VOLUME:$ROOT $IMAGE