#!/bin/bash

set -e

uv tool install pre-commit

if [[ "$OSTYPE" == "darwin"* ]]; then
	export HOMEBREW_CASK_OPTS=--appdir=/Applications

	brew install meld
	#ln -sf /Applications/DiffMerge.app/Contents/Resources/diffmerge.sh /usr/local/bin/diffmerge

	#  if ! brew install --cask virtualbox ; then
	#    echo
	#    echo "Please open the 'Privacy and Security' control panel to allow this install and then run $0 again."
	#  fi
	#  brew install --cask vagrant vagrant-manager
	brew install --cask visual-studio-code
elif [[ -r /etc/redhat-release ]]; then
	echo "RedHat? must be running on a server. not doing anything"
else
	sudo apt install -y meld python-virtualenv
	wget "https://go.microsoft.com/fwlink/?LinkID=760868" -c -O /tmp/vscode.deb &&
		sudo apt install -y /tmp/vscode.deb && rm /tmp/vscode.deb

fi

if ! test -r ~/.netrc; then
	echo "**** Creating .netrc for you. Please add in the user and a github token"
	echo "**** The Token should give us access to the github API. Please read the"
	echo "**** docs to see how to create the token."
	echo "machine github.com" >~/.netrc
	echo "       login USER" >>~/.netrc
	echo "       password TOKEN" >>~/.netrc
fi

## Install Ira's favourite brewskies?
echo ''
read -p "Do you want to install Ira's favourite brewskies? y/n" -n 1 -r
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo ''
	echo "🍾 Installing my favourite bottles... 🍾" # why no beer bottle emoji?
	echo ''
	bottles=(
		claudekit
		attempt-cli bat dust fd ncdu parallel-disk-usage tree up jdupes
		dug wtfis
		rsync ggh hss
		git-gui git-lfs git-split-diffs git-who gitui lazygit
		gnupg
		htop psgrep progress
		ipcalc
		git-delta most ripgrep ripgrep-all
		oh-my-posh
		ollama lexido
		aws-shell awscli opentofu
		osxutils
		pixi
		podman podman-compose podman-tui
		pwgen
		sesh tmux
		shellcheck shellharden shfmt
		wtf
		wtfutil
	)
	brew install "${bottles[@]}" # installing bottles

	echo ''
	echo "🛢️ Installing my favourite casks... 🛢️" # why no wood barrel emoji?
	echo ''
	casks=(
		android-commandlinetools android-file-transfer openmtp android-platform-tools
		bettertouchtool hammerspoon karabiner-elements
		claudia block-goose cursor cursor-cli visual-studio-code jan
		superwhisper
		firefox
		font-0xproto-nerd-font font-atkynson-mono-nerd-font font-caskaydia-cove-nerd-font font-fira-code-nerd-font
		font-hack-nerd-font font-hackgen-nerd font-iosevka-term-nerd-font font-maple-mono-nf
		font-recursive-mono-nerd-font font-zed-mono-nerd-font
		font-agu-display font-alumni-sans-sc font-baskervville font-bona-nova font-briem-hand
		font-cica font-edu-sa-dotted-guide font-edu-sa-hand-cursive font-hedvig-letters-serif font-jaro
		font-madimi-one font-parkinsans font-playpen-sans-hebrew font-recursive font-story-script
		font-tac-one font-winky-sans
		gimp
		iterm2
		keepassxc proton-pass protonvpn
		nextcloud
		obs
		podman-desktop
		qlcolorcode webpquicklook qlimagesize qlmarkdown qlprettypatch qlstephen qlvideo
		quickjson quicklook-csv quicklook-json quicklookase syntax-highlight
		suspicious-package
		tunnelblick
		vial
		vlc
		wezterm@nightly
		zoom
	)
	brew install "${casks[@]}" # installing casks
	unset bottles casks
else
	echo "You chose not to install them, read $0 to be more picky. Exiting now..."
fi

## Install Claudekit and CC-plugins?
echo ''
read -p "Do you want to install Claudekit and Claude Code plugins? y/n" -n 1 -r
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo ''
	echo "🚀 Installing Claudekit and Claude Code plugins... 🚀"
	echo ''
	git clone https://github.com/carlrannaberg/claudekit.git ~/src/claudekit
	echo "🚀🚀🚀 You can now run 'claudekit setup' to see the available commands. docs: https://github.com/carlrannaberg/claudekit"
	git clone https://github.com/brennercruvinel/CCPlugins.git ~/src/CCPlugins
	echo "🚀🚀🚀 You can now read up on CC-plugins to see the available commands. docs: https://github.com/brennercruvinel/CCPlugins"
else
	echo "You chose not to install them, visit their homes to learn more:"
	echo "https://github.com/brennercruvinel/CCPlugins"
	echo "https://github.com/carlrannaberg/claudekit"
fi

~/bin/imgcat ~/.homesick/repos/dotfiles/images/chuck-norris-approves.gif
