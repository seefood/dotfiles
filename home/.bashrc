# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
for newpath in ${HOME}/workspace/devops/tools ${HOME}/bin ; do
  [[ -d $newpath ]] && export PATH=${PATH}:${newpath}
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
# Set my editor and git editor
export EDITOR="vim"
export GIT_EDITOR="vim"
export VISUAL="vim"
export QMAILMFTFILE=~ira/.qmailLISTS
# . ~/.javaenv

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
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

if [[ -d $HOME/.rbenv/bin ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH:$HOME/bin"
  eval "$(rbenv init -)"
fi

export MY_WORKSPACE=~/workspace
if [ -d ${MY_WORKSPACE} ]; then
  pushd ${MY_WORKSPACE} > /dev/null
  . ./env
  popd > /dev/null
fi
unset MY_WORKSPACE

set -o emacs
export EDITOR=vim
export VISUAL=vim
alias vi='vim'
if [[ -x /usr/bin/nvim ]] ; then
    export EDITOR=nvim
    export VISUAL=nvim
    alias vi='nvim'
fi
export HISTIGNORE="&:[fb]g"
export DEBEMAIL="nospam-debmail@ira.abramov.org"
export DEBFULLNAME="Ira Abramov"
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

for key in ~/.ssh/iabramov ~/.ssh/ira.pem ~/.ssh/id_iraATwork ; do
  [[ -f $key ]] && ssh-add $key &> /dev/null
done

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Source the bash_it!
echo "$PS1" | grep -q chroot && . ~/.bash_profile

# Setup fzf
if [[ -x ~/.fzf/bin/fzf ]] ; then
  # If FD is installed, let FZF use it.
  if [[ -x /usr/bin/fd ]] ; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
  if [[ ! "$PATH" == */.fzf/bin* ]]; then
    export PATH="$PATH:$HOME/.fzf/bin"
  fi

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source ~/.fzf/shell/completion.bash 2> /dev/null

  # Key bindings
  # ------------
  source "$HOME/.fzf/shell/key-bindings.bash"
fi

export GPG_TTY=$(tty)
export LB_FUNC_LOAD=true

if [[ -f /etc/profile.d/vte.sh ]] && [ "$TILIX_ID" -o "$VTE_VERSION" ] ; then
    source /etc/profile.d/vte.sh;
fi # Ubuntu Budgie Added

if [[ "$TERM" != "dumb" ]] && [[ "$SSH_TTY" ]] && echo "$TERM" | grep -q -v "^screen" ; then
  sleep 1s; screen -q -m -RR -x
fi
