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
#  brew install screen neovim ack
#
#elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then
  echo "Doing Debian install of homesick"

  if hash homesick 2>/dev/null; then
    echo "homesick appears to be installed"
  else
    echo "installing git"
    sudo apt-get install -y git curl

    echo "installing homesick"

    sudo gem install homesick
  fi
  # Have ensured that homesick is available
  hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

  echo "installing some essential packages"
  sudo apt-get install -y neovim screen ack-grep
#fi

## Clone dotfiles
homesick clone seefood/dotfiles dotfiles

homesick symlink dotfiles

# Download Hub
if [ ! -e "$HOME/.bin/hub" ]; then
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
    mv /tmp/${HUB_OS}-${HUB_VERSION}/bin/hub ~/.bin/hub

  rm -Rf /tmp/hub*
else
  echo "Hub exists."
fi

# Install pathogen for vim/neovim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
