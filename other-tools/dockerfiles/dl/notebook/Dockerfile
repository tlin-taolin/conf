FROM jupyter/scipy-notebook

RUN conda install --quite --yes \
    opencv \
    scikit-image

RUN conda install --quite --yes pytorch torchvision -c pytorch
RUN pip install influxdb
