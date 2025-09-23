#!/bin/bash

# Adapted bits from https://github.com/jldeen/dotfiles/blob/wsl/configure.sh

# Feel free to go get the original if you are more fond of Zsh than Bash.

if [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -x /bin/zsh ]; then
		brew install zsh-completions
	else
		brew install zsh zsh-completions
	fi
else
	sudo apt-get update
	sudo apt install zsh -y git bash-completion
fi
# oh-my-zsh and plugin installs removed as I switched to zinit and it al happens automagically

# Set default shell to zsh
echo ''
read -p "Do you want to change your default shell? y/n" -n 1 -r
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Now setting default shell..."
	if chsh -s "$(which zsh)"; then
		echo "Successfully set your default shell to zsh..."
	else
		echo "Default shell not set successfully..." >&2
	fi
else
	echo "You chose not to set your default shell to zsh. Exiting now..."
fi
