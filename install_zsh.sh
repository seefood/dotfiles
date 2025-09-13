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
# oh-my-zsh install
if [ -d ~/.oh-my-zsh/ ]; then
	echo ''
	echo "oh-my-zsh is already installed..."
	read -p "Would you like to update oh-my-zsh now?" -n 1 -r
	echo ''
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		if cd ~/.oh-my-zsh && git pull; then
			echo "Update complete..."
			cd || true
		else
			echo "Update not complete..." cd >&2
		fi
	fi
else
	echo "oh-my-zsh not found, now installing oh-my-zsh..."
	echo ''
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
#git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
#git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

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
