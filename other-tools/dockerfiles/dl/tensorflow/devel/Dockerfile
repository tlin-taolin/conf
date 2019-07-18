FROM itamtao/tensorflow-base
MAINTAINER Tao Lin <itamtao@gmail.com>

# setup Bazel.
USER root
# Running bazel inside a `docker build` command causes trouble, cf:
#   https://github.com/bazelbuild/bazel/issues/134
# The easiest solution is to set up a bazelrc file forcing --batch.
RUN echo "startup --batch" >>/etc/bazel.bazelrc
# Similarly, we need to workaround sandboxing issues:
#   https://github.com/bazelbuild/bazel/issues/418
RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
    >>/etc/bazel.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.5.4
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

USER $NB_USER
WORKDIR $HOME

# install conda
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    sh ~/miniconda.sh -b -p $HOME/conda && \
    rm ~/miniconda.sh
RUN $HOME/conda/bin/conda update -n base conda

# install python=3.5
ENV PYTHON_VERSION=3.5
RUN $HOME/conda/bin/conda create -y --name tf-py$PYTHON_VERSION python=$PYTHON_VERSION
RUN $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install --upgrade pip
ENV PATH $HOME/conda/envs/tf-py$PYTHON_VERSION/bin:$PATH

# install vtk==7.1.
# RUN $HOME/conda/bin/conda install --name tf-py$PYTHON_VERSION -c conda-forge vtk=7.1
# RUN wget https://www.vtk.org/files/release/7.1/VTK-7.1.0.tar.gz && \
#     tar -zxvf VTK-7.1.0.tar.gz && \
#     cd VTK-7.1.0 && \
#     mkdir build && \
#     cd build && \
#     cmake-gui ..
RUN sudo apt-get update && sudo apt-get install --yes libgl1-mesa-dev
# download & build Tcl
# https://www.tcl.tk/doc/howto/compile.html#unix
RUN wget http://prdownloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz && \
    tar -zxvf tcl8.6.6-src.tar.gz && \
    cd tcl8.6.6/unix && \
    ./configure && \
    sudo make && \
    sudo make install
# download & build Tk
# https://www.tcl.tk/doc/howto/compile.html
RUN wget http://prdownloads.sourceforge.net/tcl/tk8.6.6-src.tar.gz && \
    tar -zxvf tk8.6.6-src.tar.gz && \
    cd tk8.6.6/unix && \
    ./configure && \
    sudo make && \
    sudo make install
# building VTK with python interface
# http://ghoshbishakh.github.io/blog/blogpost/2016/03/05/buid-vtk.html
RUN wget http://www.vtk.org/files/release/7.1/VTK-7.1.0.tar.gz && \
    tar -zxvf VTK-7.1.0.tar.gz && \
    cd VTK-7.1.0 && \
    mkdir build && \
    cd build && \
    cmake \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DBUILD_TESTING:BOOL=OFF \
    -DVTK_WRAP_PYTHON:BOOL=ON \
    -DVTK_WRAP_PYTHON_SIP:BOOL=ON \
    -DVTK_WRAP_TCL:BOOL=ON \
    -DVTK_PYTHON_VERSION:STRING=3 \
    -DVTK_USE_TK:BOOL=ON \
    ../ && \
    make && \
    cd Wrapping/Python && make && make install
# set environment variable to add the VTK libs to the Shared Libraries
# http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib:$HOME/VTK-7.1.0/build/lib

# install some fundamental packages.
RUN $HOME/conda/bin/conda install -y --name tf-py$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include

# install tensorflow 1.4.0.
ENV TENSORFLOW_VERSION 1.4.0
RUN $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install --no-cache-dir tensorflow-gpu==$TENSORFLOW_VERSION

# install other (general) required python packages.
RUN $HOME/conda/bin/conda install --name tf-py$PYTHON_VERSION pillow matplotlib Cython h5py pandas scipy scikit-image xarray

# install minieigen
RUN sudo apt-get install -y libeigen3-dev libboost-python-dev
RUN $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install minieigen 

# build lmbspecialops
RUN git clone https://github.com/lmb-freiburg/lmbspecialops && \
    cd lmbspecialops                                        && \
    git checkout 3e01ebaf0da6a5d0545f1ffead4bccdbe79a26f5   && \
    find . -type f -print0 | xargs -0 sed -i 's/data.starts_with(/str_util::StartsWith(data,/g' && \
    find . -type f -print0 | xargs -0 sed -i 's/^set_target_properties.*GLIBCXX_USE_CXX11_ABI.*/#/g' && \
    mkdir build                                             && \
    cd build                                                && \
    sudo ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 && \
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs/:$LD_LIBRARY_PATH && \
    cmake ..                                                && \
    make -j                                                 && \
    sudo rm /usr/local/cuda/lib64/stubs/libcuda.so.1
ENV PYTHONPATH="$PYTHONPATH:$HOME/lmbspecialops/python"

# install other related packages.
RUN $HOME/conda/bin/conda install --name tf-py$PYTHON_VERSION -y opencv
RUN $HOME/conda/bin/conda clean -ya
