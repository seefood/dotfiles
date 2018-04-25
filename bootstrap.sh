#!/bin/bash

# OSX part commented out for two reasons:
# a. I've borrowed it from a guy using yadm, but I desided to stick to homesick.
# b. I have no Mac to test this on, but I'll want to have this ready as a future option.

#if [[ "$OSTYPE" == "darwin"* ]]; then
#  echo "Doing OSX install of yadm"
#
#  # Brew can be fiddly, install separately:
#  # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#  hash brew 2>/dev/null || (echo "install brew first" && exit 1)
#
#  if hash yadm 2>/dev/null; then
#    echo "yadm appears to be installed"
#  else
#    brew tap TheLocehiliosan/yadm
#    brew update
#    brew install git yadm
#  fi
#
#  # Have ensured that yadm is available
#  hash yadm 2>/dev/null || (echo "yadm install failed" && exit 1)
#
#  echo "getting some important extra brew packages"
#  brew install screen neovim silversearcher-ag
#
#elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then
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
    echo "installing git"
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

#fi

## Clone dotfiles
homesick clone seefood/dotfiles dotfiles

for dir in `cat ~/.homesick/repos/dotfiles/.homesick_subdir` ; do
    mkdir -p "~/${dir}"
done

yes | homesick symlink dotfiles

mkdir -p ~/bin

# Download Hub
if [ ! -e "$HOME/bin/hub" ]; then
  HUB_VERSION=2.3.0-pre10
  HUB_DOWNLOAD_URL=https://github.com/github/hub/releases/download
  HUB_OS=hub-linux-amd64

  if [[ "$OSTYPE" == "darwin"* ]]; then
    HUB_OS=hub-darwin-amd64
  fi

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
  fdversion=7.0.0
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install fd
  elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then
    wget https://github.com/sharkdp/fd/releases/download/v${fdversion}/fd_${fdversion}_amd64.deb && \
        sudo dpkg -i fd_${fdversion}_amd64.deb
  fi

  rm -Rf fd_${fdversion}_amd64.deb
fi

# Install pathogen for vim/neovim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

~/.homesick/repos/dotfiles/install_bash_it.sh
