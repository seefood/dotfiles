#!/bin/bash

set -e

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

#####################################
##################### MacOS env setup
#####################################

  echo "Installing Brew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  hash brew 2>/dev/null || fail "install brew first"

  brew doctor
  brew tap caskroom/versions
  brew tap caskroom/fonts
  brew tap chef/chef

  echo "getting some important extra brew packages"
  brew install thefuck screen neovim the_silver_searcher git curl hub fd fzf
  pip3 install neovim powerline-status

  (cd ~/Downloads/
  wget -c https://www.python.org/ftp/python/3.6.4/python-3.6.4-macosx10.6.pkg \
    https://tunnelblick.net/release/Latest_Tunnelblick_Stable.dmg
  sudo installer -pkg python-3.6.4-macosx10.6.pkg -target /
  )

  python3 --version | grep '3\.6' || (echo "Python version is not 3.6.X, please install https://www.python.org/ftp/python/3.6.4/python-3.6.4-macosx10.6.pkg" && exit 1)

  # This little joke kills some of our nicest code.
  sudo mv /etc/bashrc_Apple_Terminal /etc/bashrc_Apple_Terminal.disabled

elif [[ "$(lsb_release -is)" == "Ubuntu" ]] || [[ "$(lsb_release -is)" == "Debian" ]] ; then

#####################################
#################### Ubuntu env setup
#####################################

  echo "installing some essential packages"
  sudo apt-get install -y screen silversearcher-ag curl thefuck git \
      software-properties-common python3-pip rubygems
  pip3 install --upgrade powerline-status
  pip3 install --upgrade neovim

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

  echo "installing some essential packages"
  sudo apt-get install -y tmux neovim

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

###########################
#################### Common
###########################

sudo gem install homesick --no-ri --no-rdoc

# Have ensured that homesick is available
hash homesick 2>/dev/null || (echo "homesick install failed" && exit 1)

pip3 install --upgrade powerline-status neovim

## Clone dotfiles
echo "Cloning the dotfiles"
homesick clone git@github.com:bluevine-dev/dotfiles.git dotfiles || \
  homesick clone git@github.com:bluevine-dev/dotfiles.

while read -r dir ; do
  mkdir -p ~/"${dir}"
done < ~/.homesick/repos/dotfiles/.homesick_subdir

homesick symlink dotfiles
[[ -r ~/.gitconfig.local ]] || cp ~/.gitconfig.local.example ~/.gitconfig.local

user "Make sure you have your correct settings in ~/.gitconfig.local"

# vimrc vundle install
echo ''
echo "Now installing vundle..."
echo ''
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install pathogen for vim/neovim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo 'fire up vundle installation'
nvim +PluginInstall +qall && success 'vim plugins installed!'

# Vim color scheme install
echo ''
echo "Now installing vim wombat color scheme..."
echo ''
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat
mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/

# Bash color scheme
echo ''
echo "Now installing solarized dark WSL color scheme..."
echo ''
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark ~/.dircolors

success "More easter eggs await... Check these out:"

echo ~/.homesick/repos/dotfiles/install_bash_it.sh
echo ~/.homesick/repos/dotfiles/install_general.sh
echo ~/.homesick/repos/dotfiles/install_dev.sh
