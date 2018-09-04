FROM itamtao/scipy-dev

MAINTAINER Tao Lin <itamtao@gmail.com>

RUN pip install --no-cache-dir sparsesvd

# switch user
USER tlin
VOLUME /home/tlin/notebooks
WORKDIR /home/tlin/notebooks

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
