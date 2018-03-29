#!/bin/bash
#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# wikidata dump volume folder
ROOT=/root
WIKIDATA=wikidata-20150427-all-BETA.ttl.gz

#
# To update the database from Wikidata fresh edits, 
# open a second terminal and run the updater with the wdq Blazegraph namespace:
# The updater is designed to run constantly, but can be interrupted and resumed at any time.
#
# Note that if you loaded an old dump, or did not load any dump at all, 
# it may require very long time for the data to be full syncronized, 
# as updater only picks up recently edited items. Use the same set of language/skip 
# options as in the munge.sh script, e.g. -l en -s.
#
./runUpdate.sh 2>&1 >> ./update.log &
