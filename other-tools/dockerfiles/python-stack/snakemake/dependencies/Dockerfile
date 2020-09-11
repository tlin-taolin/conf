FROM itamtao/snakemake-basis
MAINTAINER Tao Lin <itamtao@gmail.com>

# softwares/packages directory
RUN mkdir /packages

# install snakemake
RUN pip3 install snakemake

# install Graphviz
RUN apt-get install -y graphviz
# RUN pip install --no-cache-dir graphviz

# install some python packages.
RUN pip install PyYAML  \
    Cython ipython joblib sh xlrd \
    networkx pyparsing simplejson

RUN apt-get install -y --no-install-recommends \
        python-numpy python-matplotlib python-scipy
RUN pip install scikit-learn scipy

# install docutils
RUN pip install docutils

# install fastqc
RUN apt-get update && apt-get install -y fastqc

# install bowtie2
RUN apt-get install -y bowtie2

# install macs2
RUN pip install MACS2
RUN chmod +x /usr/local/bin/macs2

# install samtools

# Install R dependencies
# RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
# RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
# RUN gpg -a --export E084DAB9 | sudo apt-key add -
# RUN apt-get update \
#     && apt-get install -y r-base r-base-dev
# RUN Rscript -e 'install.packages(c("bibtex", "AnnotationDbi", "cluster", "cummeRbund", "data.table", "DBI", "DESeq2", "devtools", "dplyr"), repos="http://cran.rstudio.com/")'
# RUN Rscript -e 'install.packages(c("gdata", "ggplot2", "graphite", "igraph", "KEGGREST","knitr", "knitrBootstrap",  "lattice", "locfit", "pamr"), repos="http://cran.rstudio.com/")'
# RUN Rscript -e 'install.packages(c("pander", "pathview", "plyr", "RColorBrewer", "Rcpp", "RcppArmadillo", "RCurl", "ReactomePA", "RefManageR"), repos="http://cran.rstudio.com/")'
# RUN Rscript -e 'install.packages(c("RJSONIO", "RSQLite", "stringr","survival", "XML", "xtable", "yaml"), repos="http://cran.rstudio.com/")'



# switch to user
ENV USER_NAME tlin

USER ${USER_NAME}
VOLUME /home/${USER_NAME}/notebooks
WORKDIR /home/${USER_NAME}/notebooks

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
