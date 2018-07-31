# configure basic
cp /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/.bash* ~/
cp /mlodata1/tlin/dl-system/conf/iccluster-setup-tool/.profile ~/

# install my vim
curl http://j.mp/spf13-vim3 -L -o - | sh

# configure tmux
cp -rf /mlodata1/tlin/dl-system/conf/common/.tmux.conf ~/
cp -rf /mlodata1/tlin/dl-system/conf/common/.screenrc ~/

sudo cp -rf /mlodata1/tlin/dl-system/conf/common/iccluster /usr/local/bin/iccluster
sudo chmod +x /usr/local/bin/iccluster

# install autojump
sudo apt-get install autojump
