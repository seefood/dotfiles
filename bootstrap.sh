#!/bin/bash

set -e

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [[ "$OSTYPE" == "darwin"* ]]; then

#####################################
##################### MacOS env setup
#####################################

  if ! hash brew 2>/dev/null ; then
    echo "Installing Brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  hash brew 2>/dev/null || { echo "install brew first" ; exit 1 ; }

  brew doctor
  brew tap homebrew/cask-versions
  brew tap homebrew/cask-fonts

  echo "getting some important extra brew packages"
  brew install thefuck screen the_silver_searcher git curl hub fd fzf wget cmake node

  # This little joke kills some of our nicest code.
  test -r /etc/bashrc_Apple_Terminal && \
    sudo mv /etc/bashrc_Apple_Terminal /etc/bashrc_Apple_Terminal.disabled

elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then

#####################################
#################### Ubuntu env setup
#####################################

  echo "installing some essential packages"
  sudo apt update
  sudo apt install -y screen silversearcher-ag curl thefuck git \
      software-properties-common python3-pip rubygems tmux build-essential \
      cmake python3-dev nodejs npm python-dev

  # Adding backports, neovim and other useful bits.
  sudo add-apt-repository -u "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse"

  if ! hash nvim 2>/dev/null ; then
    echo "install neovim, trying from default sources"
    sudo apt install -y neovim || {
      sudo add-apt-repository -u ppa:neovim-ppa/stable -y && sudo apt update
      sudo apt-get install -y neovim
      sudo update-alternatives --set editor /usr/bin/nvim
      sudo update-alternatives --set ex /usr/bin/ex.nvim
      sudo update-alternatives --set rview /usr/bin/rview.nvim
      sudo update-alternatives --set rvim /usr/bin/rvim.nvim
      sudo update-alternatives --set vi /usr/bin/nvim
      sudo update-alternatives --set view /usr/bin/view.nvim
      sudo update-alternatives --set vim /usr/bin/nvim
      sudo update-alternatives --set vimdiff /usr/bin/vimdiff.nvim
    }
  fi

  # Download fd
  if hash fd 2>/dev/null ; then
    echo "fd exists."
  else
    fdversion=7.2.0
    wget -q https://github.com/sharkdp/fd/releases/download/v${fdversion}/fd_${fdversion}_amd64.deb && \
      sudo dpkg -i fd_${fdversion}_amd64.deb

    rm -Rf fd_${fdversion}_amd64.deb
  fi
  git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --no-zsh --no-fish --no-update-rc
fi

###########################
#################### Common
###########################

sudo gem install homesick -N

# Have ensured that homesick is available
hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

pip3 install --upgrade powerline-status neovim

## Clone dotfiles
echo "Cloning the dotfiles"
homesick clone seefood/dotfiles dotfiles

while read -r dir ; do
  mkdir -p ~/"${dir}"
done < ~/.homesick/repos/dotfiles/.homesick_subdir

homesick symlink dotfiles
[[ -r ~/.gitconfig.local ]] || cp ~/.gitconfig.local.example ~/.gitconfig.local
chmod 700 ~/.gnupg/

echo "Make sure you have your correct settings in ~/.gitconfig.local"

# vimrc vundle install
echo ''
echo "Now installing vundle..."
echo ''
[[ -d ~/.vim/bundle/Vundle.vim ]] || \
  git clone -q https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install pathogen for vim/neovim
mkdir -p ~/.vim/autoload ~/.vim/bundle
[[ -r ~/.vim/autoload/pathogen.vim ]] || \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Vim color scheme install
if ! [[ -d ~/.vim/colors/wombat/ ]] ; then
  echo ''
  echo "Now installing vim wombat color scheme..."
  echo ''
  git clone -q https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat
  mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/
fi

echo 'fire up vundle installation'
vim +PluginInstall +qall && echo 'vim plugins installed!'

# Bash color scheme
if [[ -r ~/.dircolors ]] ; then
  echo ''
  echo "Now installing solarized dark WSL color scheme..."
  echo ''
  wget -q https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
  mv dircolors.256dark ~/.dircolors
fi

~/bin/imgcat ~/.homesick/repos/dotfiles/images/daft-punk-Approves.gif

echo
echo "More fun awaits... Now run this:"

echo ~/.homesick/repos/dotfiles/install_general.sh
