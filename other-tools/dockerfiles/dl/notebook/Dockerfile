FROM jupyter/scipy-notebook

RUN conda install --quiet --yes \
    opencv \
    scikit-image

RUN conda install --quiet --yes pytorch torchvision -c pytorch
RUN pip install influxdb pymongo pytelegraf bson
RUN pip install tabulate
RUN pip install tqdm boto3 requests regex sentencepiece sacremoses transformers

# install labextensions for jupyter lab.
RUN jupyter labextension install @jupyterlab/toc
RUN jupyter labextension install @jupyterlab/latex
# RUN jupyter labextension install @jupyterlab/plotly

## matplotlib extension for jupyter lab.
RUN conda install -c conda-forge ipympl
RUN conda install nodejs
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyter-matplotlib
