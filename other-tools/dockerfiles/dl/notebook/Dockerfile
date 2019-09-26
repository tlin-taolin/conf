FROM jupyter/scipy-notebook

RUN conda install --quiet --yes \
    opencv \
    scikit-image

RUN conda install --quiet --yes pytorch torchvision -c pytorch
RUN pip install influxdb pymongo pytelegraf bson
RUN pip install tabulate
