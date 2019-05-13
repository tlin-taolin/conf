#!/bin/bash

# Create and activate env  --  Install pytorch from conda
export PATH="$PATH:/opt/anaconda3/bin"
echo 'Creating env and Installing pip'
conda create -y pip --name ml
source activate ml

# Get the pip and python and conda from anaconda
pip_in_env=`which pip`
python_in_env=`which python`
#conda_in_env=`which conda`
#current_env=$conda_in_env/../..

echo "USING PYTHON: $python_in_env"
echo "USING PIP: $pip_in_env"
echo "USING CONDA IN: $conda_in_env"
echo "INSTALLING IN: $current_env"

# Install requirements (need cd otherwise sudo is denied...)
echo 'Installing requirements'
cd ../iccluster-setup-tool/iccluster-setup/dmlb
sudo $pip_in_env install -r requirement.txt

# Install pytorch from source

conda install -y jpeg numpy pyyaml mkl mkl-include setuptools cmake cffi 
conda install -y  opencv protobuf 
conda install -y pytorch torchvision -c pytorch
conda install -c conda-forge python-kubernetes 


# install tensorpack
$pip_in_env install --user -U git+https://github.com/ppwwyyxx/tensorpack.git

# install tensorlfow
conda install -y -c conda-forge scikit-image
