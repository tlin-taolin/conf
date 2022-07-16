#!/usr/bin/env bash
####################### Define some system settings #######################
defaults write com.apple.desktopservices DSDontWriteNetworkStores false
####################### EOF: Define some system settings #######################

####################### Define some helper functions #######################
function prompt {
  read -p "Hit Enter to $1 ..."
}

function install {
  cmd=$1
  shift
  for pkg in $@;
  do
    exec="$cmd $pkg"
    prompt "Execute: $exec"
    if ${exec} ; then
      echo "Installed $pkg"
    else
      echo "Failed to execute: $exec"
    fi
  done
}
####################### EOF: Define some helper functions #######################

####################### Install some software. #######################
set +e
set -x

if test ! $(which brew); then
  prompt "Install Xcode"
  xcode-select --install

  prompt "Install Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  prompt "Update Homebrew"
  brew update
  brew upgrade
fi
brew doctor


prompt "Upgrade and configure zsh"
brew install zsh zsh-completions zsh-syntax-highlighting
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# configure zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# configure aliase for zsh
cp ../common/.aliases ~/
echo '
# set aliase
source ~/.aliases' >> ~/.zshrc


prompt "Install ultimate vim configuration."
curl https://j.mp/spf13-vim3 -L -o - | sh


prompt "Install packages."
brew install fontconfig
brew install git
brew install htop
brew install iftop
brew install imagemagick
brew install macvim
brew install java
echo '
# set java path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
brew install scala
brew install sbt
brew install tmux
brew install tree
brew install wget
brew install autojump
echo '
# set autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh' >> ~/.zshrc
brew install markdown
brew install ant
brew install ack

prompt "Install brew software."
brew install --cask iterm2
brew install --cask wechat
brew install --cask zotero
brew install --cask telegram
brew install --cask numi
brew install --cask spectacle
brew install --cask sublime-text
brew install --cask visual-studio-code
brew install --cask cleanmymac
brew install --cask docker
brew install --cask dropbox
brew install --cask google-chrome
brew install --cask skype
brew install --cask slack
brew install --cask voov-meeting
brew install --cask zoom
brew install --cask skim
brew install --cask notion
brew install --cask neteasemusic

brew install --cask anaconda
echo '
# anaconda path
export PATH="/opt/homebrew/anaconda3/bin:$PATH"' >> ~/.zshrc

prompt "Install ruby."
brew install rbenv ruby-build
echo '
# set ruby and rbenv
eval "$(rbenv init - zsh)"' >> ~/.zshrc
rbenv install 3.1.2


prompt "Configure KubeConfig"
echo '
# k8s.
export KUBECONFIG=~/.kube/config_runai
# export KUBECONFIG=~/.kube/config_runai' >> ~/.zshrc


prompt "configure tmux"
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

prompt "Cleanup"
brew cleanup

read -p "Run `mackup restore` after DropBox has done syncing ..."
echo "Done!"

####################### EOF: Install some software. #######################
