#!/bin/bash
#
# G2P TensorFlow
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

DICT_FILE=$1
MODEL_FILE=$2
LOG_FILE=$3

# Replace multi-tab to single space
g2p-seq2seq --train $DICT_FILE --model $MODEL_FILE 2>&1 >> $LOG_FILE