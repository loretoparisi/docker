#!/bin/bash
# train
python3 -m sockeye.train -s train.de \
                        -t train.en \
                        -vs newstest2016.tc.de \
                        -vt newstest2016.tc.en \
                        --num-embed 128 \
                        --rnn-num-hidden 512 \
                        --attention-type dot \
                        --dropout 0.5 \
                        -o model
# translate
echo "Das grüne Haus ." | python3 -m sockeye.translate -m model 2>/dev/null