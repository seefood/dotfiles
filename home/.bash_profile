#!/usr/bin/env bash

# shellcheck disable=SC1090
[[ -f ~/.bashrc ]] && source ~/.bashrc

complete -C /opt/homebrew/bin/mc mc
