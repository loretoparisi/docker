#!/bin/bash

cd darknet/
# train
./darknet rnn train cfg/rnn.train.cfg -file ../shakespeare.txt
# generate
./darknet rnn generate cfg/rnn.cfg ../shakespeare.weights -srand 0 -len 1000