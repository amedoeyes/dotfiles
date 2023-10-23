sleep 0.1

HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS

autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

bindkey -v
bindkey "^?" backward-delete-char

zle_highlighting=('paste:none')

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q'; }

source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

PROMPT="$ "

alias update="sudo pacman -Syyu --noconfirm && yay -Su -a --noconfirm"
alias pacman="sudo pacman"
alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"
alias cat="bat"
alias ls="exa --icons --color=never"
alias nv="nvim"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
