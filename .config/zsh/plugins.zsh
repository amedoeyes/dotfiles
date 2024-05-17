if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" --depth=1
fi

source "$ZINIT_HOME/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit load "zsh-users/zsh-autosuggestions"
zinit ice depth=1; zinit load "zsh-users/zsh-completions"
zinit ice depth=1; zinit load "jeffreytse/zsh-vi-mode"
zinit ice depth=1; zinit light "junegunn/fzf"; eval "$(fzf --zsh)"
zinit ice depth=1; zinit light "Aloxaf/fzf-tab"
