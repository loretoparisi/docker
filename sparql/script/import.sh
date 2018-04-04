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

#
# munge the wikidata dump
# create data files for munge
# check if data file dir exists already
#
if [ ! -d "$ROOT/split" ]; then
  echo The split folder has not been found inside "$ROOT", please run split.sh first
  exit
fi

# entering blazegraph root folder
cd $BLAZEGRAPH_HOME/

#
# This will load the data files one by one into the Blazegraph data store. 
# Note that you need curl to be installed for it to work.
#
# Run in background and append output to nohup
# This is necessary since the container runs as a deamon
#
nohup ./loadRestAPI.sh -n wdq -d $ROOT/split &
