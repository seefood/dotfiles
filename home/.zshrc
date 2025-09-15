#!/bin/zsh
# shellcheck disable=SC2034

#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
# shellcheck disable=SC1090
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

function path_append() {
	local res="$(path_remove "$1" "$2")"
	echo "$res:$1"
}
function path_prepend() {
	local res="$(path_remove "$1" "$2")"
	echo "$1:$res"
}
function path_remove() { echo -n "$2" | awk -v RS=: -v ORS=: '$0 != "'"$1"'"' | sed 's/:$//'; }

for newpath in ~/bin ~/.local/bin /opt/nginx/sbin /usr/local/sbin \
	/var/lib/rancher/rke2/bin \
	/usr/local/opt/man-db/libexec/bin \
	/opt/homebrew/opt/man-db/libexec/bin \
	/usr/local/opt/go/libexec/bin \
	/opt/homebrew/opt/go/libexec/bin \
	/usr/local/opt/binutils/bin \
	/opt/homebrew/opt/binutils/bin \
	/usr/local/opt/curl/bin \
	/opt/homebrew/opt/curl/bin \
	/opt/homebrew/opt/gnu-getopt/bin \
	/opt/homebrew/opt/python@3.*/bin \
	/opt/homebrew/anaconda3/bin \
	~/.fig/bin \
	~/AppImages \
	/opt/homebrew/opt/fzf/bin \
	~/Library/Python/3.*/bin \
	/opt/homebrew/bin \
	/opt/homebrew/opt/node@22/bin \
	/Users/ira/.codeium/windsurf/bin \
	~/.local/platform-tools \
	~/.npm-global/bin; do
	if [[ -d ${newpath} ]]; then
		PATH="$(path_prepend "${newpath}" "${PATH}")"
	fi
	export PATH
done

# Set a default locale or the system will pick out something unusable.
export LANG=en_US.UTF-8
[[ ${LC_CTYPE} == "UTF-8" ]] && export LC_CTYPE=en_US.UTF-8
unset LC_TIME

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

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

unset EMBEDDED_TERM
# Simple prompt for embedded terminals and editors
if [[ -n "$CASCADE" || -n "$VSCODE_SHELL_INTEGRATION" || -n "$CURSOR_AGENT" ||
	"$TERM_PROGRAM" = "vscode" || "$TERM_PROGRAM" = "cursor" ||
	-n "$VSCODE_PID" || -n "$VSCODE_CWD" || "$TERM_PROGRAM" = "Apple_Terminal" ||
	"$TERM" = "dumb" || -n "$EMACS" || -n "$INSIDE_EMACS" ]]; then

	# Use a simple prompt in a simple terminal
	PS1='\u@\h:\w\$ '
	unset ZSH_THEME
	EMBEDDED_TERM=1
fi

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
DEFAULT_USER="ira"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

if [[ -z "$EMBEDDED_TERM" ]]; then

	# autoload bashcompinit && bashcompinit
	autoload -U +X bashcompinit && bashcompinit
	autoload -Uz +X compinit && compinit
	#complete -o nospace -C /usr/local/bin/bit bit
	complete -o nospace -C /opt/homebrew/bin/mc mc

	if [ -d ~/.bash_aliases.d ]; then
		for file in ~/.??*.zsh ~/.bash_aliases.d/*.sh; do
			. "$file"
		done
	fi

	if [[ $TERM_PROGRAM = "iTerm.app" ]]; then
		unset ITERM_SHELL_INTEGRATION_INSTALLED
		[[ -f ~/.iterm2_shell_integration.zsh ]] &&
			source ~/.iterm2_shell_integration.zsh
	fi

	for newpath in \
		/usr/share/man \
		/usr/local/share/man \
		/opt/homebrew/share/man \
		/usr/local/opt/coreutils/libexec/gnuman \
		/opt/homebrew/opt/coreutils/libexec/gnuman \
		/usr/local/opt/gnu-sed/libexec/gnuman \
		/opt/homebrew/opt/gnu-sed/libexec/gnuman \
		/home/linuxbrew/.linuxbrew/share/man \
		/home/linuxbrew/.linuxbrew/share/man; do
		[[ -d ${newpath} ]] && MANPATH="$(path_prepend "${newpath}" "${MANPATH}")"
		export MANPATH
	done
	unset newpath

	# Setting for vim, tmux and other tools using poweline
	export POWERLINE_CONFIG_COMMAND=~/.local/bin/powerline-config

	# zinit install (only init if already installed)
	ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
	[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
	[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	source "${ZINIT_HOME}/zinit.zsh"

	# Init a few plugins
	zinit ice wait lucid
	zinit load zdharma-continuum/history-search-multi-word

	# plugins loaded without investigating.
	zinit ice wait lucid
	zinit light zdharma-continuum/fast-syntax-highlighting

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
	plugins=(sudo git history taskwarrior tmux tmuxinator)
	## Zinit Setting
	# Must Load OMZ Git library
	zinit snippet OMZL::git.zsh

	for plug in ${plugins[*]}; do
		# Load Git and other plugins from OMZ
		zinit ice wait lucid
		zinit snippet OMZP::${plug}
	done

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
		eval $(oh-my-posh init zsh)
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
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
	export VISUAL='vim'
else
	export EDITOR='vim'
	export VISUAL='cursor'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
