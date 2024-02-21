#!/bin/bash

# Adapted bits from https://github.com/jldeen/dotfiles/blob/wsl/configure.sh

# Feel free to go get the original if you are more fond of Zsh than Bash.

sudo apt-get update

sudo apt install zsh -y git bash-completion

# oh-my-zsh install
if [ -d ~/.oh-my-zsh/ ] ; then
  echo ''
  echo "oh-my-zsh is already installed..."
  read -p "Would you like to update oh-my-zsh now?" -n 1 -r
  echo ''
  if [[ $REPLY =~ ^[Yy]$ ]] ; then
    cd ~/.oh-my-zsh && git pull
    if [[ $? -eq 0 ]]
    then
      echo "Update complete..." && cd
    else
      echo "Update not complete..." >&2 cd
    fi
  fi
else
  echo "oh-my-zsh not found, now installing oh-my-zsh..."
  echo ''
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi


# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Set default shell to zsh
echo ''
read -p "Do you want to change your default shell? y/n" -n 1 -r
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Now setting default shell..."
  chsh -s $(which zsh)
  if [[ $? -eq 0 ]]
  then
    echo "Successfully set your default shell to zsh..."
  else
    echo "Default shell not set successfully..." >&2
  fi
else
  echo "You chose not to set your default shell to zsh. Exiting now..."
fi
