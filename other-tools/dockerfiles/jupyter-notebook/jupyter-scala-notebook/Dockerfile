FROM itamtao/jupyter-base-notebook:latest
MAINTAINER Tao Lin <itamtao@gmail.com>

# Spark dependencies
# Spark dependencies
ENV APACHE_SPARK_VERSION 1.6.0
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends openjdk-7-jre-headless wget && \
    apt-get clean
RUN wget -qO - http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6 spark

# Scala Spark kernel (build and cleanup)
RUN cd /tmp && \
    echo deb http://dl.bintray.com/sbt/debian / > /etc/apt/sources.list.d/sbt.list && \
    apt-get update && \
    git clone https://github.com/ibm-et/spark-kernel.git && \
    apt-get install -yq --force-yes --no-install-recommends sbt && \
    cd spark-kernel && \
    git checkout 3905e47815 && \
    make dist SHELL=/bin/bash && \
    mv dist/spark-kernel /opt/spark-kernel && \
    chmod +x /opt/spark-kernel && \
    rm -rf ~/.ivy2 && \
    rm -rf ~/.sbt && \
    rm -rf /tmp/spark-kernel && \
    apt-get remove -y sbt && \
    apt-get clean

# Spark and config
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

# Scala Spark kernel spec
RUN mkdir -p /usr/local/share/jupyter/kernels/scala/
COPY kernel.json /usr/local/share/jupyter/kernels/scala/
