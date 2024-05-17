export PATH=$PATH:$XDG_BIN_HOME
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=librewolf
export TERMINAL=alacritty
export MANPAGER="nvim +Man!"
export READER=zathura

export PS1="$ "
export SUDO_PROMPT="Password: "
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin

export ANDROID_HOME=$XDG_DATA_HOME/android
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export HISTFILE=$XDG_CACHE_HOME/zsh/history
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export NODE_REPL_HISTORY=$XDG_CACHE_HOME/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PYTHONSTARTUP=${XDG_CONFIG_HOME}/python/pythonrc
export WINEPREFIX=$XDG_DATA_HOME/wine
export XCURSOR_PATH=$XDG_DATA_HOME/icons
export ZINIT_HOME=$XDG_DATA_HOME/zinit/zinit.git

export FZF_DEFAULT_OPTS="--ansi --color=bw"
export FZF_ALT_C_COMMAND="fd -t d --exclude node_modules --exclude old ."
export FZF_ALT_C_OPTS="--height 100%"
export FZF_CTRL_T_COMMAND="fd --exclude node_modules --exclude old ."
export FZF_CTRL_T_OPTS="--height 100%"

export ZVM_INIT_MODE=sourcing
export ZVM_VI_HIGHLIGHT_FOREGROUND=#a0a0a0
export ZVM_VI_HIGHLIGHT_BACKGROUND=#202020

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#404040'
