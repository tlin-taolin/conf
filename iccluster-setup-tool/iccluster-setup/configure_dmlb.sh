#!/bin/bash

# Create and activate env  --  Install pytorch from conda
echo 'Creating env and Installing pip'
conda create -y -n dmlb-env python=3.6 anaconda pip
source activate dmlb-env

# Get the pip and python and conda from anaconda
pip_in_env=`which pip`
python_in_env=`which python`
current_env=/home/lin/.conda/envs/dmlb-env/
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

mpirun --version &> /dev/null
if [ $? != 0 ]; then
   echo "MPI is not installed"
   exit
fi

cuda_aware=`ompi_info --parsable --all | grep mpi_built_with_cuda_support:value`
if [ ${cuda_aware##*:} != "true" ]; then
   echo "MPI is not cuda aware"
   exit
fi

# Install pytorch from source
export CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

sudo /opt/anaconda3/bin/conda install -y jpeg numpy pyyaml mkl mkl-include setuptools cmake cffi --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y -c soumith magma-cuda90 --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y protobuf --prefix=$current_env
sudo /opt/anaconda3/bin/conda install -y -c anaconda cython --prefix=$current_env

# install left packages.
$pip_in_env install opencv-python


git clone --recursive https://github.com/pytorch/pytorch
cd pytorch && \
    git submodule update --init && \
    TORCH_CUDA_ARCH_LIST="3.5 3.7 5.2 6.0 6.1 7.0+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    $pip_in_env install -v . && cd .. && rm -rf pytorch/

# install tensorpack
$pip_in_env install --user -U git+https://github.com/ppwwyyxx/tensorpack.git

# Install torchvision from source
if [[ "$1" ==  "--no-vision" ]];
   then
    exit 0
fi

# install torchvision
git clone https://github.com/pytorch/vision.git
cd vision && $python_in_env setup.py install && cd .. && rm -rf vision/
