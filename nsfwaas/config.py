#
# Yahoo! Open NSFW Web Service
# Not Suitable for Work (NSFW) classification using deep neural network Caffe models
# Adapted from https://github.com/loretoparisi/nsfwaas
# @see https://github.com/loretoparisi/nsfwaas
# @see https://github.com/yahoo/open_nsfw
#
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#

import sys
sys.path.insert(0, '/opt/caffe/python')
sys.path.insert(0, '/workspace')

from nsfwaas import app as application
