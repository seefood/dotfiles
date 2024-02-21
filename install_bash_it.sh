#!/usr/bin/env bash

echo "*** Installing bash-it with some sensible defaults"

export BASH_IT="$HOME/.bash_it"

if [ ! -d "$BASH_IT" ]; then
  git clone https://github.com/bash-it/bash-it.git "$BASH_IT"
fi

source "$BASH_IT"/bash_it.sh

# Completions
bash-it enable completion makefile pip ssh system \
  docker defaults bash-it

# Plugins
bash-it enable plugin base browser \
  edit-mode-emacs gif git history less-pretty-cat\
  fasd python ruby ssh virtualenv fzf

# Aliases
bash-it enable alias ag apt vim git general fuck tmux \
    homesick curl

[[ "$OSTYPE" == "darwin"* ]] && bash-it enable completion homebrew homebrew-cask

echo "*** More options I can recommend if relevant for you:"
echo "bash-it enable completion tmux git_flow docker-compose dirs awscli \\\
      test_kitchen terraform gem"
echo
echo "bash-it enable plugin dirs battery docker docker-compose gif less-pretty-cat \\\
      tmux z_autoenv hub fzf aws docker-machine osx-timemachine powerline"
echo
echo "bash-it enable alias docker emacs atom fuck tmux osx"

~/bin/imgcat ~/.homesick/repos/dotfiles/images/MasterNods.gif
echo
echo "Done..."
