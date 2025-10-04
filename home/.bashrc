#!/bin/bash
# shellcheck disable=SC2312,SC2015
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

for file in ~/.shell_commons/*.sh; do
	# shellcheck disable=SC1090
	source "${file}"
done

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Set a default locale or the system will pick out something unusable.
export LANG=en_US.UTF-8
[[ ${LC_CTYPE} == "UTF-8" ]] && export LC_CTYPE=en_US.UTF-8
unset LC_TIME

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	# shellcheck disable=SC1091
	. /etc/bashrc
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth
HISTCONTROL=erasedupes

# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=10000
# HISTFILESIZE=20000
# HISTFILE=~/.bash_history.$(tty|tr -d "/")

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if [[ -x /usr/bin/lesspipe ]]; then eval "$(SHELL=/bin/sh lesspipe)" || true; fi

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot-}" ]] && [[ -r /etc/debian_chroot ]]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

umask 022
UBUNTU_MENUPROXY=0
export UBUNTU_MENUPROXY

if [[ -d ${HOME}/.rbenv/bin ]]; then
	PATH="$(path_prepend "${HOME}/.rbenv/bin" "${PATH}")"
	export PATH
	# shellcheck disable=SC2312
	eval "$(rbenv init -)"
fi

set -o emacs
# Set my editor and git editor
export EDITOR="vim"
alias vi='vim'
if hash nvim 2>/dev/null; then
	export EDITOR=nvim
	alias vi='nvim'
fi
export GIT_EDITOR=${EDITOR}
export VISUAL=vi

#export HISTIGNORE="&:[fb]g"
export PYTHONSTARTUP="${HOME}/.pythonrc"

export QUILT_PATCHES=debian/patches
export QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"

# Override against firewalls
#export GIT_HOSTING='ssh://git@ssh.github.com:443/'
export GIT_HOSTING='git@github.com:'

export BASH_IT_DOCKER_MACHINE="default"

#ulimit -S -v 2000000
#ulimit -S -m 250000
ulimit -n 8192
ulimit -v unlimited

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
#export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Choose log level for bash_it
export BASH_IT_LOG_LEVEL=1

GPG_TTY=$(tty)

# Load RVM, if you are using it
# shellcheck disable=SC1091
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"

# Your place for hosting Git repos. I use this for private repos.
GIT_HOSTING='git@git.github.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to the command you use for todo.txt-cli
TODO="t"

# Set Xterm/screen/Tmux title with only a short hostname. comment this to fall back on $HOSTNAME.
SHORT_HOSTNAME=$(hostname -s)

export GIT_HOSTING GPG_TTY BASH_IT_LOG_LEVEL SHORT_HOSTNAME TODO

# Lock and Load a custom theme file
# location ~/.bash_it/themes/

# Simple prompt for embedded terminals and editors
if [[ -n "${CASCADE}" || -n "${VSCODE_SHELL_INTEGRATION}" || -n "${CURSOR_AGENT}" ||
	"${TERM_PROGRAM}" = "vscode" || "${TERM_PROGRAM}" = "cursor" ||
	-n "${VSCODE_PID}" || -n "${VSCODE_CWD}" ||
	"${TERM}" = "dumb" || -n "${EMACS}" || -n "${INSIDE_EMACS}" ]]; then
	export PS1='\u@\h:\w\$ '
	unset BASH_IT_THEME
	return
else
	# Regular prompt configuration
	BASH_IT_THEME=${BASH_IT_THEME:-oh-my-posh}
	# If OMP binary is not installed, fallback to a sensible default
	if [[ "${BASH_IT_THEME}" == "oh-my-posh" ]]; then
		type -P oh-my-posh >/dev/null ||
			BASH_IT_THEME="powerline-multiline"
	fi
	export BASH_IT_THEME
fi

if [[ "${BASH_IT_THEME}" == "oh-my-posh" ]]; then
	# Oh-my-posh redirects to a json elsewhere, customized our use.

	#export POSH_THEME=${HOME}/.local/oh-my-posh/powerlevel10k_classic.omp.json
	export POSH_THEME=${HOME}/.local/oh-my-posh/blue-owl.omp.json
	# Setting for vim, tmux and other tools using poweline
	export POWERLINE_CONFIG_COMMAND=~/.local/bin/powerline-config
else
	# Settings only relevant to bash-it's internal themed prompts
	# Set this to false to turn off version control status checking within the prompt for all themes
	export SCM_CHECK=true

	# Set vcprompt executable path for scm advance info in prompt (demula theme)
	# https://github.com/xvzf/vcprompt
	#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

	#export POWERLINE_LEFT_PROMPT="clock user_info scm python_venv ruby cwd in_vim"
	export POWERLINE_LEFT_PROMPT="aws_profile scm python_venv ruby cwd"
	export POWERLINE_LEFT_PROMPT="aws_profile scm cwd"
	export POWERLINE_PROMPT="${POWERLINE_LEFT_PROMPT}"
	export POWERLINE_RIGHT_PROMPT="in_vim clock"
	# Most people don't like that right side, so I'm turning it off. comment the
	# next line if you want to try it:
	#export POWERLINE_RIGHT_PROMPT=" "
	[[ -n "${SSH_CONNECTION}" ]] && export POWERLINE_RIGHT_PROMPT="${POWERLINE_RIGHT_PROMPT} hostname"
	export AWS_PROFILE_PROMPT_COLOR="19"
	export PYTHON_VENV_THEME_PROMPT_COLOR="30"
	export USER_INFO_THEME_PROMPT_COLOR_SUDO="63"
	export RUBY_THEME_PROMPT_COLOR="124"

	### set to 'true' (and customize to taste) once you installed
	### a powerline/nerd font, so your prompt looks even nicer!
	NERDFONTS=true
	if [[ ${NERDFONTS} == "true" ]]; then
		#export POWERLINE_LEFT_SEPARATOR=""
		#export POWERLINE_LEFT_END=""
		#export POWERLINE_RIGHT_SEPARATOR=""
		#export POWERLINE_RIGHT_END=""
		#export POWERLINE_PROMPT_CHAR="⥤"
		#export POWERLINE_PROMPT_CHAR="➤"
		#export POWERLINE_PROMPT_CHAR="↳"
		export POWERLINE_PROMPT_CHAR=" =>"
		[[ ${OSTYPE} == "darwin"* ]] && export POWERLINE_PROMPT_CHAR=" =>"
		export PYTHON_VENV_CHAR=" "
		export RUBY_CHAR=" "
		export AWS_PROFILE_CHAR="󰸏 "
	else
		export POWERLINE_PROMPT_CHAR="=>"
		unset POWERLINE_LEFT_SEPARATOR POWERLINE_LEFT_END
	fi
fi

# enable programmable completion features (only for brew,
# the rest are already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ -n "${HOMEBREW_PREFIX}" ]] && ! shopt -oq posix; then
	if [[ -f "$(brew --prefix)/etc/bash_completion" ]]; then
		# shellcheck disable=SC1091
		. "$(brew --prefix)/etc/bash_completion"
	fi
fi

# Load completions, functions and aliases
for dir in ~/.bash_aliases.d ~/.bash_completion.d; do
	if [[ -d "${dir}" ]]; then
		for file in "${dir}"/*; do
			# shellcheck disable=SC1090
			. "${file}"
		done
	fi
done

# Load aliases and functions
if [[ -f ~/.bash_aliases ]]; then
	# shellcheck disable=SC1090
	. ~/.bash_aliases
fi

# Enable homeshick
# shellcheck disable=SC1091
[[ -r "${HOME}/.homesick/repos/homeshick/homeshick.sh" ]] &&
	source "${HOME}/.homesick/repos/homeshick/homeshick.sh"

# Path to the bash it configuration
export BASH_IT="${HOME}/.bash_it"
# Load Bash It
# shellcheck disable=SC1091
[[ -d "${BASH_IT}" ]] && source "${BASH_IT}/bash_it.sh"

for key in ~/.ssh/*.pem; do
	[[ -f "${key}" ]] && ssh-add "${key}" &>/dev/null
done

# shellcheck disable=SC1091
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" || true
