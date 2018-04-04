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

# wikidata dump
WIKIDATA_DUMP_FILE=wikidata-20180326-all-BETA.ttl.gz

#
# munge the wikidata dump
# create data files for munge
# check if data file dir exists already
#
if [ ! -d "$ROOT/split" ]; then
  echo Creating data split folder at "$ROOT/split"
  mkdir $ROOT/split
fi

#
# check wikidata file existance
#
if [ ! -f "$ROOT/$WIKIDATA_DUMP_FILE" ]; then
  echo The wikidata file does not exist
  exit
fi

# entering blazegraph root folder
cd $BLAZEGRAPH_HOME/

# 
# Pre-process the dump with Munger utility:
# Run in background and append output to nohup
# This is necessary since the container runs as a deamon
#
# The option -l en only imports English labels. 
# The option -s skips the sitelinks, for smaller storage and better performance. 
# If you need labels in other languages, 
# either add them to the list - -l en,de,ru - or skip the language option altogether. 
# If you need sitelinks, remove the -s option.
#
nohup ./munge.sh -f $ROOT/$WIKIDATA_DUMP_FILE -d $ROOT/split -l en &

