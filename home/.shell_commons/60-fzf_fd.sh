# shellcheck shell=bash
# shellcheck disable=SC1090
# first order of biz, if this is ubuntu/debian, fd may be called fdfind
# so let's check for that
if hash fdfind 2>/dev/null; then
	alias fd='fdfind'
fi

[[ $- == *i* ]] && return

# now that I skipped for no interactive shell, let's do the rest

# Setup fzf
# ---------
# commenting out, I already have this in my PATH guaranteed elsewhere
#if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
#fi

# also the following is generalized to fit both mac and ubuntu
# feel free to add more paths if needed
# Auto-completion
# ---------------
#source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# Key bindings
# ------------
#source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

if hash fzf 2>/dev/null && type fd &>/dev/null; then
	# If FD is installed, let FZF use it.
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if [ "$HOMEBREW_PREFIX" ]; then
	# Auto-completion
	# IC_AWS_ENVIRONMENT
	# TODO: fix fzf path to be ubuntu and Mac compat.
	# shellcheck disable=SC1091
	source "$(brew --prefix fzf)/shell/completion.${SHELL}" 2>/dev/null

	# Key bindings
	# shellcheck disable=SC1091
	source "$(brew --prefix fzf)/shell/key-bindings.${SHELL}"
else

	for init in /usr/share/doc/fzf/examples/completion.${SHELL} \
		/usr/share/doc/fzf/examples/key-bindings.${SHELL}; do
		[[ -f "${init}" ]] && source "${init}"
	done
fi
unset init
