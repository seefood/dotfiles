# shellcheck shell=bash
# shellcheck disable=SC1090,SC2034
unset EMBEDDED_TERM
# Simple prompt for embedded terminals and editors
if [[ -n "$CASCADE" || -n "$VSCODE_SHELL_INTEGRATION" || -n "$CURSOR_AGENT" ||
	"$TERM_PROGRAM" = "vscode" || "$TERM_PROGRAM" = "cursor" ||
	-n "$VSCODE_PID" || -n "$VSCODE_CWD" || "$TERM_PROGRAM" = "Apple_Terminal" ||
	"$TERM" = "dumb" || -n "$EMACS" || -n "$INSIDE_EMACS" ||
	"$TERMINAL_EMULATOR" =~ "JetBrains" ]]; then

	# Use a simple prompt in a simple terminal
	PS1='\u@\h:\w\$ '
	unset ZSH_THEME
	EMBEDDED_TERM=1
	# TODO needs to be separated to bash and zsh specific loops.
	if [ -d ~/.bash_aliases.d ]; then
		for file in ~/.bash_aliases.d/*.zsh ~/.bash_aliases.d/*.sh; do
			[[ -r "$file" ]] && source "$file"
		done
	fi
elif [[ $TERM_PROGRAM = "iTerm.app" ]]; then
	unset ITERM_SHELL_INTEGRATION_INSTALLED
	[[ -f ~/.iterm2_shell_integration.${SHELL} ]] &&
		source ~/".iterm2_shell_integration.${SHELL}"
fi
