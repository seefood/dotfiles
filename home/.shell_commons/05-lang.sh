# shellcheck shell=bash
# shellcheck disable=SC2034
# Set a default locale or the system will pick out something unusable.
export LANG=en_US.UTF-8
[[ ${LC_CTYPE} == "UTF-8" ]] && export LC_CTYPE=en_US.UTF-8
unset LC_TIME

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"
