# shellcheck shell=bash

# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    # shellcheck disable=SC2015
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q || clear
fi
