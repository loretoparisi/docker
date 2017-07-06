# scipy, numpy, scikit-learn
pip install numpy scipy scikit-learn sklearn
# cabextract
sudo apt-get install cabextract
# conda needed for pytorch
curl https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda2-latest-Linux-x86_64.sh
# todo: needs manual [ENTER] the T&C agreement
bash Miniconda2-latest-Linux-x86_64.sh
# update PATH
source $HOME/.bashrc
# pytorch
conda install pytorch torchvision cuda80 -c soumith
# senteval
git clone https://github.com/facebookresearch/SentEval.git
# infersent
git clone https://github.com/facebookresearch/InferSent.git
# install dataset
cd SentEval/data
./get_transfer_data.bash
cd ..
# inferSent models
curl -Lo examples/infersent.allnli.pickle https://s3.amazonaws.com/senteval/infersent/infersent.allnli.pickle
curl -Lo examples/infersent.snli.pickle https://s3.amazonaws.com/senteval/infersent/infersent.snli.pickle
# gloVe models
cd examples/
./get_glove.bash
##################
# test gloVe
python bow.py
##################
# test infersent tasks
python infersent.py