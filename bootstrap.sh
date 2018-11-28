#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  hash brew 2>/dev/null || (echo "install brew first" && exit 1)

  brew doctor
  #brew tap homebrew/versions
  brew tap caskroom/versions
  brew tap caskroom/fonts
  brew tap chef/chef

  echo "getting some important extra brew packages"
  brew install homesick-completion screen neovim the_silver_searcher git \
    curl wget bash hub fzf fd
  pip3 install thefuck neovim powerline-status

  cd ~/Downloads/
  wget -c https://www.python.org/ftp/python/3.6.4/python-3.6.4-macosx10.6.pkg \
    https://tunnelblick.net/release/Latest_Tunnelblick_Stable.dmg
  sudo installer -pkg python-3.6.4-macosx10.6.pkg -target /
  cd -

  python3 --version | grep "3\.6" || (echo "Python version is not 3.6.X, please install https://www.python.org/ftp/python/3.6.4/python-3.6.4-macosx10.6.pkg" && exit 1)

  echo "installing homesick"

  sudo gem install homesick --no-ri --no-rdoc

  # Have ensured that homesick is available
  hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then
  echo "Doing Debian install of homesick"

  echo "installing some essential packages"
  sudo apt-get install -y screen silversearcher-ag curl thefuck git \
      software-properties-common python3-pip
  pip3 install --upgrade powerline-status
  pip3 install --upgrade neovim

  # Adding backports, neovim and other useful bits.
  sudo add-apt-repository -u "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse"

  if hash homesick 2>/dev/null; then
    echo "homesick appears to be installed"
  else
    echo "installing ruby gems"
    sudo apt-get install -y ruby

    echo "installing homesick"

    sudo gem install homesick --no-ri --no-rdoc
  fi
  # Have ensured that homesick is available
  hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

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

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

  # Download Hub
  if [ ! -e "$HOME/bin/hub" ] && [ ! -e /usr/local/bin/hub ] ; then
    HUB_VERSION=2.6.0
    HUB_DOWNLOAD_URL=https://github.com/github/hub/releases/download
    HUB_OS=hub-linux-amd64
    FULL_URL=${HUB_DOWNLOAD_URL}/v${HUB_VERSION}/${HUB_OS}-${HUB_VERSION}.tgz

    echo "Downloading Hub ${HUB_VERSION}"

    curl -fL ${FULL_URL} > /tmp/hub.tgz && \
      tar zxf /tmp/hub.tgz -C /tmp && \
      mv /tmp/${HUB_OS}-${HUB_VERSION}/bin/hub ~/bin/hub

    rm -Rf /tmp/hub*
  else
    echo "Hub exists."
  fi

  # Download fd
  if hash fd; then
    echo "fd exists."
  else
    fdversion=7.2.0
    if [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then
      wget https://github.com/sharkdp/fd/releases/download/v${fdversion}/fd_${fdversion}_amd64.deb && \
        sudo dpkg -i fd_${fdversion}_amd64.deb
    fi

    rm -Rf fd_${fdversion}_amd64.deb
  fi
fi

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
