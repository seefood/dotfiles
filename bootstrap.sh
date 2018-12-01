#!/bin/bash

set -e

function info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

function user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

function success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit 1
}


if [[ "$OSTYPE" == "darwin"* ]]; then

  info "Installing Brew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  hash brew 2>/dev/null || fail "install brew first"

  brew doctor
  brew tap homebrew/versions
  brew tap caskroom/versions
  brew tap caskroom/fonts
  brew tap chef/chef

  info "getting some important extra brew packages"
  brew install thefuck screen neovim the_silver_searcher git curl hub fd fzf
  pip3 install neovim powerline-status

  info "installing homesick"

elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then
  info "Doing Debian install of homesick"

  info "installing some essential packages"
  sudo apt-get install -y screen silversearcher-ag curl thefuck git \
      software-properties-common python3-pip
  pip3 install --upgrade powerline-status
  pip3 install --upgrade neovim

  # Adding backports, neovim and other useful bits.
  sudo add-apt-repository -u "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse"

  if ! hash nvim ; then
    info "install neovim, trying from default sources"
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

  # Download Hub
  if [ ! -e "$HOME/bin/hub" ] && [ ! -e /usr/local/bin/hub ] ; then
    HUB_VERSION=2.6.0
    HUB_DOWNLOAD_URL=https://github.com/github/hub/releases/download
    HUB_OS=hub-linux-amd64

    if [[ "$OSTYPE" == "darwin"* ]]; then
      brew install hub
    else

      FULL_URL=${HUB_DOWNLOAD_URL}/v${HUB_VERSION}/${HUB_OS}-${HUB_VERSION}.tgz

      echo "Downloading Hub ${HUB_VERSION}"

      curl -fL ${FULL_URL} > /tmp/hub.tgz && \
        tar zxf /tmp/hub.tgz -C /tmp && \
        mv /tmp/${HUB_OS}-${HUB_VERSION}/bin/hub ~/bin/hub

      rm -Rf /tmp/hub*
    fi
  else
    echo "Hub exists."
  fi

  # Download fd
  if hash fd; then
    echo "fd exists."
  else
    fdversion=7.2.0
    wget https://github.com/sharkdp/fd/releases/download/v${fdversion}/fd_${fdversion}_amd64.deb && \
      sudo dpkg -i fd_${fdversion}_amd64.deb

    rm -Rf fd_${fdversion}_amd64.deb
  fi

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
fi

sudo gem install homesick --no-ri --no-rdoc

# Have ensured that homesick is available
hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

## Clone dotfiles
info "Cloning the dotfiles"
homesick clone seefood/dotfiles dotfiles

for dir in `cat ~/.homesick/repos/dotfiles/.homesick_subdir` ; do
  mkdir -p "~/${dir}"
done

yes | homesick symlink dotfiles

# Install pathogen for vim/neovim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Also install dein, the plugin-manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh && \
    sh /tmp/dein-installer.sh ~/.vim/bundle

# Vim color scheme install
echo ''
echo "Now installing vim wombat color scheme..."
echo ''
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat 
mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/

# Speedtest-cli, pip and jq install
echo ''
echo "Now installing Speedtest-cli, pip, tmux and jq..."
echo ''
sudo apt-get install jq tmux python-pip -y
sudo pip install --upgrade pip
sudo pip install speedtest-cli

# Bash color scheme
echo ''
echo "Now installing solarized dark WSL color scheme..."
echo ''
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark .dircolors

success "More easter eggs await.,, Check these out:"

info "~/.homesick/repos/dotfiles/install_bash_it.sh"
info "~/.homesick/repos/dotfiles/install_general.sh"
info "~/.homesick/repos/dotfiles/install_dev.sh"
info "~/.homesick/repos/dotfiles/install_zsh.sh"
