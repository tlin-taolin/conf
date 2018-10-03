FROM itamtao/base
MAINTAINER Tao Lin <itamtao@gmail.com>

USER root
# install python2.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python \
        python-numpy \
        python-dev \
        python-pip \
        python-wheel \
        python-tk \
    && pip install --upgrade pip setuptools

# install some python packages.
RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        scipy \
        scikit-learn \
        sklearn \
        pandas \
        Pillow \
        h5py \
        autograd \
        powerlaw \
        seaborn \
        nltk \
        && \
    python -m ipykernel.kernelspec
RUN pip install numpy --upgrade

# Set up our notebook config.
COPY base-scipy/jupyter_notebook_config.py /root/.jupyter/
COPY base-scipy/run_jupyter.sh /

# IPython
EXPOSE 8888
