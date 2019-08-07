FROM itamtao/tensorflow-base
MAINTAINER Tao Lin <itamtao@gmail.com>

# # setup Bazel.
# USER root
# # Running bazel inside a `docker build` command causes trouble, cf:
# #   https://github.com/bazelbuild/bazel/issues/134
# # The easiest solution is to set up a bazelrc file forcing --batch.
# RUN echo "startup --batch" >>/etc/bazel.bazelrc
# # Similarly, we need to workaround sandboxing issues:
# #   https://github.com/bazelbuild/bazel/issues/418
# RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
#     >>/etc/bazel.bazelrc
# # Install the most recent bazel release.
# ENV BAZEL_VERSION 0.15.0
# WORKDIR /
# RUN mkdir /bazel && \
#     cd /bazel && \
#     curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
#     curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36" -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE && \
#     chmod +x bazel-*.sh && \
#     ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
#     cd / && \
#     rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

USER $NB_USER
WORKDIR $HOME

# install conda
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    sh ~/miniconda.sh -b -p $HOME/conda && \
    rm ~/miniconda.sh
RUN $HOME/conda/bin/conda update -n base conda

# install python=3.5
ENV PYTHON_VERSION=3.6
RUN $HOME/conda/bin/conda create -y --name tf-py$PYTHON_VERSION python=$PYTHON_VERSION
RUN $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install --upgrade pip
ENV PATH $HOME/conda/envs/tf-py$PYTHON_VERSION/bin:$PATH

# install some fundamental packages.
RUN $HOME/conda/bin/conda install -y --name tf-py$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include

# install tensorflow.
ENV TENSORFLOW_VERSION 1.11.0
# RUN $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install --no-cache-dir tensorflow-gpu==$TENSORFLOW_VERSION
RUN wget --no-check-certificate https://lmb.informatik.uni-freiburg.de/resources/binaries/tensorflow-binaries/tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl && \
    $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl

# ENV CI_BUILD_PYTHON $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/python
# ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
# ENV TF_NEED_CUDA 1
# ENV TF_CUDA_COMPUTE_CAPABILITIES=3.0,3.5,5.2,6.0,6.1,7.5

# RUN git clone https://github.com/tensorflow/tensorflow.git && \
#     cd tensorflow && \
#     git checkout r1.12 && \
#     sudo ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 && \
#     LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:${LD_LIBRARY_PATH} \
#     tensorflow/tools/ci_build/builds/configured GPU \
#     bazel build -c opt --config=cuda \
#     --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" \
#     tensorflow/tools/pip_package:build_pip_package && \
#     rm /usr/local/cuda/lib64/stubs/libcuda.so.1 && \
#     bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip && \
#     $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip --no-cache-dir install --upgrade /tmp/pip/tensorflow-*.whl && \
#     rm -rf /tmp/pip && \
#     rm -rf /root/.cache

# install other (general) required python packages.
RUN $HOME/conda/bin/conda install --name tf-py$PYTHON_VERSION pillow matplotlib Cython h5py pandas scipy scikit-image xarray

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
    make -j                                                 
ENV PYTHONPATH="$PYTHONPATH:$HOME/lmbspecialops/python"

# install minieigen
RUN sudo apt-get update && sudo apt-get install -y libeigen3-dev libboost-python-dev 
RUN $HOME/conda/envs/tf-py$PYTHON_VERSION/bin/pip install minieigen 

# install vtk.
RUN $HOME/conda/bin/conda install -y --name tf-py$PYTHON_VERSION -c conda-forge vtk

# RUN sudo apt-get update && sudo apt-get install --yes libgl1-mesa-dev
# # download & build Tcl
# # https://www.tcl.tk/doc/howto/compile.html#unix
# RUN wget http://prdownloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz && \
#     tar -zxvf tcl8.6.6-src.tar.gz && \
#     cd tcl8.6.6/unix && \
#     ./configure && \
#     sudo make && \
#     sudo make install
# # download & build Tk
# # https://www.tcl.tk/doc/howto/compile.html
# RUN wget http://prdownloads.sourceforge.net/tcl/tk8.6.6-src.tar.gz && \
#     tar -zxvf tk8.6.6-src.tar.gz && \
#     cd tk8.6.6/unix && \
#     ./configure && \
#     sudo make && \
#     sudo make install
# # building VTK with python interface
# # http://ghoshbishakh.github.io/blog/blogpost/2016/03/05/buid-vtk.html
# RUN wget http://www.vtk.org/files/release/7.1/VTK-7.1.0.tar.gz && \
#     tar -zxvf VTK-7.1.0.tar.gz && \
#     cd VTK-7.1.0 && \
#     mkdir build && \
#     cd build && \
#     cmake \
#     -DCMAKE_BUILD_TYPE:STRING=Release \
#     -DBUILD_TESTING:BOOL=OFF \
#     -DVTK_WRAP_PYTHON:BOOL=ON \
#     -DVTK_WRAP_PYTHON_SIP:BOOL=ON \
#     -DVTK_WRAP_TCL:BOOL=ON \
#     -DVTK_PYTHON_VERSION:STRING=3 \
#     -DVTK_USE_TK:BOOL=ON \
#     ../ && \
#     make && \
#     cd Wrapping/Python && make && sudo make install
# # set environment variable to add the VTK libs to the Shared Libraries
# # http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html
# ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib:$HOME/VTK-7.1.0/build/lib

# install other related packages.
RUN $HOME/conda/bin/conda install --name tf-py$PYTHON_VERSION -y opencv
RUN $HOME/conda/bin/conda clean -ya

# install multi view H5 data reader
RUN git clone --recursive https://github.com/lmb-freiburg/demon.git && \
    cd demon && \
    mkdir build && \
    cd build && \
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs/:$LD_LIBRARY_PATH && \
    cmake .. && \
    make
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib:$HOME/demon/