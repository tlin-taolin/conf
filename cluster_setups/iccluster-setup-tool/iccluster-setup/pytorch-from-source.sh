#!/bin/bash

conda_in_env=`which conda`
current_env=$conda_in_env/../..
python_in_env=`which python`
echo "Using $conda_in_env"
echo "Installing in $current_env"

export CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
sudo $conda_in_env install numpy pyyaml mkl setuptools cmake cffi --prefix=$current_env
$conda_in_env install -c pytorch magma-cuda80 --prefix=$current_env

if [[ $@ == **--mpi** ]]
   then
   mpirun --version &> /dev/null
   if [ $? != 0 ]; then
      echo "MPI is not installed"
      exit
   fi
fi
# sudo $conda_in_env install -c conda-forge openmpi --prefix=$current_env

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch && $python_in_env setup.py install && cd .. && rm -rf pytorch/

if [[ $@ == **--vision** ]]
   then
   git clone https://github.com/pytorch/vision.git
   cd vision && $python_in_env setup.py install && cd .. && rm -rf vision/
fi
