#
# Darkflow Dockerfile (YOLO for Tensorflow)
# Tensorflow + GPU + Python3 + OpenCV 3.1.0
#
# @see https://github.com/thtrieu/darkflow
# @see https://hub.docker.com/r/tensorflow/tensorflow/tags/
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM tensorflow/tensorflow:latest-gpu-py3

MAINTAINER Loreto Parisi loretoparisi@gmail.com

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    ffmpeg \
    build-essential \
    cmake git pkg-config libswscale-dev \
    libtbb2 libtbb-dev libjpeg-dev \
	libpng-dev libtiff-dev libjasper-dev \
    python3-numpy \
    python3-pip

RUN mkdir OpenCV && cd OpenCV

RUN apt-get update && apt-get install -y \
  build-essential \
  checkinstall \
  cmake \
  pkg-config \
  yasm \
  libtiff5-dev \
  libjpeg-dev \
  libjasper-dev \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  libdc1394-22-dev \
 # libxine-dev \
  libgstreamer0.10-dev \
  libgstreamer-plugins-base0.10-dev \
  libv4l-dev \
  python-dev \
  python-numpy \
  python-pip \
  libtbb-dev \
  libeigen3-dev \
  libqt4-dev \
  libgtk2.0-dev \
  # Doesn't work libfaac-dev \
  libmp3lame-dev \
  libopencore-amrnb-dev \
  libopencore-amrwb-dev \
  libtheora-dev \
  libvorbis-dev \
  libxvidcore-dev \
  x264 \ 
  v4l-utils \
 # Doesn't work ffmpeg \
  libgtk2.0-dev \
#  zlib1g-dev \
#  libavcodec-dev \
  unzip \
  libhdf5-dev \
  wget \
  sudo
    

RUN cd /opt && \
  wget https://github.com/daveselinger/opencv/archive/3.1.0-with-cuda8.zip -O opencv-3.1.0.zip -nv && \
  unzip opencv-3.1.0.zip && \
  mv opencv-3.1.0-with-cuda8 opencv-3.1.0 && \
  cd opencv-3.1.0 && \
  rm -rf build && \
  mkdir build && \
  cd build && \
  cmake -D CUDA_ARCH_BIN=3.2 \
    -D CUDA_ARCH_PTX=3.2 \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_TBB=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D WITH_V4L=ON \
    -D BUILD_TIFF=ON \
    -D WITH_QT=ON \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
 #   -D USE_GStreamer=ON \
    -D WITH_OPENGL=ON .. && \
  make -j4 && \
  make install && \
  echo "/usr/local/lib" | sudo tee -a /etc/ld.so.conf.d/opencv.conf && \
  ldconfig
RUN cp /opt/opencv-3.1.0/build/lib/cv2.so /usr/lib/python2.7/dist-packages/cv2.so

WORKDIR /darkflow/

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py

RUN \ 
    pip3 install --no-cache-dir Cython

RUN \
    git clone https://github.com/thtrieu/darkflow.git
# copy patches to setup.py, net/help.py, flow
COPY setup.py darkflow/darkflow
COPY flow3 darkflow/
COPY help.py darkflow/darkflow/net/

RUN \
    cd darkflow && \
    ls -l && \
    python3 setup.py build_ext --inplace
    #pip3 install .

# download weights full (accurate most) and tiny (faster , less accurate) models
# darknet rnns
RUN \
    cd darkflow && \
    mkdir bin && cd bin/ && \
	wget http://pjreddie.com/media/files/yolo.weights >/dev/null 2>&1 && \
    wget https://github.com/leetenki/YOLOtiny_v2_chainer/raw/master/tiny-yolo-voc.weights >/dev/null 2>&1 && \
    wget https://github.com/thtrieu/darkflow/blob/master/cfg/yolo.cfg >/dev/null 2>&1 && \
    cd ..

RUN \
    cd darkflow/ && \
    mkdir samples && cd samples/ && \
    wget -O video_1.avi ftp://vqeg.its.bldrdoc.gov/MM/7-12_testclip/7-12_testclip_QCIF.avi

# FIXME: copy yolo.cfg to cfg/
RUN \
    cd darkflow/ && \
    cp bin/yolo.cfg cfg/

CMD nvidia-smi -q
RUN python3 -c "import Cython; print(Cython.__version__)"
RUN python3 -c "import cv2; print(cv2.__version__)"
RUN echo "./flow3 --model bin/yolo.cfg --load bin/yolo.weights --demo samples/video_1.avi --gpu .8 --saveVideo"
CMD ["bash"]

#install TF python module
#RUN python3 setup.py build_ext --inplace
