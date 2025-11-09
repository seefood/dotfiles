# shellcheck shell=bash
# shellcheck disable=SC1090
# first order of biz, if this is ubuntu/debian, fd may be called fdfind
# so let's check for that
if hash fdfind 2>/dev/null; then
	alias fd='fdfind'
fi

[[ -o interactive ]] || return

# now that I skipped for no interactive shell, let's do the rest

# fzf from homebrew is nice, but what if it's not installed? I prefer a
# more universal solution that works on both mac and ubuntu

# Setup fzf
# ---------
if ! type fzf &>/dev/null; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	PATH="$(path_prepend ~/.fzf/bin "${PATH}")"
	export PATH
	~/.fzf/install --xdg --bin --completion --key-bindings --no-update-rc
fi

if [[ -n "${ZSH_NAME}" ]]; then
	source <(fzf --zsh)
else
	eval "$(fzf --bash)"
	# TODO: test if this does not clash with the bash-it fzf plugin
fi

# the following is the old style of fzf setup, I'm keeping it here for reference
# if you are using the homebrew or the original install,
# uncomment this or use the instructions to do this yourself.
# current versions don't source the completion and key-bindings files, they have
# fzf push the right settings via eval according to

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
