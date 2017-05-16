## fairseq
[Fairseq](https://github.com/facebookresearch/fairseq) is Facebook AI Research Sequence-to-Sequence Toolkit. It implements a convolutional NMT models for neural machine translation.

### How to build
To build the docker image run the `build.sh` script. An image named `fairseq` will be created.
```
git clone https://github.com/loretoparisi/docker.git
cd docker/fairseq
./build.sh
```

### How to run
To run the docker container `fairseq-gpu` please use the `run.sh` script. To run using a `gpu` you need the `DOCKER_HOST` env on the client and the `nvidia-docker` toolkit on the host machine.
```
cd docker/fairseq
./run.sh
```

### How to use
Please follow the fairseq tutorial [here](https://github.com/facebookresearch/fairseq#quick-start) to run pre-trained models or to train new language models.
A simple quick start is the following

```
cd docker/fairseq
./run.sh
$ cd fairseq/
$ curl https://s3.amazonaws.com/fairseq/models/wmt14.en-fr.fconv-cuda.tar.bz2 | tar xvjf -
$ fairseq generate-lines -path wmt14.en-fr.fconv-cuda/model.th7 -sourcedict wmt14.en-fr.fconv-cuda/dict.en.th7 \
    -targetdict wmt14.en-fr.fconv-cuda/dict.fr.th7 -beam 5
| [target] Dictionary: 44666 types
| [source] Dictionary: 44409 types
> Why is it rare to discover new marine mam@@ mal species ?
S	Why is it rare to discover new marine mam@@ mal species ?
O	Why is it rare to discover new marine mam@@ mal species ?
H	-0.068684287369251	Pourquoi est-il rare de découvrir de nouvelles espèces de mammifères marins ?
A	1 1 4 4 6 6 7 11 9 9 9 12 13
```
