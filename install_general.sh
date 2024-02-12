#!/bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]] ; then
  brew install cv editorconfig multitail rsync tree
  brew install --HEAD git-extras

  # https://bitbucket.org/WAHa_06x36/theunarchiver
  brew install unar

  brew install coreutils freetype gawk gnu-sed bat htop-osx osxutils \
    proctools psgrep wdiff up

  # http://apple.stackexchange.com/questions/135565/how-do-i-get-detailed-smart-disk-information-on-os-x-mavericks-or-later
  brew install smartmontools

  export HOMEBREW_CASK_OPTS=--appdir=/Applications
  brew install iterm2
  if [[ ! -r ~/.itermcfg/com.googlecode.iterm2.plist ]] ; then
    cp ~/.homesick/repos/dotfile/.itermcfg/* ~/.itermcfg/ || true
    ## TODO get iterm2 to use this directory with applescripting magic.
  fi

  brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json \
    qlprettypatch quicklook-csv webpquicklook suspicious-package \
    font-fira-code-nerd-font ipynb-quicklook quickjson syntax-highlight

  # Make QL plugins kosher
  xattr -d -r com.apple.quarantine ~/Library/QuickLook
  qlmanage -r

else
  sudo apt install -y rsync tree git-extras unar
fi

~/bin/imgcat ~/.homesick/repos/dotfiles/images/DanyThumbsUp.gif

echo
[[ "$OSTYPE" == "darwin"* ]] && echo "Iterm2 is set up, if you want to switch to it. Remember to set the font to Fura Code if you want beautiful powerline prompts"
echo "Looks good! Now run this:"

echo ~/.homesick/repos/dotfiles/install_dev.sh
