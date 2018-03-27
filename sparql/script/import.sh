#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# wikidata dump volume folder
ROOT=/root
# wikidata dump
WIKIDATA_DUMP_FILE=wikidata-20180319-all-BETA.ttl.gz 

#
# munge the wikidata dump
# create data files for munge
# check if data file dir exists already
#
if [ ! -d "$ROOT/data/split" ]; then
  mkdir $ROOT/data/split
fi

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
nohup ./munge.sh -f $ROOT/data/$WIKIDATA_DUMP_FILE -d /root/data/split -l en &

# This will load the data files one by one into the Blazegraph data store. 
# Note that you need curl to be installed for it to work.
./loadRestAPI.sh -n wdq -d `pwd` $ROOT/data/split
