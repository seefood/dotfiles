#!/usr/bin/env bash

export BASH_IT="$HOME/.bash_it"

if [ ! -d "$BASH_IT" ]; then
  git clone https://github.com/bash-it/bash-it.git "$BASH_IT"
fi

source "$BASH_IT"/bash_it.sh

# Completions
bash-it enable completion makefile pip rake virtualbox ssh system tmux \
  vagrant git git_flow gem docker docker-compose dirs defaults bash-it \
  hub homesick

# Plugins
bash-it enable plugin alias-completion base battery browser docker \
  docker-compose dirs edit-mode-emacs gif git history less-pretty-cat \
  python ruby ssh tmux virtualenv xterm z_autoenv fzf docker-machine \
  fasd hub powerline visual-studio-code

# Aliases
bash-it enable alias ag apt docker emacs vim atom git general fuck tmux \
    vagrant homesick curl homebrew homebrew-cask
