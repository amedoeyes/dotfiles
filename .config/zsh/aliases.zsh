alias cat="bat"
alias cfg="git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME"
alias ls="exa --icons --color=never"
alias nv="nvim"
alias pm="paru"
alias wget="wget --hsts-file=\$XDG_DATA_HOME/wget-hsts"
alias py="python -q"
alias zathura="zathura --fork"
alias adb="HOME="$XDG_DATA_HOME"/android adb"
alias fd="fd --color=never"

if [[ -n "$NVIM" ]]; then
	alias nvim="nvim --server $NVIM --remote"
fi
