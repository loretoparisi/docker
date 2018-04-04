#!/bin/bash
#
# SPARQL Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# wikidata dump volume folder
# it will contain the split folder
# and the wikidata journal file: wikidata.jnl
# example: /root/wikidata
ROOT=/root/data

convertsecs() { #Function used to convert seconds into HH:MM:SS
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}
typeset -fx convertsecs # export to sub-shells
                        # maybe this is implicit with your version of Bash

NOW=$(exec date +%s)

cmd() {
    #echo it"'"s fact of life than shell   # Replace by *your*
    #echo quoting can be a '"nightmare"'   # actual commands
    ls -hl $ROOT/wikidata.jnl
}
typeset -fx cmd

watch -n 1 \
    'bash -c '"'"'cat <(cmd) \
                      <(echo Elapsed $(convertsecs $(($(exec date +%s) - '$NOW'))))'"'"