# sockeye
[Sockeye](https://github.com/awslabs/sockeye) is a sequence-to-sequence framework for Neural Machine Translation based on Apache MXNet. It implements the well-known encoder-decoder architecture with attention.

# How to build
To build the docker image run the build.sh script. An image named `sockeye-gpu` will be created.

```
git clone https://github.com/loretoparisi/docker.git
cd docker/sockeye
./build.sh
```

The built images will have the necessary parallel corpus to test a first translation model:

```
newstest2014-deen-ref.de.sgm  newstest2014-deen-src.en.sgm  newstest2015-deen-ref.en.sgm  newstest2015-ende-src.en.sgm  newstest2016-deen-ref.en.sgm  newstest2016-ende-src.en.sgm  train.de
newstest2014-deen-ref.en.sgm  newstest2014.tc.de            newstest2015-deen-src.de.sgm  newstest2015.tc.de            newstest2016-deen-src.de.sgm  newstest2016.tc.de            train.en
newstest2014-deen-src.de.sgm  newstest2014.tc.en            newstest2015-ende-ref.de.sgm  newstest2015.tc.en            newstest2016-ende-ref.de.sgm  newstest2016.tc.en            train.sh
```

# How to run
To run the docker container `sockeye-gpu` please use the `run.sh` script. This will setup the `nvidia-docker` params for you.
The `run.sh` script accept as first parameter the command to execute. Choose `train` to start training the parallel corpus `en`, `de`.
```
cd docker/sockeye
./run.sh train
```

The training process will start

```
[loretoparisi@:mbploreto sockeye]$ ./run.sh train
[INFO:__main__] Command: /usr/local/lib/python3.5/dist-packages/sockeye/train.py -s train.de -t train.en -vs newstest2016.tc.de -vt newstest2016.tc.en --num-embed 128 --rnn-num-hidden 512 --attention-type dot --dropout 0.5 -o model
[INFO:__main__] Arguments: Namespace(attention_coverage_num_hidden=1, attention_coverage_type='count', attention_num_hidden=None, attention_type='dot', attention_use_prev_word=False, batch_size=64, bucket_width=10, checkpoint_frequency=1000, clip_gradient=1.0, context_gating=False, device_ids=[-1], disable_device_locking=False, dropout=0.5, fill_up='replicate', initial_learning_rate=0.0003, learn_lexical_bias=False, learning_rate_half_life=10, learning_rate_reduce_factor=0.5, learning_rate_reduce_num_not_improved=3, learning_rate_scheduler_type='plateau-reduce', lexical_bias=None, lock_dir='/tmp', loss='cross-entropy', max_num_checkpoint_not_improved=8, max_seq_len=100, max_updates=-1, metrics=['perplexity'], momentum=None, monitor_bleu=0, no_bucketing=False, normalize_loss=False, num_embed=128, num_embed_source=None, num_embed_target=None, num_words=50000, optimized_metric='perplexity', optimizer='adam', output='model', overwrite_output=False, params=None, quiet=False, rnn_cell_type='lstm', rnn_forget_bias=0.0, rnn_h2h_init='orthogonal', rnn_num_hidden=512, rnn_num_layers=1, rnn_residual_connections=False, seed=13, smoothed_cross_entropy_alpha=0.3, source='train.de', source_vocab=None, target='train.en', target_vocab=None, use_cpu=False, use_fused_rnn=False, use_tensorboard=False, validation_source='newstest2016.tc.de', validation_target='newstest2016.tc.en', weight_decay=0.0, weight_tying=False, word_min_count=1)
[INFO:sockeye.utils] Attempting to acquire 1 GPUs of 1 GPUs. The requested devices are: [-1]
[INFO:sockeye.utils] Acquired GPU 0.
[INFO:__main__] Device(s): GPU [0]
[INFO:sockeye.vocab] Building vocabulary from dataset: train.de
[INFO:sockeye.vocab] Initial vocabulary: 325419 types
[INFO:sockeye.vocab] Pruned vocabulary: 325419 types (min frequency 1)
[INFO:sockeye.vocab] Final vocabulary: 50004 types (min frequency 1, top 50000 types)
[INFO:sockeye.vocab] Vocabulary saved to "/root/model/vocab.src.json"
[INFO:sockeye.vocab] Building vocabulary from dataset: train.en
[INFO:sockeye.vocab] Initial vocabulary: 144392 types
[INFO:sockeye.vocab] Pruned vocabulary: 144392 types (min frequency 1)
[INFO:sockeye.vocab] Final vocabulary: 50004 types (min frequency 1, top 50000 types)
[INFO:sockeye.vocab] Vocabulary saved to "/root/model/vocab.trg.json"
[INFO:__main__] Vocabulary sizes: source=50004 target=50004
[INFO:sockeye.data_io] Creating train data iterator
[INFO:sockeye.data_io] 1000000 sentences loaded from '/root/train.de'
[INFO:sockeye.data_io] 1000000 sentences loaded from '/root/train.en'
[INFO:sockeye.data_io] Average training target/source length ratio: 0.91
[INFO:sockeye.data_io] Source words: 19742891
[INFO:sockeye.data_io] Target words: 21267926
[INFO:sockeye.data_io] Vocab coverage source: 97%
[INFO:sockeye.data_io] Vocab coverage target: 99%
[INFO:sockeye.data_io] Total: 10 samples in 10 buckets
```

