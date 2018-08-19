# configure basic
cp /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/.bash* ~/
cp /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/.profile ~/

# install my vim
curl http://j.mp/spf13-vim3 -L -o - | sh

# configure tmux
cp -rf /mlodata1/tlin/dl-system/conf/common/.tmux.conf ~/
cp -rf /mlodata1/tlin/dl-system/conf/common/.screenrc ~/

# install autojump
sudo apt-get install autojump
