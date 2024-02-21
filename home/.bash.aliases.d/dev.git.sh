#!/bin/bash

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1):/'
}

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

alias gitff='git log --all -- '
#git log --all -- '**/my_file.png'

alias logit='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --color --date=short'
alias gst='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gk='gitk --all&'
alias gx='gitx --all'
alias got='git '
alias get='git '
alias gut='git '
alias gco='git checkout '
