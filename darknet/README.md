# darknet dockerfile
[darknet](http://pjreddie.com/darknet/) is an open source neural network framework written in C and CUDA. This docker image contains all the models you need to run darknet with the following neural networks and models

- [yolo](http://pjreddie.com/darknet/yolo/) real time object detection
- [imagenet](http://pjreddie.com/darknet/imagenet/) classification
- [nightmare](http://pjreddie.com/darknet/nightmare/) cnn inception
- [rnn](http://pjreddie.com/darknet/rnns-in-darknet/) Recurrent neural networks model for text prediction
- [darkgo](http://pjreddie.com/darknet/darkgo-go-in-darknet/) Go game play

## How to build the Docker container
You can build build the docker image from the Dockerfile folder or from Docker repositories hub.

To pull the [darknet image](https://store.docker.com/community/images/loretoparisi/darknet) from the repo

```
docker pull loretoparisi/darknet
```

To build from this Dockerfile folder:

```
docker build -t darknet .
```

This will build all layers, cache each of them with a opportunist caching of git repositories for hunspell and dictionaries stable branches.

## How to build for CPU
If you have a CPU only, you can build using the `Dockerfile` contained in the `cpu/` folder. You do

```
cd cpu/
./build.sh
```

## How to build for Nvidia Docker GPU
If you have a Nvidia Docker Host with GPU, you can build using the `Dockerfile` contained in the `gpu/` folder. You do
```
cd gpu/
./build.sh
```

You can then run and enter the container doing
```
cd gpu/
./run.sh
```

This will attach the `nvidia-docker` devices and drivers, enabling the GPU support. You will see a `nvidia-smi -q` command to test the `nvidia-docker` host gpu.

You can then run and enter the container doing
```
cd cpu/
./run.sh
```

To check your that `nvidia-docker` host is properly connected, you then can do

```
cd gpu/
$ ./run.sh 
# nvidia-smi
Tue Mar 28 22:25:50 2017       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 367.57                 Driver Version: 367.57                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GRID K520           Off  | 0000:00:03.0     Off |                  N/A |
| N/A   41C    P8    17W / 125W |      0MiB /  4036MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID  Type  Process name                               Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

You should see your GPU connected.

### A note about Makefile
Note the the folder `gpu/` contains a `Makefile`. This is a modified version of the `darknet` makefile to match more recent architectures specifications:

```
ARCH= -gencode arch=compute_30,code=sm_30 \
      -gencode arch=compute_35,code=sm_35 \
      -gencode arch=compute_50,code=[sm_50,compute_50] \
      -gencode arch=compute_52,code=[sm_52,compute_52]
```

You may want to specify you architecture here replacing the above lines with the following

```
ARCH=  -gencode arch=compute_52,code=compute_52
```


## How to test the docker image

Then to run the container in interactive mode (bash) do

```
docker run --rm -it --name darknet darknet bash
```

then you can perform some darknet tasks like

Run [yolo](http://pjreddie.com/darknet/yolo/)
```
# ./darknet detector test cfg/coco.data cfg/yolo.cfg /root/yolo.weights data/dog.jpg
layer     filters    size              input                output
    0 conv     32  3 x 3 / 1   416 x 416 x   3   ->   416 x 416 x  32
    1 max          2 x 2 / 2   416 x 416 x  32   ->   208 x 208 x  32
    2 conv     64  3 x 3 / 1   208 x 208 x  32   ->   208 x 208 x  64
    3 max          2 x 2 / 2   208 x 208 x  64   ->   104 x 104 x  64
    4 conv    128  3 x 3 / 1   104 x 104 x  64   ->   104 x 104 x 128
    5 conv     64  1 x 1 / 1   104 x 104 x 128   ->   104 x 104 x  64
    6 conv    128  3 x 3 / 1   104 x 104 x  64   ->   104 x 104 x 128
    7 max          2 x 2 / 2   104 x 104 x 128   ->    52 x  52 x 128
    8 conv    256  3 x 3 / 1    52 x  52 x 128   ->    52 x  52 x 256
    9 conv    128  1 x 1 / 1    52 x  52 x 256   ->    52 x  52 x 128
   10 conv    256  3 x 3 / 1    52 x  52 x 128   ->    52 x  52 x 256
   11 max          2 x 2 / 2    52 x  52 x 256   ->    26 x  26 x 256
   12 conv    512  3 x 3 / 1    26 x  26 x 256   ->    26 x  26 x 512
   13 conv    256  1 x 1 / 1    26 x  26 x 512   ->    26 x  26 x 256
   14 conv    512  3 x 3 / 1    26 x  26 x 256   ->    26 x  26 x 512
   15 conv    256  1 x 1 / 1    26 x  26 x 512   ->    26 x  26 x 256
   16 conv    512  3 x 3 / 1    26 x  26 x 256   ->    26 x  26 x 512
   17 max          2 x 2 / 2    26 x  26 x 512   ->    13 x  13 x 512
   18 conv   1024  3 x 3 / 1    13 x  13 x 512   ->    13 x  13 x1024
   19 conv    512  1 x 1 / 1    13 x  13 x1024   ->    13 x  13 x 512
   20 conv   1024  3 x 3 / 1    13 x  13 x 512   ->    13 x  13 x1024
   21 conv    512  1 x 1 / 1    13 x  13 x1024   ->    13 x  13 x 512
   22 conv   1024  3 x 3 / 1    13 x  13 x 512   ->    13 x  13 x1024
   23 conv   1024  3 x 3 / 1    13 x  13 x1024   ->    13 x  13 x1024
   24 conv   1024  3 x 3 / 1    13 x  13 x1024   ->    13 x  13 x1024
   25 route  16
   26 reorg              / 2    26 x  26 x 512   ->    13 x  13 x2048
   27 route  26 24
   28 conv   1024  3 x 3 / 1    13 x  13 x3072   ->    13 x  13 x1024
   29 conv    425  1 x 1 / 1    13 x  13 x1024   ->    13 x  13 x 425
   30 detection
Loading weights from /root/yolo.weights...Done!
data/dog.jpg: Predicted in 8.208007 seconds.
car: 54%
bicycle: 51%
dog: 56%
Not compiled with OpenCV, saving to predictions.png instead
```

Run the [rnn](http://pjreddie.com/darknet/rnns-in-darknet/)
```
root@db6641b6c335:~# cd ./darknet/
root@db6641b6c335:~/darknet# ./darknet rnn generate cfg/rnn.cfg /root/shakespeare.weights -srand 0 -seed CLEOPATRA -len 200 
rnn
layer     filters    size              input                output
    0 RNN Layer: 256 inputs, 1024 outputs
		connected                             256  ->  1024
		connected                            1024  ->  1024
		connected                            1024  ->  1024
    1 RNN Layer: 1024 inputs, 1024 outputs
		connected                            1024  ->  1024
		connected                            1024  ->  1024
		connected                            1024  ->  1024
    2 RNN Layer: 1024 inputs, 1024 outputs
		connected                            1024  ->  1024
		connected                            1024  ->  1024
		connected                            1024  ->  1024
    3 connected                            1024  ->   256
    4 softmax                                         256
    5 cost                                            256
Loading weights from /root/shakespeare.weights...Done!
CLEOPATRA. O, the Senate House?
    These haste doth bear the studiest dangerous weeds,
    Which never had more profitable mind,
    And yet most woeful note to you,
    That hang them in these worthiest serv
```



