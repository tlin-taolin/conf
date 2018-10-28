#!/bin/bash

# Create and activate env  --  Install pytorch from conda
export PATH="$PATH:/opt/anaconda3/bin"
echo 'Creating env and Installing pip'
conda create -y pip --name ml
source activate ml

# Get the pip and python and conda from anaconda
pip_in_env=`which pip`
python_in_env=`which python`
current_env=/home/lin/.conda/envs/ml/
#conda_in_env=`which conda`
#current_env=$conda_in_env/../..

echo "USING PYTHON: $python_in_env"
echo "USING PIP: $pip_in_env"
echo "USING CONDA IN: $conda_in_env"
echo "INSTALLING IN: $current_env"

# Install requirements (need cd otherwise sudo is denied...)
echo 'Installing requirements'
cd /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/iccluster-setup/dmlb
sudo $pip_in_env install -r requirement.txt

# Install pytorch from source

sudo /opt/anaconda3/bin/conda install -y jpeg numpy pyyaml mkl mkl-include setuptools cmake cffi --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y -c soumith magma-cuda90 --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y  opencv protobuf --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y pytorch torchvision cuda90 -c pytorch --prefix=$current_env

# install tensorpack
# $pip_in_env install --user -U git+https://github.com/ppwwyyxx/tensorpack.git

# install tensorlfow
# sudo /opt/anaconda3/bin/conda install -y -c anaconda tensorflow-gpu --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y -c conda-forge scikit-image --prefix=$current_env
