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
brew tap homebrew/dupes

prompt "Install packages."
brew install fontconfig
brew install git
brew install git-extras
brew install gnuplot --with-qt
brew install htop
brew install iftop
brew install imagemagick --with-webp
brew install macvim
brew install java
brew install scala
brew install sbt
brew install tmux
brew install tree
brew install vim --with-override-system-vi
brew install wget
brew install autojump
brew install markdown
brew install ant
brew install ack


prompt "Install brew software."
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install cleanmymac
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install iterm2
brew cask install skype
brew cask install slack
brew cask install virtualbox
brew cask install skim
brew cask install alfred
brew cask install sourcetree
brew cask install easyfind
brew cask install macvim
brew cask install mendeley
brew cask install dash


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


prompt "Configure tmux and screen."
cp ../common/.screenrc ~/
cp ../common/.tmux.conf ~/

prompt "Install node.js and hexo."
brew install node
npm install -g hexo-cli


prompt "Install pip and other packages"
pip install --upgrade pip setuptools wheel


prompt "Cleanup"
brew cleanup
brew cask cleanup

read -p "Run `mackup restore` after DropBox has done syncing ..."
echo "Done!"

####################### EOF: Install some software. #######################
