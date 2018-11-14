FROM jupyter/scipy-notebook

RUN conda install --quite --yes \
    opencv \
    scikit-image

RUN pip install influxdb

# configure user.
USER root
ENV SHELL=/bin/bash \
    NB_USER=lin \
    NB_UID=144057 \
    NB_GROUP=MLO-unit \
    NB_GID=11169
ENV HOME=/home/$NB_USER

ADD base/fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions
ADD base/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN groupadd $NB_GROUP -g $NB_GID
RUN useradd -m -s /bin/bash -N -u $NB_UID -g $NB_GID $NB_USER && \
    echo "${NB_USER}:${NB_USER}" | chpasswd && \
    usermod -aG sudo,adm,root ${NB_USER} && \
    fix-permissions $HOME
RUN echo 'lin ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

USER ${NB_USER}
