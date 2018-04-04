#!/bin/bash
#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# blazegraph install folder
BLAZEGRAPH_HOME=/root/blazegraph

# wikidata dump volume folder
# it will contain the split folder
# and the wikidata journal file: wikidata.jnl
# example: /root/wikidata
ROOT=/root/data

# blazegraph log file
LOGS=$ROOT/server.log

# blazegraph host in the docker container
# must listen on all interfaces
# to accept incoming connections from the HOST IP
HOST=0.0.0.0
export HOST=$HOST

# entering blazegraph root folder
cd $BLAZEGRAPH_HOME/

./runBlazegraph.sh 2>&1 >> $LOGS &
