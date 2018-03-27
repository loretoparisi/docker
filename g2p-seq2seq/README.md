# Sequence-to-Sequence G2P toolkit
The tool does Grapheme-to-Phoneme (G2P) conversion using recurrent neural network (RNN) with long short-term memory units (LSTM).

See [g2p-seq2seq](https://github.com/cmusphinx/g2p-seq2seq) for more details.

## Running G2P in Docker
Start and run as a daemon the G2P container `g2p-seq2seq` and attach a volume to exchange model data
```
$ docker run -td -v $HOME:/models g2p-seq2seq
```

To train a new model using the CMUDict and save the model in the `test/` folder
```
$ g2p-seq2seq --train cmudict/cmudict.dict --model test &
```

To connect to the daemon and run inference from the model saved in the `test/` folder
```
$ docker exec -it 8170da962175 bash
root@8170da962175:~# echo "hello" | g2p-seq2seq --interactive --model test
Loading vocabularies from test
Creating 2 layers of 64 units.
Reading model parameters from test
> HH EH1 L OW0
```

To copy saved model from the `g2p-seq2seq` container to a host local volume, supposed that the container id was `8170da962175`

```
$ docker cp 8170da962175:/root/test ./models
```