# Sequence-to-Sequence G2P toolkit
The tool does Grapheme-to-Phoneme (G2P) conversion using recurrent neural network (RNN) with long short-term memory units (LSTM).

See [g2p-seq2seq](https://github.com/cmusphinx/g2p-seq2seq) for more details.

## Running G2P in Docker
Start and run as a daemon the G2P container `g2p-seq2seq` and attach a volume to exchange models and data in the container `/root/data` folder, please use a absolute path for the host folder like `$HOME/data`

```
$ docker run -td -v $HOME/data:/root/data g2p-seq2seq
```

You should then see a container istance up:
```
CONTAINER ID    IMAGE           COMMAND     CREATED             STATUS          PORTS                   NAMES
5a603fa31d38    g2p-seq2seq     "bash"      3 seconds ago       Up 2 seconds    6006/tcp, 8888/tcp      goofy_shaw
```

To connect to the container and check the data was attached to the container
```
$ docker exec -it 5a603fa31d38 bash
root@5a603fa31d38:~# ls -l ./data/
total 8
drwxrwxr-x 4 1000 1000 4096 Mar 27 09:00 dict
drwxrwxr-x 3 1000 1000 4096 Mar 27 09:00 models
```

To configure the model you need to define the `g2p_size` that is the size of the neural network and the `g2p_split_phonemes` boolean that set to True to split by character the phonemes column in the train dataset, if it was not split already. You must set this env for inference, train and test.

```
$ export g2p_size=512
$ export g2p_split_phonemes=False
```

To run an inference from a seq2seq model saved in the `data/models` folder like the `cmudict/`
```
root@5a603fa31d38:~# echo "hello" | g2p-seq2seq --interactive --model_dir data/models/cmudict/
Loading vocabularies from test
Creating 2 layers of 64 units.
Reading model parameters from test
> HH EH1 L OW0
```

To train a new model using the CMUDict in the `data/dict/cmudict` folder and save a model in the `data/models/cmudict` folder
```
$ g2p-seq2seq --train data/dict/cmudict/cmudict.dict --model_dir data/models/cmudict 2>&1 >> train.log &
```

Do not forget the `&` (ampersand) to run the process in background. You can still you can check the logs (and errors):

```
$ tail -f train.log
```

If you are not allowed to share a volume between the host and the container, you can ccopy a saved model from the `g2p-seq2seq` container to a host local volume, supposed that the container id was `5a603fa31d38`

```
$ docker cp 5a603fa31d38:/root/test ./models
```
