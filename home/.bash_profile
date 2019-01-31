#!/usr/bin/env bash

#source ~/.bashrc
[[ "$PYTHONSTARTUP" ]] || source ~/.bashrc

# Load RVM, if you are using it
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Set a default locale or the system will pick out something unusable.
export LANG=en_US.UTF-8

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.github.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname. comment this to fall back on $HOSTNAME.
export SHORT_HOSTNAME=$(hostname -s)

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

#export POWERLINE_LEFT_PROMPT="clock user_info scm python_venv ruby cwd in_vim"
export POWERLINE_LEFT_PROMPT="scm python_venv ruby cwd"
export POWERLINE_PROMPT="$POWERLINE_LEFT_PROMPT"
export POWERLINE_RIGHT_PROMPT="in_vim clock"
# Most people don't like that right side, so I'm turning it off. comment the
# next line if you want to try it:
export POWERLINE_RIGHT_PROMPT=" "
[[ "$SSH_CONNECTION" ]] && export POWERLINE_RIGHT_PROMPT="$POWERLINE_RIGHT_PROMPT hostname"

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME="powerline-multiline"

# Load Bash It
[[ -d $BASH_IT ]] && source $BASH_IT/bash_it.sh
export AWS_PROFILE_PROMPT_COLOR="19"
export PYTHON_VENV_THEME_PROMPT_COLOR="30"
export USER_INFO_THEME_PROMPT_COLOR_SUDO="63"
export RUBY_THEME_PROMPT_COLOR="124"

### set to 'true' (and customize to taste) once you installed
### a powerline/nerd font, so your prompt looks even nicer!
NERDFONTS=false
if [[ "$NERDFONTS" == "true" ]] ; then
  #export POWERLINE_LEFT_SEPARATOR=""
  #export POWERLINE_LEFT_END=""
  #export POWERLINE_RIGHT_SEPARATOR=""
  #export POWERLINE_RIGHT_END=""
  #export POWERLINE_PROMPT_CHAR="⥤"
  #export POWERLINE_PROMPT_CHAR="➤"
  #export POWERLINE_PROMPT_CHAR="↳"
  export POWERLINE_PROMPT_CHAR=" =>"
  [[ "$OSTYPE" == "darwin"* ]] && export POWERLINE_PROMPT_CHAR=" =>"
  export PYTHON_VENV_CHAR=" "
  export RUBY_CHAR=" "
  export AWS_PROFILE_CHAR=" "
else
  export POWERLINE_PROMPT_CHAR="=>"
  unset POWERLINE_LEFT_SEPARATOR POWERLINE_LEFT_END
fi

# Refresh iTerm2 integration after bash-it as necessary.

if [[ $TERM_PROGRAM = "iTerm.app" ]] ; then
  unset ITERM_SHELL_INTEGRATION_INSTALLED
  source ~/.iterm2_shell_integration.bash
fi
