# shellcheck shell=bash
# shellcheck disable=SC1090

# Find .venv/bin by walking up from $PWD
_uv_find_venv_bin() {
	local dir="${PWD}"
	while [[ "${dir}" != "/" ]]; do
		if [[ -d "${dir}/.venv/bin" ]]; then
			echo "${dir}/.venv/bin"
			return 0
		fi
		dir="$(dirname "${dir}")"
	done
	return 1
}

# List dependency names from the nearest pyproject.toml's [project] dependencies
_uv_pyproject_deps() {
	local dir="${PWD}" pyproject=""
	while [[ "${dir}" != "/" ]]; do
		if [[ -f "${dir}/pyproject.toml" ]]; then
			pyproject="${dir}/pyproject.toml"
			break
		fi
		dir="$(dirname "${dir}")"
	done
	[[ -z "${pyproject}" ]] && return 1

	sed -n '/^dependencies *= *\[/,/^\]/p' "${pyproject}" | grep -oE '"[A-Za-z0-9_.-]+' | tr -d '"'
}

_uv_enhanced() {
	local cur prev
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD - 1]}"
	COMPREPLY=()

	case "${prev}" in
	run)
		local venv_bin
		venv_bin="$(_uv_find_venv_bin)"
		if [[ -n "${venv_bin}" ]]; then
			# shellcheck disable=SC2207
			COMPREPLY=($(compgen -W "$(command ls "${venv_bin}")" -- "${cur}"))
			return 0
		fi
		;;
	add | remove)
		# shellcheck disable=SC2207
		COMPREPLY=($(compgen -W "$(_uv_pyproject_deps)" -- "${cur}"))
		return 0
		;;
	esac

	declare -f _uv >/dev/null && _uv "$@"
}

if hash uv 2>/dev/null; then
	if [[ -n "${ZSH_NAME}" ]]; then
		# uv's bash completion uses array-slice syntax zsh's bashcompinit
		# can't parse, so zsh gets uv's native (non-enhanced) completion.
		eval "$(uv generate-shell-completion zsh)"
	else
		eval "$(uv generate-shell-completion bash)"
		complete -F _uv_enhanced -o default -o bashdefault uv
	fi
fi
