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
