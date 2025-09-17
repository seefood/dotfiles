# Setup fzf
# ---------
# commenting out, I already have this in my PATH guaranteed elsewhere
#if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
#fi


# also the following is generalized to fit both mac and ubuntu
# feel free to add more paths if needed
# Auto-completion
# ---------------
#source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# Key bindings
# ------------
#source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

for init in /opt/homebrew/opt/fzf/shell/completion.zsh \
 /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
 /usr/share/doc/fzf/examples/completion.zsh \
 /usr/share/doc/fzf/examples/key-bindings.zsh; do
	[[ -f "${init}" ]] && source "${init}"
done

unset init
