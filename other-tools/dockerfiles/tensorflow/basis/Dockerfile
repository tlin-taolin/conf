FROM nvidia/cuda:8.0-cudnn7-devel-ubuntu16.04

MAINTAINER Tao Lin <itamtao@gmail.com>

RUN "sh" "-c" "echo nameserver 8.8.8.8 >> /etc/resolv.conf"

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        build-essential \
        ca-certificates \
        curl \
        wget \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        python-tk \
        python-numpy \
        rsync \
        software-properties-common \
        unzip \
        zsh \
        libjpeg-dev libfreetype6-dev zlib1g-dev \
        git octave vim \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

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

RUN curl http://j.mp/spf13-vim3 -L -o - | sh

# configure user.
RUN apt-get update
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
