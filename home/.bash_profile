#!/usr/bin/env bash

# shellcheck disable=SC1090
[[ -f ~/.bashrc ]] && source ~/.bashrc

# shellcheck disable=SC1091
test -e "${HOME}/.iterm2_shell_integration.bash" &&
	source "${HOME}/.iterm2_shell_integration.bash"
