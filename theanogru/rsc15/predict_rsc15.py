# -*- coding: utf-8 -*-
"""
Created on Wed Apr  6 18:14:46 2016

@author: Balázs Hidasi
@lastmodified: Loreto Parisi (loretoparisi at gmail dot com)
"""

import sys
import os
sys.path.append('../..')

import numpy as np
import pandas as pd
import gru4rec
import evaluation
from theano.misc.pkl_utils import dump,load

# To redirect output to file
class Logger(object):
    def __init__(self, filename="Default.log"):
        self.terminal = sys.stdout
        self.log = open(filename, "a")
    def write(self, message):
        self.terminal.write(message)
        self.log.write(message)
    def flush(self):
        pass

sys.stdout = Logger( os.environ['HOME' ] + '/theano.log' )

PATH_TO_TRAIN = os.environ['HOME']+'/rsc15_train_full.txt'
PATH_TO_TEST = os.environ['HOME']+'/rsc15_test.txt'
LAYERS = 1

if __name__ == '__main__':
    data = pd.read_csv(PATH_TO_TRAIN, sep='\t', dtype={'ItemId':np.int64})
    valid = pd.read_csv(PATH_TO_TEST, sep='\t', dtype={'ItemId':np.int64})


    #load model
    fd = open('model','rb')
    gru = load(fd)

    print('Model: {}'.format(gru))

    batch_size=10

    session_ids = valid.SessionId.values[0:batch_size]
    input_item_ids = valid.ItemId.values[0:batch_size]

    out_idx = valid.ItemId.values[0:batch_size]
    uniq_out = np.unique(np.array(out_idx, dtype=np.int32))

    #predict_for_item_ids = np.hstack([data, uniq_out[~np.in1d(uniq_out,data)]])
    predict_for_item_ids = None

    print('session_ids: {}'.format(session_ids))
    print('input_item_ids: {}'.format(input_item_ids))
    print('uniq_out: {}'.format(uniq_out))
    print('predict_for_item_ids: {}'.format(predict_for_item_ids))

    preds = gru.predict_next_batch(session_ids, input_item_ids, predict_for_item_ids, batch_size)
    preds.fillna(0, inplace=True)
    print('Preds: {}'.format(preds))