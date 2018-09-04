FROM ubuntu:wily

MAINTAINER Tao Lin <itamtao@gmail.com>
USER root

# install some necessary ....
RUN apt-get update && apt-get -y upgrade && \
	apt-get install -yq --no-install-recommends \
        	pkg-config \
            build-essential \
            ca-certificates \
            gcc \
            make
RUN apt-get install -y --no-install-recommends \
            git emacs vim-tiny zsh \
            wget curl htop \
            bzip2 unzip libsm6 \
			ed less locales \
            && apt-get clean

# set environments
RUN apt-get -y install language-pack-en
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

# install Java
RUN apt-get install -y openjdk-7-jre
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# install python
# remove several traces of debian python
RUN apt-get purge -y python.*
RUN apt-get -y install python3-pip python3.5

RUN apt-get -y install python-pip python python-dev
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py
RUN pip install --upgrade pip

# Add user information.
ENV USER_NAME tlin

# Add user information
RUN useradd --shell /bin/zsh --create-home ${USER_NAME}
# set password
RUN echo "${USER_NAME}:${USER_NAME}" | chpasswd
RUN usermod -aG sudo,adm ${USER_NAME}
