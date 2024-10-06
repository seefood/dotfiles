#!/bin/bash
function ewhich() {
	command which "$@"
	\type "$@"
}

# some more ls aliases
alias ll >/dev/null 2>&1 || alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if which -s mc; then
	# Minio or midnight Commander is installed
	unalias mc 2>/dev/null
	eval $($(which mc) --autocompletion)
else
	# Common Typo
	alias mc='mv'
fi

export HISTTIMEFORMAT="%d/%m/%y %T "
export BASH_SILENCE_DEPRECATION_WARNING=1

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	if [ -x /usr/bin/dircolors ]; then
		eval "$(dircolors -b)"
	else
		export LSCOLORS=ExFxBxDxCxegedabagacad
	fi

	alias ls >/dev/null 2>&1 || alias ls='\ls -hGF --color=auto'

	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

export HOMEBREW_AUTO_UPDATE_SECS=$((3600 * 24))

function nd() { mkdir "$1" && cd "$1" && return; }

if [[ "$0" =~ bash ]]; then
	if [[ "$BASH_IT" ]]; then
		function theme_change() {
			if [ "$1" == '--complete' ]; then
				while IFS= read -r -d '' d; do
					echo "${d##*/}"
				done < <(find "${BASH_IT}/themes" -maxdepth 1 -type d -name "$3*" ! -iname "*themes")
				exit
			fi
			sed 's/\(.*BASH_IT_THEME=\).*/\1"'"$1"'"/' ~/.bashrc >~/.bashrc.NEW &&
				cat ~/.bashrc.NEW >~/.bashrc && rm ~/.bashrc.NEW
			unset PS1 # PROMPT_COMMAND
			export BASH_IT_THEME=$1
			# shellcheck disable=SC1090
			source ~/.bashrc
		}
		complete -o default -C 'theme_change --complete $@' theme_change

	else
		## These are now handled in bash-it, but in case you haven't installed it:
		# Setup fzf
		if hash fzf 2>/dev/null && hash fd 2>/dev/null; then
			# If FD is installed, let FZF use it.
			export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
			export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
		fi

		if [ "$HOMEBREW_PREFIX" ]; then
			# Auto-completion
			# IC_AWS_ENVIRONMENT
			# TODO: fix fzf path to be ubuntu and Mac compat.
			# shellcheck disable=SC1091
			[[ $- == *i* ]] && source "$(brew --prefix fzf)/shell/completion.bash" 2>/dev/null

			# Key bindings
			# shellcheck disable=SC1091
			source "$(brew --prefix fzf)/shell/key-bindings.bash"
		fi
	fi
fi
