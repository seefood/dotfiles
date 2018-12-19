# Setting PATH for Python 3.6
# The original version is saved in .bash_profie.pysave

export VAGRANT_USE_VAGRANT_TRIGGERS=" "

# Ruby RVM
if ! hash rvm 2>/dev/null ; then
  [[ -r /etc/profile.d/rvm.sh ]] && source /etc/profile.d/rvm.sh
  [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
fi

# Python virtualenv
export WORKON_HOME=~/.virtualenvs
if [[ "$OSTYPE" == "darwin"* ]]; then
  function path_append ()  { local res="$(path_remove "$1" "$2")" ; echo "$res:$1" ; }
  function path_remove ()  { echo -n "$2" | awk -v RS=: -v ORS=: '$0 != "'"$1"'"' | sed 's/:$//' ; }
  pypath=/Library/Frameworks/Python.framework/Versions/3.6/bin
  export PATH="$(path_append "${pypath}" "${PATH}")"
  export VIRTUALENVWRAPPER_PYTHON=${pypath}/python3
  source ${pypath}/virtualenvwrapper.sh
else
  export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
  source ~/.local/bin/virtualenvwrapper.sh
fi

[[ -d ${WORKON_HOME}/bluevine ]] && workon bluevine

unset pypath

function _pipenv_completion() {
  local IFS=$'\t'
  COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
    COMP_CWORD=$COMP_CWORD \
    _PIPENV_COMPLETE=complete-bash $1 ) )
  return 0
}

complete -F _pipenv_completion -o default pipenv
hash register-python-argcomplete 2>/dev/null && \
  eval "$(register-python-argcomplete r2d2)"

# Default location of the workspace env, feel free to override:
export PROJECT_HOME=${PROJECT_HOME:-~/bluevine}
export CHEF_REPOSITORY=${PROJECT_HOME}/chef-repo/

### Some wrappers for changing environments

function dev () {
  if [[ "$@" ]] ; then
    ${PROJECT_HOME}/development/env-development.sh $@
    return $?
  else
    source ${PROJECT_HOME}/development/env-development.sh
  fi
}

function stg () {
  if [[ "$@" ]] ; then
    ${PROJECT_HOME}/staging/env-staging.sh $@
    return $?
  else
    source ${PROJECT_HOME}/staging/env-staging.sh
  fi
}

function prd () {
  if [[ "$@" ]] ; then
    ${PROJECT_HOME}/production/env-production.sh $@
    return $?
  else
    source ${PROJECT_HOME}/production/env-production.sh
  fi
}

_envir()
{
  _command
  return 0
} &&
complete -F _envir prd stg dev

#alias sknife="stg knife"
#alias pknife="prd knife"
#alias dknife="dev knife"
