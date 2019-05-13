#!/bin/bash

# install some dependences.
PYTHON_VERSION=3.6
curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    sh miniconda.sh -b -p $HOME/conda && \
    rm ~/miniconda.sh
$HOME/conda/bin/conda update -n base conda
$HOME/conda/bin/conda create -y --name pytorch-py$PYTHON_VERSION python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include
$HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -c soumith magma-cuda100
$HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION scikit-learn
$HOME/conda/envs/pytorch-py3.6/bin/pip install pytelegraf pymongo influxdb kubernetes jinja2

# configure pytorch
git clone --recursive  https://github.com/pytorch/pytorch
cd pytorch && \
    git checkout tags/v1.0.0 && \
    git submodule update --init && \
    TORCH_CUDA_ARCH_LIST="3.5 3.7 5.2 6.0 6.1 7.0+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which $HOME/conda/bin/conda))/../" \
    pip install -v .

# append env path to the zshrc. file.
echo "export PATH=$HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin:$PATH" >> ~/.zshrc