function ewhich() {
  command which $*
  \type $*
}

# some more ls aliases
alias ll > /dev/null 2>&1 || alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mc='mv'
#alias mutt='xttitle mutt:$USER mutt:$USER; /usr/bin/mutt'

export HISTTIMEFORMAT="%d/%m/%y %T "
export BASH_SILENCE_DEPRECATION_WARNING=1

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] ; then
  if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
  else
    export LSCOLORS=ExFxBxDxCxegedabagacad
  fi

  alias ls > /dev/null 2>&1 || alias ls='\ls -hGF'
  #alias dir='ls --color=auto --format=vertical'
  #alias vdir='ls --color=auto --format=long'

  #alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features (only for brew,
# the rest are already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

if [ -d ~/.bash_completion.d ]; then
  for file in  ~/.bash_completion.d/*; do
    . $file
  done
fi

alias upt='sudo apt -u dist-upgrade'
alias uupt='sudo apt update && upt'
alias uptc='uupt ; sudo apt-get --purge autoremove  `deborphan` `deborphan  --guess-dev` `deborphan --guess-debug`'
alias scan='nmap -sS -P0 -R -v -F -O -f'
alias beep="echo -e '\a'  ; sleep 1 ; echo -e '\a'  ; sleep 1 ;echo -e '\a' "

function nd() { mkdir "$1" && cd "$1"; }

if [[ "$0" =~ bash ]] ; then
  if [[ "$BASH_IT" ]] ; then
    function theme_change () {
      if [ "$1" == '--complete' ]; then
        for d in $(find "${BASH_IT}/themes" -maxdepth 1 -type d -name "$3*" ! -iname "*themes"); do
          echo ${d##*/};
        done
        exit
      fi
      sed 's/\(.*BASH_IT_THEME=\).*/\1"'$1'"/' ~/.bashrc > ~/.bashrc.NEW && \
        cat ~/.bashrc.NEW > ~/.bashrc && rm ~/.bashrc.NEW
      unset PS1 # PROMPT_COMMAND
      export BASH_IT_THEME=$1
      source ~/.bashrc
    }
    complete -o default -C 'theme_change --complete $@' theme_change

  else
    ## These are now handled in bash-it
    # Setup fzf
    if hash fzf 2> /dev/null && hash fd 2> /dev/null ; then
      # If FD is installed, let FZF use it.
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    # Auto-completion
    # IC_AWS_ENVIRONMENT
    # TODO: fix fzf path to be ubuntu and Mac compat.
    [[ $- == *i* ]] && source $(brew --prefix fzf)/shell/completion.bash 2> /dev/null

    # Key bindings
    # ------------
    source "$(brew --prefix fzf)/shell/key-bindings.bash"
  fi
fi
