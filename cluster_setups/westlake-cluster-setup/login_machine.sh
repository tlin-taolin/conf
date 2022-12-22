# configure env.
echo '
# configure env
alias python=/usr/bin/python3' >> ~/.bashrc

# configure tmux
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# install my vim
curl https://j.mp/spf13-vim3 -L -o - | sh

# install autojump
cd
git clone git@github.com:wting/autojump.git
cd autojump
python3 ./install.py
echo '
# autojump
[[ -s /home/taolin/.autojump/etc/profile.d/autojump.sh ]] && source /home/taolin/.autojump/etc/profile.d/autojump.sh' >> ~/.bashrc
cd ..
rm -rf autojump
