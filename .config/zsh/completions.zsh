autoload -Uz compinit

[ ! -d $XDG_CACHE_HOME/zsh/completions ] && mkdir -p $XDG_CACHE_HOME/zsh/completions
[ ! -f $XDG_CACHE_HOME/zsh/completions/_mason ] && mason completion zsh >$XDG_CACHE_HOME/zsh/completions/_mason
[ ! -f $XDG_CACHE_HOME/zsh/completions/_cht ] && curl -s "cheat.sh/:zsh" >$XDG_CACHE_HOME/zsh/completions/_cht

fpath=($XDG_CACHE_HOME/zsh/completions $fpath)
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height -1
