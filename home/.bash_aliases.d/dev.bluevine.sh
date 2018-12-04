# Setting PATH for Python 3.6
# The original version is saved in .bash_profie.pysave

pypath=/Library/Frameworks/Python.framework/Versions/3.6/bin

export PATH="$(path_prepend "${pypath}" "${PATH}")"
export VAGRANT_USE_VAGRANT_TRIGGERS=" "
alias con="ruby ~/bluevine/system/misc/scripts/aws/aws_helper.rb"

# Python virtualenv
export VIRTUALENVWRAPPER_PYTHON=${pypath}/python3
export WORKON_HOME=~/.virtualenvs

source ${pypath}/virtualenvwrapper.sh
[[ -d ${WORKON_HOME}/bluevine ]] || mkvirtualenv bluevine
workon bluevine

unset pypath

function _pipenv_completion() {
  local IFS=$'\t'
  COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
    COMP_CWORD=$COMP_CWORD \
    _PIPENV_COMPLETE=complete-bash $1 ) )
  return 0
}

complete -F _pipenv_completion -o default pipenv
eval "$(register-python-argcomplete r2d2)"

# Default location of the workspace env, feel free to override:
export WS=${WS:-~/bluevine}
export CHEF_REPOSITORY=${WS}/chef-repo/

### Some wrappers for changing environments

function dev () {
  if [[ "$@" ]] ; then
    ${WS}/development/env-development.sh $@
    return $?
  else
    source ${WS}/development/env-development.sh
  fi
}

function stg () {
  if [[ "$@" ]] ; then
    ${WS}/staging/env-staging.sh $@
    return $?
  else
    source ${WS}/staging/env-staging.sh
  fi
}

function prd () {
  if [[ "$@" ]] ; then
    ${WS}/production/env-production.sh $@
    return $?
  else
    source ${WS}/production/env-production.sh
  fi
}

