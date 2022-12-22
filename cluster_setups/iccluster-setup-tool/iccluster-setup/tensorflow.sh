#!/bin/bash

# Create and activate env  --  Install tensorflow from conda
export PATH="$PATH:/opt/anaconda3/bin"
echo 'Creating env and Installing pip'
conda create -y pip --name tf
source activate tf

# Get the pip and python and conda from anaconda
pip_in_env=`which pip`
python_in_env=`which python`
current_env=/home/lin/.conda/envs/tf

# Install requirements (need cd otherwise sudo is denied...)
sudo /opt/anaconda3/bin/conda install -y dill seaborn numpy pyyaml mkl setuptools cmake cffi --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y -c aaronzs tensorflow-gpu=1.4.1 --prefix=$current_env

# Install bfp-sgd.
echo 'Installing bfp-sgd'
cd /mlodata1/tlin/bfp-sgd
$pip_in_env install -r ./requirement.txt
$pip_in_env install -e .
