# shellcheck shell=bash

# shellcheck disable=SC1090
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path "$(basename "${SHELL}")")"
