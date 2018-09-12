# configure basic
cp /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/.bash* ~/
cp /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/.profile ~/
cp /mlodata1/tlin/dl-system/conf/common/.aliases ~/

# install my vim
curl http://j.mp/spf13-vim3 -L -o - | sh

# configure screen
cp -rf /mlodata1/tlin/dl-system/conf/common/.screenrc ~/

# install autojump
sudo apt-get install autojump

# configure tmux.
cd && git clone https://github.com/gpakosz/.tmux.git && \
    ln -s -f .tmux/.tmux.conf && \
    cp /mlodata1/tlin/dl-system/conf/common/.tmux.conf.local ~/
