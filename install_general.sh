#!/bin/bash

brew install ack cv editorconfig fasd multitail rsync tree thefuck
brew install --HEAD git-extras

# https://bitbucket.org/WAHa_06x36/theunarchiver
brew install unar

if [[ "$OSTYPE" == "darwin"* ]] ; then
  brew install coreutils freetype gawk gnu-sed bat gpg htop-osx osxutils \
    pkgdiff proctools psgrep neovim wdiff

  # http://apple.stackexchange.com/questions/135565/how-do-i-get-detailed-smart-disk-information-on-os-x-mavericks-or-later
  brew install smartmontools

  export HOMEBREW_CASK_OPTS=--appdir=/Applications
  brew cask install iterm2

  brew cask install sourcetree

  brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json \
    qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook \
    suspicious-package

  brew cask install font-source-code-pro-for-powerline font-inconsolata-dz-for-powerline

fi