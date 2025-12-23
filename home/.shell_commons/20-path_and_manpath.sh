# shellcheck shell=bash

function path_append() {
	local res
	res="$(path_remove "$1" "$2")"
	echo "${res}:$1"
}
function path_prepend() {
	local res
	res="$(path_remove "$1" "$2")"
	echo "$1:${res}"
}
function path_remove() { echo -n "$2" | awk -v RS=: -v ORS=: '$0 != "'"$1"'"' | sed 's/:$//'; }

export ANDROID_HOME=${HOME}/Android/Sdk

for newpath in ~/bin ~/.local/bin /opt/nginx/sbin /usr/local/sbin \
	/opt/homebrew/bin \
	/opt/homebrew/opt/man-db/libexec/bin \
	/opt/homebrew/opt/go/libexec/bin \
	/opt/homebrew/opt/*/libexec/gnubin \
	/opt/homebrew/opt/binutils/bin \
	/opt/homebrew/opt/curl/bin \
	/opt/homebrew/opt/gnu-getopt/bin \
	/opt/homebrew/opt/node@*/bin \
	/usr/local/opt/python@3.*/libexec/bin \
	/opt/homebrew/opt/python@3.*/bin \
	/opt/homebrew/opt/ruby@2.*/bin \
	/opt/homebrew/anaconda3/bin \
	/opt/homebrew/opt/fzf/bin \
	/var/lib/rancher/rke2/bin \
	/usr/local/opt/man-db/libexec/bin \
	/usr/local/opt/go/libexec/bin \
	/usr/local/opt/*/libexec/gnubin \
	/usr/local/opt/binutils/bin \
	/usr/local/opt/curl/bin \
	/usr/local/android-studio/bin \
	/usr/local/cuda-*/bin \
	${ANDROID_HOME}/emulator/ \
	${ANDROID_HOME}/tools/ \
	~/.rvm/gems/ruby-*/bin \
	~/.gem/ruby/*/bin \
	~/.nvm/versions/node/*/bin/ \
	~/.fig/bin \
	~/AppImages \
	~/Library/Python/3.*/bin \
	~/.codeium/windsurf/bin \
	~/.local/platform-tools \
	~/.fzf/bin \
	~/.npm-global/bin; do
	[[ -d ${newpath} ]] && PATH="$(path_prepend "${newpath}" "${PATH}")"
	export PATH
done

for newpath in \
	/usr/share/man \
	/usr/local/share/man \
	/opt/homebrew/share/man \
	/usr/local/opt/coreutils/libexec/gnuman \
	/opt/homebrew/opt/coreutils/libexec/gnuman \
	/usr/local/opt/gnu-sed/libexec/gnuman \
	/opt/homebrew/opt/gnu-sed/libexec/gnuman \
	~/.local/share/man \
	/home/linuxbrew/.linuxbrew/share/man \
	/home/linuxbrew/.linuxbrew/share/man; do
	[[ -d ${newpath} ]] && MANPATH="$(path_prepend "${newpath}" "${MANPATH}")"
	export MANPATH
done
unset newpath
