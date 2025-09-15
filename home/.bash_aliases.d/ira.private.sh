#shellcheck shell=bash
if [[ $USER =~ ^ira ]]; then

	# alias android-connect="mtpfs -o allow_other /media/GalaxyS2"
	# alias android-disconnect="fusermount -u /media/GalaxyS2"

	# alias tat='vi ~/bin/tatsuya && strfile ~/bin/tatsuya'

	alias uma='ssh ira@uma.scso.com'

	alias socks5="ssh scso.com -qfN -D 9051"
	alias mgif='v2gif *.webm *.mp4 -d'

	if [[ "$OSTYPE" == "darwin"* ]]; then
		alias psig='/Applications/Signal.app/Contents/MacOS/Signal --user-data-dir=${HOME}/.config/Signal-Personal &> /dev/null &'
		alias upt='brew upgrade'
		alias uupt='brew upgrade'
	else
		alias wsig='signal-desktop --user-data-dir=${HOME}/.config/Signal-Work &> /dev/null &'
		alias upt='sudo apt -u dist-upgrade; \
			oh-my-posh upgrade; \
			flatpak update -y; sudo flatpak update -y'
		alias uupt='sudo apt update && upt'
		alias uptc='uupt && sudo apt-get --purge autoremove'
		alias uptcc='uuptc `deborphan` `deborphan  --guess-dev` `deborphan --guess-debug`'

		#alias tat='vi ~/bin/tatsuya && strfile ~/bin/tatsuya'
		alias kgs="busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart(\"Restarting…\")'"

		function df() {
			if [[ "$*" ]]; then
				/bin/df "$@"
			else
				/bin/df -hT -x squashfs -x tmpfs
			fi
		}
	fi

	alias scan='sudo nmap -sS -Pn -R -v -O -f'
	alias beep="echo -e '\a'; sleep 1; echo -e '\a'; sleep 1; echo -e '\a'"
	type -p colorls >/dev/null && alias ls='colorls --sort-dirs --gs'
	export DEBEMAIL="nospam-debmail@ira.abramov.org"
	export DEBFULLNAME="Ira Abramov"
fi
