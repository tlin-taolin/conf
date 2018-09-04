FROM jupyter/notebook

MAINTAINER Tao Lin <itamtao@gmail.com>

# Install some essential packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libav-tools \
    build-essential gfortran python-all-dev gcc libatlas-base-dev libfreetype6-dev libpng-dev zlib1g-dev


RUN pip install --upgrade pip

RUN apt-get install -y \
                    libxml2-dev \
                    libxslt-dev

# # Install Java
# RUN apt-get update && \
# apt-get install -y openjdk-8-jre
# ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
