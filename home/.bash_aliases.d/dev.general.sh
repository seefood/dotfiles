#!/bin/bash
alias json='python -mjson.tool'

export GOPATH=~/go

function ps() {
	if [ $# -eq 0 ]; then
		command ps aux --sort rss
	elif [ $# -eq 2 ] && [ "$1" == '-p' ]; then
		local p=$2

		mapfile -t plist < <(command ps -aef | awk -v x="${p}" ' $8 ~ x { print $2 } ')
		size=${#plist}

		if [ "$size" -ne 0 ]; then
			command ps -u -p "${plist[@]}"
			command ps -u -p "${plist[@]}" | grep -v PID | awk '{ sum+=$3} END {print "CPU %:", sum}'
			command ps -u -p "${plist[@]}" | grep -v PID | awk '{ sum+=$4} END {print "MEM %:", sum}'
		else
			echo "[$p] process not found"
		fi
	else
		command ps "$@"
	fi
	lscpu | grep "CPU MHz"
}

function yaml2json() {
	ruby -ryaml -rjson -e \
		'puts JSON.pretty_generate(YAML.load(ARGF))' "$@"
}

## Style seting for bat and delta
# See more at https://dandavison.github.io/delta/choosing-colors-styles.html

export BAT_THEME=Coldark-Dark
#export BAT_THEME=Dracula
#export BAT_THEME=gruvbox-dark
export DELTA_FEATURES=+line-numbers

function delta-toggle() {
	eval "export DELTA_FEATURES='$(_delta-features-toggle "$1" | tee /dev/stderr)'"
}

# I use cursor right now, but all vscode and derivatives should work with the merge below
export VISUAL=cursor
#export VISUAL=windsurf-next
#export VISUAL=code

function merge() {
	if [ $# -ne 2 ]; then
		echo "Usage: merge <local/base> <remote>"
		return 1
	fi

	local editor="${VISUAL:-code}" # Default to code if not set
	local local_file="$1"
	local remote_file="$2"
	local temp_dir
	temp_dir=$(mktemp -d)

	cp "$local_file" "$temp_dir/local"
	cp "$local_file" "$temp_dir/base"
	cp "$remote_file" "$temp_dir/remote"

	# Check if editor supports --merge (VS Code family: code, cursor, windsurf-next)
	if "$editor" --help 2>/dev/null | grep -q -- --merge; then
		"$editor" --merge "$temp_dir/local" "$temp_dir/remote" "$temp_dir/base" "$temp_dir/result" --wait
	else
		echo "Editor does not support --merge; opening diff view instead."
		"$editor" --diff "$temp_dir/local" "$temp_dir/remote" --wait
		cp "$temp_dir/local" "$temp_dir/result"
	fi

	read -rp "Was the merge successful? (y/n): " response
	case $response in
	[Yy]*)
		cp "$temp_dir/result" "$local_file"
		echo "Merged result copied to $local_file"
		;;
	*)
		echo "Merge not applied; $local_file remains unchanged"
		;;
	esac

	rm -rf "$temp_dir"
}
