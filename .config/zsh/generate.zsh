if [[ ! -d $XDG_CACHE_HOME/zsh/gen ]]; then
	mkdir -p $XDG_CACHE_HOME/zsh/gen
fi

if [[ ! -f $XDG_CACHE_HOME/zsh/gen/fzf.zsh ]]; then
	fzf --zsh >$XDG_CACHE_HOME/zsh/gen/fzf.zsh
fi

if [[ ! -f $XDG_CACHE_HOME/zsh/gen/mason.zsh ]]; then
	register-python-argcomplete mason >$XDG_CACHE_HOME/zsh/gen/mason.zsh
fi

source $XDG_CACHE_HOME/zsh/gen/fzf.zsh
source $XDG_CACHE_HOME/zsh/gen/mason.zsh
