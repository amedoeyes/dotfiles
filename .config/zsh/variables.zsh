export PATH=$PATH:$XDG_BIN_HOME:$COMPOSER_HOME
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=librewolf
export TERMINAL=alacritty
export PAGER=less

export PS1="$ "
export SUDO_PROMPT="Password: "
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin

export COMPOSER_HOME=$XDG_CONFIG_HOME/composer/vendor/bin
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export ANDROID_HOME=$XDG_DATA_HOME/android
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export WINEPREFIX=$XDG_DATA_HOME/wine

export HISTFILE=$XDG_CACHE_HOME/zsh/history
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export MYSQL_HISTFILE=$XDG_CACHE_HOME/mysql_history
export NODE_REPL_HISTORY=$XDG_CACHE_HOME/node_repl_history

export ZVM_VI_HIGHLIGHT_FOREGROUND=#a0a0a0
export ZVM_VI_HIGHLIGHT_BACKGROUND=#202020

export FZF_DEFAULT_COMMAND="fd -t d --exclude node_modules --exclude old ."
export FZF_DEFAULT_OPTS="--ansi --color=bw"
export FZF_ALT_C_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_OPTS="--height 100%"
