#!/bin/bash

brew install ansible

if [[ "$OSTYPE" == "darwin"* ]] ; then
  export HOMEBREW_CASK_OPTS=--appdir=/Applications

  brew cask install diffmerge
  rm /usr/local/bin/diffmerge
  ln -s /Applications/DiffMerge.app/Contents/Resources/diffmerge.sh /usr/local/bin/diffmerge

  brew cask install virtualbox vagrant vagrant-manager
fi
