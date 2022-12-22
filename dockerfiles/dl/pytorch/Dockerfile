FROM itamtao/base-db
MAINTAINER Tao Lin <itamtao@gmail.com>

USER $NB_USER
WORKDIR $HOME

# install conda
ENV PYTHON_VERSION=3.6
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    sh miniconda.sh -b -p $HOME/conda && \
    rm ~/miniconda.sh
RUN $HOME/conda/bin/conda update -n base conda
RUN $HOME/conda/bin/conda create -y --name pytorch-py$PYTHON_VERSION python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -c soumith magma-cuda100
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION scikit-learn
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install pytelegraf pymongo influxdb kubernetes jinja2
ENV PATH $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin:$PATH

# install pytorch, torchvision, torchtext.
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install torch==1.1.0 torchvision==0.3.0
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install --upgrade git+https://github.com/pytorch/text
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install spacy
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/python -m spacy download en
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/python -m spacy download de

# install bit2byte.
RUN git clone https://github.com/tvogels/signSGD-with-Majority-Vote.git && \
    cd signSGD-with-Majority-Vote/main/bit2byte-extension/ && \
    $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/python setup.py develop --user

# install other python related softwares.
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -y opencv protobuf
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -y networkx
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -y -c anaconda pandas
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -y -c conda-forge tabulate
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install lmdb tensorboard_logger pyarrow msgpack msgpack_numpy
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install sacrebleu
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -c conda-forge python-blosc
RUN $HOME/conda/bin/conda clean -ya
