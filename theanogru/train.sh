#!/bin/bash

# pre process
echo "Preprocessing..."
cd GRU4Rec/examples/rsc15
python preprocess.py
echo "Train, test files"
ls -lh /root

# training
echo "Traininig...."
python run_rsc15.py
ls -lh /root
