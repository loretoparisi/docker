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
EPOCHS = 1
BATCH_SIZE = 50

if __name__ == '__main__':
    data = pd.read_csv(PATH_TO_TRAIN, sep='\t', dtype={'ItemId':np.int64})
    valid = pd.read_csv(PATH_TO_TEST, sep='\t', dtype={'ItemId':np.int64})
    
    print('Training GRU4Rec with ' + str(LAYERS) + ' hidden units and ' + str(EPOCHS) + ' epochs')    
    
    #Reproducing results from "Session-based Recommendations with Recurrent Neural Networks" on RSC15 (http://arxiv.org/abs/1511.06939)
    gru = gru4rec.GRU4Rec(loss='top1', 
        final_act='tanh', 
        hidden_act='tanh', 
        layers=[LAYERS], 
        batch_size=BATCH_SIZE, 
        dropout_p_hidden=0.5, 
        learning_rate=0.01, 
        momentum=0.0, 
        n_epochs=EPOCHS,
        time_sort=False)
    gru.fit(data)
    
    res = evaluation.evaluate_sessions_batch(gru, valid, None)
    print('Recall@20: {}'.format(res[0]))
    print('MRR@20: {}'.format(res[1]))
    
    #Reproducing results from "Recurrent Neural Networks with Top-k Gains for Session-based Recommendations" on RSC15 (http://arxiv.org/abs/1706.03847)
    # gru = gru4rec.GRU4Rec(loss='bpr-max-0.5', 
    #     final_act='linear', 
    #     hidden_act='tanh', 
    #     layers=[LAYERS], 
    #     batch_size=32, 
    #     dropout_p_hidden=0.0, 
    #     learning_rate=0.2, 
    #     momentum=0.5, 
    #     n_sample=2048, 
    #     sample_alpha=0,
    #     n_epochs=EPOCHS, 
    #     time_sort=True)
    # gru.fit(data)
    
    # res = evaluation.evaluate_sessions_batch(gru, valid, None)
    # print('Recall@20: {}'.format(res[0]))
    # print('MRR@20: {}'.format(res[1]))

    #
    # LP: calculate predictions on a batch of sessions items
    
    #  break_ties: boolean
    #  Whether to add a small random number to each prediction value in order to break up possible ties, which can mess up the evaluation.
    #  GRU4Rec usually does not produce ties, except when the output saturates;
    break_ties=True

    # batch_size : int
    # Number of events bundled into a batch during evaluation. Speeds up evaluation. 
    # If it is set high, the memory consumption increases. Default value is 100.
    batch_size=10
    
    session_ids = valid.SessionId.values[0:batch_size]
    input_item_ids = valid.ItemId.values[0:batch_size]
    
    out_idx = valid.ItemId.values[0:batch_size]
    uniq_out = np.unique(np.array(out_idx, dtype=np.int32))
    #predict_for_item_ids = np.hstack([data, uniq_out[~np.in1d(uniq_out,data)]])
    #LP: comment this if above works!
    predict_for_item_ids = None

    print('session_ids: {}'.format(session_ids))
    print('input_item_ids: {}'.format(input_item_ids))
    print('uniq_out: {}'.format(uniq_out))
    print('predict_for_item_ids: {}'.format(predict_for_item_ids))

    preds = gru.predict_next_batch(session_ids, input_item_ids, predict_for_item_ids, batch_size)
    preds.fillna(0, inplace=True)
    if break_ties:
        preds += np.random.rand(*preds.values.shape) * 1e-8

    print('Preds: {}'.format(preds))

    # save model
    fd = open( os.environ['HOME' ] + 'model.theano','wb')
    dump(gru,fd)
    fd.close()

    print('Model: {}'.format(md))
    
