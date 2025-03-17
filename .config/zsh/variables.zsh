export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="qutebrowser"
export MANPAGER="nvim +Man!"
export READER="zathura"
export TERMINAL="footclient"
export PS1="$ "
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

export XCURSOR_PATH="$XDG_DATA_HOME/icons"
export XCURSOR_SIZE=24
export XCURSOR_THEME=eyes

export PATH="$XDG_BIN_HOME:$XDG_DATA_HOME/mason/bin:$PATH"
export MANPATH=$XDG_CACHE_HOME/cppman:$MANPATH

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

export HIGHLIGHT_DATADIR="$XDG_CONFIG_HOME/highlight/"
export W3M_DIR="$XDG_CONFIG_HOME/w3m"
export XMAKE_GLOBALDIR="$XDG_CONFIG_HOME/xmake"

export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"

export FZF_DEFAULT_OPTS="
	--color 'fg:#A0A0A0,fg+:#A0A0A0:regular,bg:#000000,bg+:#101010,hl:#A0A0A0,hl+:#A0A0A0,gutter:#000000,query:#A0A0A0:regular,disabled:#404040,info:#404040,border:#404040,label:#A0A0A0,prompt:#606060,pointer:#A0A0A0,marker:#A0A0A0,spinner:#404040,header:#A0A0A0' 
	--height '-1' 
	--reverse 
	--list-border sharp 
	--preview-border sharp 
	--info=inline-right:'' 
	--prompt ' ' 
	--highlight-line 
	--bind ctrl-y:accept"
export FZF_ALT_C_OPTS="
	--walker dir,follow,hidden
  --walker-skip .cache,.dotfiles,.git,.local/share/Smart\ Code\ ltd,Trash,.local/share/containers,.local/share/nvim/site/pack,.local/share/pipx,.local/share/qutebrowser,.local/share/xmake,.nuget,.ruff_cache,.stremio-server,.xmake,__pycache__,bin,build,mason/packages,media/screenrecords,media/screenshots,music,node_modules,obj,old,target,venv
  --preview 'tree --noreport {}'"

export HIGHLIGHT_OPTIONS="--style=eyes --out-format=xterm256 --line-numbers"

export SUDO_PROMPT="Password: "

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#404040"
