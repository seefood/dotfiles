#!/bin/bash
function parse_git_branch {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w \[\033[01;31m\]\$(parse_git_branch)\[\033[00m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# shellcheck disable=SC1091
test -e "${HOME}/.iterm2_shell_integration.bash" &&
	source "${HOME}/.iterm2_shell_integration.bash"

function iterm2_print_user_vars() {
	iterm2_set_user_var gitBranch "$( (git branch 2>/dev/null) | grep '\*' | cut -c3-)"
}
