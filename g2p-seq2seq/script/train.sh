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

#
# Train in background and append to stdout / stderr
#
# CMU example
#
# g2p-seq2seq --train data/dict/cmudict/cmudict.dict --model data/models/cmudict-512 2>&1 >> ./train.log
#
# CMU-IPA example
# g2p-seq2seq --train data/dict/cmudict-ipa/cmudict-ipa.dict --model data/models/cmudict-ipa/ 2>&1 >> ./train.log
#
g2p-seq2seq --train $DICT_FILE --model $MODEL_FILE 2>&1 >> $LOG_FILE &