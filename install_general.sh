#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]] ; then
  brew install cv editorconfig fasd multitail rsync tree
  brew install --HEAD git-extras

  # https://bitbucket.org/WAHa_06x36/theunarchiver
  brew install unar

  brew install coreutils freetype gawk gnu-sed bat htop-osx osxutils \
    pkgdiff proctools psgrep neovim wdiff up

  # http://apple.stackexchange.com/questions/135565/how-do-i-get-detailed-smart-disk-information-on-os-x-mavericks-or-later
  brew install smartmontools

  export HOMEBREW_CASK_OPTS=--appdir=/Applications
  brew cask install iterm2
  if [[ ! -r ~/.itermcfg/com.googlecode.iterm2.plist ]] ; then
    cp ~/.homesick/repos/dotfile/.itermcfg/* ~/.itermcfg/
    ## TODO get iterm2 to use this directory with applescripting megic.
  fi

  brew cask install sourcetree

  brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json \
    qlprettypatch quicklook-csv qlimagesize webpquicklook \
    suspicious-package

  brew cask install font-source-code-pro-for-powerline font-inconsolata-dz-for-powerline

else
  sudo apt install -y rsync tree git-extras unar
fi
