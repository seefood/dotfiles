#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then

  hash brew 2>/dev/null || \
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
  brew tap caskroom/versions
  brew tap caskroom/fonts
  brew tap chef/chef

  echo "getting some important extra brew packages"
  brew install homesick-completion screen neovim the_silver_searcher git \
    curl wget bash hub fzf fd

  cd ~/Downloads/
  wget -c https://www.python.org/ftp/python/3.6.4/python-3.6.4-macosx10.6.pkg \
    https://tunnelblick.net/release/Latest_Tunnelblick_Stable.dmg
  sudo installer -pkg python-3.6.4-macosx10.6.pkg -target /
  cd -

  python3 --version | grep "3\.6" || (echo "Python version is not 3.6.X, please install https://www.python.org/ftp/python/3.6.4/python-3.6.4-macosx10.6.pkg" && exit 1)

elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then

  hash brew 2>/dev/null || \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

  brew doctor
  brew tap caskroom/versions
  brew tap caskroom/fonts
  brew tap chef/chef

  echo "installing some essential packages"
  sudo apt-get install -y screen silversearcher-ag curl thefuck git \
      software-properties-common python3-pip ruby

  # Adding backports, neovim and other useful bits.
  sudo add-apt-repository -u "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse"

  if ! hash nvim ; then
    echo "install neovim, trying from default sources"
    sudo apt-get install -y neovim
    if [[ $? -eq 100 ]] ; then
      echo | sudo add-apt-repository -u ppa:neovim-ppa/stable
      sudo apt-get install -y neovim
      sudo update-alternatives --set editor /usr/bin/nvim
      sudo update-alternatives --set ex /usr/bin/ex.nvim
      sudo update-alternatives --set rview /usr/bin/rview.nvim
      sudo update-alternatives --set rvim /usr/bin/rvim.nvim
      sudo update-alternatives --set vi /usr/bin/nvim
      sudo update-alternatives --set view /usr/bin/view.nvim
      sudo update-alternatives --set vim /usr/bin/nvim
      sudo update-alternatives --set vimdiff /usr/bin/vimdiff.nvim
    fi
  fi

  mkdir -p ~/bin

  brew install fzf fd hub

fi

echo "installing homesick"
if hash homesick 2>/dev/null; then
  echo "homesick appears to be installed"
else
  sudo gem install homesick --no-ri --no-rdoc
fi
# Have ensured that homesick is available
hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

pip3 install --upgrade powerline-status neovim thefuck

## Clone dotfiles
homesick clone bluevine-dev/dotfiles dotfiles

for dir in $(cat ~/.homesick/repos/dotfiles/.homesick_subdir) ; do
    mkdir -p "~/${dir}"
done

homesick symlink dotfiles

# Install pathogen for vim/neovim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Also install dein, the plugin-manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh && \
    sh /tmp/dein-installer.sh ~/.vim/bundle
