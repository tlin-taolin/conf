FROM itamtao/pytorch-mpi:gpu

###### define env and swtich user.
USER root


###### add useful shell scripts
COPY conf/mpi_bootstrap /usr/local/bin/mpi_bootstrap
RUN chmod +x /usr/local/bin/mpi_bootstrap

COPY conf/get_hosts /usr/local/bin/get_hosts
RUN chmod +x /usr/local/bin/get_hosts

COPY conf/auto_update_hosts /usr/local/bin/auto_update_hosts
RUN chmod +x /usr/local/bin/auto_update_hosts


###### Better user experience.
# Set welcome message to display when user ssh login
COPY conf/welcome.txt /etc/motd


# Default hostfile location for mpirun. This file will be updated automatically.
ENV HYDRA_HOST_FILE /etc/opt/hosts
ENV HYDRA_SERVICENAME_FILE /etc/opt/service_names
RUN echo "export HYDRA_HOST_FILE=${HYDRA_HOST_FILE}" >> /etc/profile

RUN touch ${HYDRA_HOST_FILE}
RUN touch ${HYDRA_SERVICENAME_FILE}
RUN fix-permissions ${HYDRA_HOST_FILE}
RUN fix-permissions ${HYDRA_SERVICENAME_FILE}


###### switch to user and compile test example.
USER $NB_USER
COPY project/ .
RUN mpicc -o mpi_hello_world mpi_hello_world.c
