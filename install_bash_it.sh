#!/usr/bin/env bash

export BASH_IT="$HOME/.bash_it"

if [ ! -d "$BASH_IT" ]; then
  git clone https://github.com/seefood/bash-it.git "$BASH_IT" --branch theme_ia42
fi

source "$BASH_IT"/bash_it.sh

# Completions
bash-it enable completion makefile pip rake virtualbox ssh system tmux \
  vagrant git git_flow gem docker docker-compose dirs defaults bash-it
  
# Plugins
bash-it enable plugins alias-completion base battery browser docker docker-compose \
  dirs edit-mode-emacs gif git history less-pretty-cat python ruby ssh tmux virtualenv \
  xterm z_autoenv
  
# Aliases
bash-it enable aliases apt docker emacs vim atom git general fuck tmux vagrant
