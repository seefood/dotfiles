
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
setopt appendhistory autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ira/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="amuse"
# POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"

# POWERLEVEL9K_IP_INTERFACE='en0'
# POWERLEVEL9K_PUBLIC_IP_HOST='http://ident.me'

# zsh tmux settings
#ZSH_TMUX_AUTOSTART='true'

## Powerlevel9k Settings
POWERLEVEL9K_HISTORY_BACKGROUND='green'

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

POWERLEVEL9K_PROMPT_ON_NEWLINE=true

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{red} \Uf1d0 %f %F{yellow
}❯ "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs)

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

# POWERLEVEL9K_TIME_FORMAT="%D{%T | %m.%d.%y}"
##

# Default username to hide "user@hostname" info
DEFAULT_USER="ira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sudo git history taskwarrior tmux tmuxinator zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/local/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/local/opt/zinit/zinit.zsh

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Example aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

autoload bashcompinit && bashcompinit
function path_append ()  { local res="$(path_remove "$1" "$2")" ; echo "$res:$1" ; }
function path_prepend () { local res="$(path_remove "$1" "$2")" ; echo "$1:$res" ; }
function path_remove ()  { echo -n "$2" | awk -v RS=: -v ORS=: '$0 != "'"$1"'"' | sed 's/:$//' ; }

for newpath in ~/bin ~/.local/bin /opt/nginx/sbin /usr/local/sbin \
    /usr/local/opt/man-db/libexec/bin \
    /usr/local/opt/go/libexec/bin \
    /usr/local/opt/coreutils/libexec/gnubin \
    /usr/local/opt/gnu-sed/libexec/gnubin \
    /usr/local/opt/binutils/bin \
    /usr/local/opt/curl/bin \
    /usr/local/opt/python@3.9/libexec/bin \
    ~/.rvm/gems/ruby-2.4.1/bin \
    ~/.rvm/gems/ruby-2.4.1@kitchen/bin ; do
  [[ -d $newpath ]] && export PATH="$(path_prepend "${newpath}" "${PATH}")"
done

if [ -d ~/.bash_aliases.d ]; then
  for file in ~/.??*.zsh ~/.bash_aliases.d/*.sh; do
    . $file
  done
fi

if [[ $TERM_PROGRAM = "iTerm.app" ]] ; then
  unset ITERM_SHELL_INTEGRATION_INSTALLED
  source ~/.iterm2_shell_integration.zsh
fi

export PATH=$PATH:~/bin

# autoload bashcompinit && bashcompinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bit bit

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
