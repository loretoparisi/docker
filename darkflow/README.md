## darkflow
This `Dockerfile` contains an image of the [darkflow](https://github.com/thtrieu/darkflow) tensorflow network for video objects detection.

## How to build
```
git clone https://github.com/loretoparisi/docker.git
cd docker/darkflow
./build.sh
```

## How to run
To run using a gpu it's needed a `DOCKER_HOST` env on the client, and the `nvidia-docker` toolkit on the host machine.
```
cd docker/darkflow
./run.sh
```

## How to use
To use darkflow for video objects detection, you have to upload a video file (mpeg-4, avi are supported by the `OpenCV` backend) to the docker running instance.
To upload the file, use the `upload.sh` script:

```
cd docker/darkflow
./upload.sh my-video-file.avi
```

To execute the video detection please use `flow3` command line with the following arguments:

```
./run.sh
[]$ cd darkflow/
./flow3 --model bin/yolo.cfg --load bin/yolo.weights --demo samples/my-video-file.avi --gpu .8 --saveVideo
```

The typical output will be

```
GPU mode with 0.8 usage
name: GRID K520
major: 3 minor: 0 memoryClockRate (GHz) 0.797
pciBusID 0000:00:03.0
Total memory: 3.94GiB
Free memory: 3.91GiB
2017-04-28 12:39:38.111613: I tensorflow/core/common_runtime/gpu/gpu_device.cc:908] DMA: 0 
2017-04-28 12:39:38.111641: I tensorflow/core/common_runtime/gpu/gpu_device.cc:918] 0:   Y 
2017-04-28 12:39:38.111671: I tensorflow/core/common_runtime/gpu/gpu_device.cc:977] Creating TensorFlow device (/gpu:0) -> (device: 0, name: GRID K520, pci bus id: 0000:00:03.0)
Finished in 4.801913022994995s

Openinng VideoCapture
height 144, width 176
4.111 FPS
End of Video
```

As soon as the computation ended, you can exit the running instance, and download the output files using the `download.sh` script:


```
cd docker/darkflow
./download.sh /some-folder/my-video-file-with-predictions.avi
```

The downloaded video file has the objects predictions

![video_lossy](https://cloud.githubusercontent.com/assets/163333/25529904/6501b8ca-2c24-11e7-94a2-cb985c7c0d7a.gif)


Please read [here](https://github.com/thtrieu/darkflow/issues/156) for more details.
