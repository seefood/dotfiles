#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]] ; then
  export HOMEBREW_CASK_OPTS=--appdir=/Applications

  brew cask install diffmerge
  #ln -sf /Applications/DiffMerge.app/Contents/Resources/diffmerge.sh /usr/local/bin/diffmerge

  brew cask install virtualbox vagrant vagrant-manager
else
  sudo apt install -y vagrant meld python-virtualenv
fi

if ! test -r ~/.netrc ; then
  echo "**** Creating .netrc for you. Please add in the user and a github token"
  echo "**** The Token should give us access to the github API. Please read the"
  echo "**** docs to see how to create the token."
  echo "machine github.com" > ~/.netrc
  echo "       login USER" >> ~/.netrc
  echo "       password TOKEN" >> ~/.netrc
fi
