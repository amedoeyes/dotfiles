bindkey -v

KEYTIMEOUT=1
function zle-keymap-select {
	if [[ $KEYMAP == vicmd ]]; then
		echo -ne "\e[2 q"
	else
		echo -ne "\e[5 q"
	fi
}
precmd_functions+=(zle-keymap-select)
zle -N zle-keymap-select

bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^Y' yank
bindkey '^_' undo
