FROM itamtao/python-basis

MAINTAINER Tao Lin <itamtao@gmail.com>

# install packages
RUN pip install scrapy

RUN pip install --no-cache-dir pyquery
RUN pip install --no-cache-dir beautifulsoup4	
RUN pip install --no-cache-dir requests


# switch user
USER tlin
VOLUME /home/tlin/notebooks
WORKDIR /home/tlin/notebooks

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
