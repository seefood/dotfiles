# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

function path_append ()  { local res="$(path_remove "$1" "$2")" ; echo "$res:$1" ; }
function path_prepend () { local res="$(path_remove "$1" "$2")" ; echo "$1:$res" ; }
function path_remove ()  { echo -n "$2" | awk -v RS=: -v ORS=: '$0 != "'"$1"'"' | sed 's/:$//' ; }

for newpath in ${HOME}/.iterm2 ~/bin /opt/nginx/sbin \
      /usr/local/opt/coreutils/libexec/gnubin ; do
  [[ -d $newpath ]] && export PATH="$(path_append "${newpath}" "${PATH}")"
done

for newpath in /usr/local/opt/coreutils/libexec/gnuman ; do
  [[ -d $newpath ]] && export MANPATH="$(path_append "${newpath}" "${MANPATH}")"
done

unset newpath

[[ "$PS1" ]] || return

[[ "$LC_CTYPE" == "UTF-8" ]] && export LC_CTYPE=en_US.UTF-8
unset LC_TIME

# Source global definitions
if [[ -f /etc/bashrc ]]; then
  . /etc/bashrc
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
HISTFILE=~/.bash_history.$(tty|tr -d "/")

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
if [ -d ~/.bash_aliases.d ]; then
  for file in  ~/.bash_aliases.d/*.sh; do
    . $file
  done
fi

#export LANG=he_IL.UTF-8
export LANG=en_US.UTF-8

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

if [ -d ~/.bash_completion.d ]; then
  for file in  ~/.bash_completion.d/*; do
    . $file
  done
fi
complete -C /usr/bin/command_completion_for_rake -o default rake

umask 022
UBUNTU_MENUPROXY=0

if [[ -d ${HOME}/.rbenv/bin ]] ; then
  export PATH="$(path_prepend "${HOME}/.rbenv/bin" "${PATH}")"
  eval "$(rbenv init -)"
fi

set -o emacs
# Set my editor and git editor
export EDITOR="vim"
alias vi='vim'
if hash nvim ; then
  export EDITOR=nvim
  alias vi='nvim'
fi
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR

export HISTIGNORE="&:[fb]g"
export PYTHONSTARTUP="$HOME/.pythonrc"

export QUILT_PATCHES=debian/patches
export QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"

# Override against firewalls
#export GIT_HOSTING='ssh://git@ssh.github.com:443/'
export GIT_HOSTING='git@github.com:'

export BASH_IT_DOCKER_MACHINE="default"

#ulimit -S -v 2000000
#ulimit -S -m 250000
ulimit -v unlimited

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
#export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Setup fzf
if [[ -x ~/.fzf/bin/fzf ]] ; then
  # If FD is installed, let FZF use it.
  if [[ -x /usr/bin/fd ]] ; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  export PATH="$(path_append "${HOME}/.fzf/bin" "${PATH}")"

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source ~/.fzf/shell/completion.bash 2> /dev/null

  # Key bindings
  # ------------
  source "$HOME/.fzf/shell/key-bindings.bash"
fi

export GPG_TTY=$(tty)

# Source the bash_it!
[[ "$BASH_IT_THEME" ]] || source ~/.bash_profile

# If an SSH connection and screen is available, attach to it.
if [[ "$TERM" != "dumb" ]] && [[ "$SSH_TTY" ]] && echo "$TERM" | grep -q -v "^screen" ; then
  sleep 1s; screen -q -m -RR -x
fi
