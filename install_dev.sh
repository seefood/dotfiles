#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]] ; then
  export HOMEBREW_CASK_OPTS=--appdir=/Applications

  brew install --cask diffmerge
  #ln -sf /Applications/DiffMerge.app/Contents/Resources/diffmerge.sh /usr/local/bin/diffmerge

#  if ! brew install --cask virtualbox ; then
#    echo
#    echo "Please open the 'Privacy and Security' control panel to allow this install and then run $0 again."
#  fi
#  brew install --cask vagrant vagrant-manager
  brew install --cask visual-studio-code
else
  sudo apt install -y meld python-virtualenv
  wget "https://go.microsoft.com/fwlink/?LinkID=760868" -c -O /tmp/vscode.deb && \
    sudo apt install -y /tmp/vscode.deb && rm /tmp/vscode.deb
fi

~/bin/imgcat ~/.homesick/repos/dotfiles/images/chuck-norris-approves.gif

if ! test -r ~/.netrc ; then
  echo "**** Creating .netrc for you. Please add in the user and a github token"
  echo "**** The Token should give us access to the github API. Please read the"
  echo "**** docs to see how to create the token."
  echo "machine github.com" > ~/.netrc
  echo "       login USER" >> ~/.netrc
  echo "       password TOKEN" >> ~/.netrc
fi
