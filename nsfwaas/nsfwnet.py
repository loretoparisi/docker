#!/usr/bin/env python
"""
Copyright 2016 Yahoo Inc.
Licensed under the terms of the 2 clause BSD license.
Please see LICENSE file in the project root for terms.
"""

import numpy as np
import os
import sys
import argparse
import glob
import time
from PIL import Image
from StringIO import StringIO


# Link to prevent OpenCV error
if not os.path.exists("/dev/raw1394"):
    os.system("ln /dev/null /dev/raw1394")
# Reduce verbosity
os.environ['GLOG_minloglevel'] = '2' 

import caffe

nsfwnet = None

def resize_image(data, sz=(256, 256)):
    """
    Resize image. Please use this resize logic for best results instead of the
    caffe, since it was used to generate training dataset
    :param str data:
        The image data
    :param sz tuple:
        The resized image dimensions
    :returns bytearray:
        A byte array with the resized image
    """
    img_data = str(data)
    im = Image.open(StringIO(img_data))
    if im.mode != "RGB":
        im = im.convert('RGB')
    imr = im.resize(sz, resample=Image.BILINEAR)
    fh_im = StringIO()
    imr.save(fh_im, format='JPEG')
    fh_im.seek(0)
    return bytearray(fh_im.read())

def caffe_preprocess_and_compute(pimg, caffe_transformer=None, caffe_net=None,
    output_layers=None):
    """
    Run a Caffe network on an input image after preprocessing it to prepare
    it for Caffe.
    :param PIL.Image pimg:
        PIL image to be input into Caffe.
    :param caffe.Net caffe_net:
        A Caffe network with which to process pimg afrer preprocessing.
    :param list output_layers:
        A list of the names of the layers from caffe_net whose outputs are to
        to be returned.  If this is None, the default outputs for the network
        are returned.
    :return:
        Returns the requested outputs from the Caffe net.
    """
    if caffe_net is not None:

        # Grab the default output names if none were requested specifically.
        if output_layers is None:
            output_layers = caffe_net.outputs

        img_data_rs = resize_image(pimg, sz=(256, 256))
        image = caffe.io.load_image(StringIO(img_data_rs))

        H, W, _ = image.shape
        _, _, h, w = caffe_net.blobs['data'].data.shape
        h_off = max((H - h) / 2, 0)
        w_off = max((W - w) / 2, 0)
        crop = image[h_off:h_off + h, w_off:w_off + w, :]
        transformed_image = caffe_transformer.preprocess('data', crop)
        transformed_image.shape = (1,) + transformed_image.shape

        input_name = caffe_net.inputs[0]
        all_outputs = caffe_net.forward_all(blobs=output_layers,
                    **{input_name: transformed_image})

        outputs = all_outputs[output_layers[0]][0].astype(float)
        return outputs
    else:
        return []


class NsfwNet(object):
    model_def = '/workspace/open_nsfw/nsfw_model/deploy.prototxt'
    pretrained_model = '/workspace/open_nsfw/nsfw_model/resnet_50_1by2_nsfw.caffemodel'

    def __init__(self):
        self.nsfw_net = caffe.Net(self.model_def,  # pylint: disable=invalid-name
            self.pretrained_model, caffe.TEST)

        self.caffe_transformer = caffe.io.Transformer({'data': self.nsfw_net.blobs['data'].data.shape})
        self.caffe_transformer.set_transpose('data', (2, 0, 1))  # move image channels to outermost
        self.caffe_transformer.set_mean('data', np.array([104, 117, 123]))  # subtract the dataset-mean value in each channel
        self.caffe_transformer.set_raw_scale('data', 255)  # rescale from [0, 1] to [0, 255]
        self.caffe_transformer.set_channel_swap('data', (2, 1, 0))  # swap channels from RGB to BGR


    def classify(self,image_data):
        scores = caffe_preprocess_and_compute(image_data, caffe_transformer=self.caffe_transformer, caffe_net=self.nsfw_net, output_layers=['prob'])

        # Scores is the array containing SFW / NSFW image probabilities
        # scores[1] indicates the NSFW probability
        return scores[1]

nsfwnet = NsfwNet()

if __name__ == "__main__":
    import glob
    n = NsfwNet()
    for fn in glob.glob('*.jpg'):
        n.classify(open(fn).read())
