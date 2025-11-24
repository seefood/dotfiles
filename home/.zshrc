#!/bin/zsh
# shellcheck disable=SC2034

setopt nullglob
# Now globs that don't match return empty string like bash

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

#ZSH_THEME="robbyrussell"
#ZSH_THEME="amuse"
#ZSH_THEME="powerlevel10k"
ZSH_THEME="oh-my-posh"

# If you have set oh-my-posh above, this will be used:
#export POSH_THEME=${HOME}/.local/oh-my-posh/powerlevel10k_classic.omp.json
export POSH_THEME=${HOME}/.local/oh-my-posh/blue-owl.omp.json

for file in ~/.shell_commons/*.sh; do
	# shellcheck disable=SC1090
	source "${file}"
done

# If not running interactively, don't do anything
[[ -o interactive ]] || return

# # Refresh Function - https://babushk.in/posts/renew-environment-tmux.html
# if [ -n "$TMUX" ]; then
#   function refresh {
#     export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
#     export $(tmux show-environment | grep "^DISPLAY")
#   }
# else
#   function refresh { }
# fi

# # Then, I define a preexec hook that calls refresh before each new command that gets executed:
# function preexec {
#     refresh
# }

# Default username to hide "user@hostname" info
DEFAULT_USER="$(whoami)"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

if [[ -z "$EMBEDDED_TERM" ]]; then

	# autoload bashcompinit && bashcompinit
	autoload -U +X bashcompinit && bashcompinit
	autoload -Uz +X compinit && compinit
	#complete -o nospace -C /usr/local/bin/bit bit
	complete -o nospace -C /opt/homebrew/bin/mc mc

	if [ -d ~/.bash_aliases.d ]; then
		for file in ~/.bash_aliases.d/*.zsh ~/.bash_aliases.d/*.sh; do
			[[ -f "$file" ]] && source "$file"
		done
	fi

	# Setting for vim, tmux and other tools using poweline
	export POWERLINE_CONFIG_COMMAND=~/.local/bin/powerline-config

	# zinit install (only init if already installed)
	ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
	[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
	[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	source "${ZINIT_HOME}/zinit.zsh"

	# Init a few plugins
	#zinit ice wait lucid
	#zinit load zdharma-continuum/history-search-multi-word

	# plugins loaded without investigating.
	#zinit ice wait lucid
	#zinit light zdharma-continuum/fast-syntax-highlighting

	zinit ice wait lucid
	zinit light sunlei/zsh-ssh

	# Snippet
	zinit ice wait lucid
	zinit snippet https://gist.githubusercontent.com/hightemp/5071909/raw/

	zinit wait lucid for \
		atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
		zdharma-continuum/fast-syntax-highlighting \
		blockf \
		zsh-users/zsh-completions \
		atload"!_zsh_autosuggest_start" \
		zsh-users/zsh-autosuggestions

	# old OMZ plugins
	#omz_plugins=(sudo git history taskwarrior tmux tmuxinator)
	omz_plugins=(sudo git history aws colorize common-aliases cp docker-compose)
	[[ -f /etc/debian_version ]] && omz_plugins+=(debian)
	## Zinit Setting
	# Must Load OMZ Git library
	zinit snippet OMZL::git.zsh

	for plug in ${omz_plugins[*]}; do
		# Load Git and other plugins from OMZ
		zinit ice wait lucid
		zinit snippet OMZP::${plug}
	done

	# Recommended history plugin till I fix ctrl-R in wezterm
	zinit load zsh-users/zsh-history-substring-search
	#zinit ice wait atload'_history_substring_search_config'
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down

	# Load my favorite old aliases from bash_it
	zinit snippet https://gist.github.com/seefood/896a042ea975b778d93159c6a9e3e0a5/raw/aliases.sh
	#zinit snippet https://gist.github.com/seefood/896a042ea975b778d93159c6a9e3e0a5/raw/aliases-git.sh
	zinit snippet https://gist.github.com/seefood/896a042ea975b778d93159c6a9e3e0a5/raw/plugins.sh
	#zinit snippet https://gist.github.com/seefood/896a042ea975b778d93159c6a9e3e0a5/raw/completions.sh
	zinit snippet https://gist.github.com/seefood/896a042ea975b778d93159c6a9e3e0a5/raw/v2gif.sh

	alias gs="git st"

	_command_exists awless && source <(awless completion zsh)

	_command_exists aws && complete -C aws_completer aws

	_command_exists terraform && complete -o nospace -C $(which terraform) terraform

	_command_exists tofu && complete -o nospace -C $(which tofu) tofu

	alias tf=tofu

	# Themes handling - Maybe needs to be in a seperate script (TODO)

	if [[ "$ZSH_THEME" =~ "^powerlevel" ]]; then

		# Powerlevel9k theme is kind of deprecated,
		# but the settings still work with powerlevel10k
		POWERLEVEL9K_HISTORY_BACKGROUND='green'

		POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
		POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

		POWERLEVEL9K_PROMPT_ON_NEWLINE=true

		POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
		POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{red} \Uf1d0 %f %F{yellow}❯ "

		POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir_writable dir vcs)
		POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs)
		# POWERLEVEL9K_TIME_FORMAT="%D{%T | %m.%d.%y}"

		# Load powerlevel10k theme
		zinit ice depth"1" # git clone depth
		zinit light romkatv/powerlevel10k
		unset ZSH_THEME
	elif [[ "$ZSH_THEME" == "oh-my-posh" ]] && type oh-my-posh &>/dev/null; then
		eval $(oh-my-posh init zsh --config $POSH_THEME)
		unset ZSH_THEME
	elif [[ "$ZSH_THEME" ]]; then
		## Based on suggestions at https://github.com/zdharma-continuum/zinit#migration
		## this is for internal omz theme support, don't use this as-is for third party themes
		## like powerlevel9k,powerlevel10k which have their own zinit integration

		# Must Load OMZ Async prompt library
		zinit ice wait lucid
		zinit snippet OMZL::async_prompt.zsh
		zinit cdclear -q # <- forget completions provided up to this moment

		setopt promptsubst

		# Load Prompt
		zinit snippet OMZT::${ZSH_THEME}
		unset ZSH_THEME
	fi
fi

# User configuration

# Preferred editor for local and remote sessions
export EDITOR='vim'
export VISUAL='vim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
