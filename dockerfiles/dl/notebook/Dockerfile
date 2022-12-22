FROM ic-registry.epfl.ch/mlo/lin-pytorch

# 
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    libsm6 \
    libxext6 \
    libxrender-dev \
    ffmpeg && \
    sudo rm -rf /var/lib/apt/lists/*

# my notebook usage.
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install influxdb pymongo pytelegraf bson
RUN $HOME/conda/envs/pytorch-py$PYTHON_VERSION/bin/pip install tqdm boto3 requests regex sentencepiece sacremoses transformers
RUN $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -y scikit-image nodejs Cython pandas scikit-learn matplotlib seaborn jupyter jupyterlab && \
    # $HOME/conda/bin/conda install --name pytorch-py$PYTHON_VERSION -c conda-forge tensorboardx && \
    $HOME/conda/bin/conda clean -ya

# # install labextensions for jupyter lab.
# RUN jupyter labextension install @jupyterlab/toc
# RUN jupyter labextension install @jupyterlab/latex
# # RUN jupyter labextension install @jupyterlab/plotly

# ## matplotlib extension for jupyter lab.
# RUN conda install -c conda-forge ipympl
# RUN conda install nodejs
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
# RUN jupyter labextension install jupyter-matplotlib

USER root
COPY start.sh /
RUN chmod +x /start.sh && fix-permissions /start.sh

USER ${NB_USER}
CMD ["/start.sh"]
EXPOSE 8888