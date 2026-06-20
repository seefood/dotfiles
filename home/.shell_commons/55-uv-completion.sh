# shellcheck shell=bash
# shellcheck disable=SC1090

if hash uv 2>/dev/null && type fd &>/dev/null; then
	if [[ -n "${ZSH_NAME}" ]]; then
		eval "$(uv generate-shell-completion zsh)"
	else
		eval "$(uv generate-shell-completion bash)"
	fi
fi
