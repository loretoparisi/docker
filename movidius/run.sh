#
# Movidius NCSDK Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

IMAGE=movidius
#docker run --rm -it --privileged --device=/dev/tty.usbserial  $IMAGE bash
docker run --rm -it --net=host --privileged --device=/dev/usb/hiddev4  $IMAGE bash
