# alias fixmtu="sudo ip link change eth0 mtu 1350; sudo ip link change wlan0 mtu 1350"
alias gdsync='for i in ~/google-drive/*; do grive -p $i & done'
alias cformat='indent -kr -i8 --no-tabs --indent-label0'
alias g='grep -n --color'
alias h='history'

function ewhich() {
  command which $*
  \type $*
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mc='mv'
#alias mutt='xttitle mutt:$USER mutt:$USER; /usr/bin/mutt'

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto -F'
  #alias dir='ls --color=auto --format=vertical'
  #alias vdir='ls --color=auto --format=long'

  #alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias upt='sudo apt -u dist-upgrade'
alias uupt='sudo apt update && upt'
alias uptc='uupt ; sudo apt-get --purge autoremove  `deborphan` `deborphan  --guess-dev` `deborphan --guess-debug`'
alias scan='nmap -sS -P0 -R -v -F -O -f'
alias beep="echo -e '\a'  ; sleep 1 ; echo -e '\a'  ; sleep 1 ;echo -e '\a' "

eval "$(thefuck --alias)"
alias FUCK='fuck'

function theme_change () {
  if [ "$1" == '--complete' ]; then
    for d in $(find "${BASH_IT}/themes" -maxdepth 1 -type d -name "$3*" ! -iname "*themes"); do
      echo ${d##*/};
    done
    exit
  fi
  sed -i '' 's/\(.*BASH_IT_THEME=\).*/\1"'$1'"/'  ~/.bash_profile
  source ~/.bash_profile
}
complete -o default -C 'theme_change --complete $@' theme_change

function nd() { mkdir "$1" && cd "$1"; }
