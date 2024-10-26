export PATH=$PATH:$XDG_BIN_HOME
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=librewolf
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

export ANDROID_USER_HOME=$XDG_DATA_HOME/android
export CABAL_CONFIG=$XDG_CONFIG_HOME/cabal/config
export CABAL_DIR=$XDG_DATA_HOME/cabal
export GHCUP_USE_XDG_DIRS=true
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GOPATH=$XDG_DATA_HOME/go
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export HISTFILE=$XDG_CACHE_HOME/zsh/history
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export PYTHONSTARTUP=${XDG_CONFIG_HOME}/python/pythonrc
export TEXMFHOME=$XDG_DATA_HOME/texmf
export W3M_DIR=$XDG_DATA_HOME/w3m
export WINEPREFIX=$XDG_DATA_HOME/wine
export XCURSOR_PATH=$XDG_DATA_HOME/icons
export XMAKE_CONFIGDIR=$XDG_CONFIG_HOME/xmake/local
export XMAKE_GLOBALDIR=$XDG_CONFIG_HOME/xmake/global
export XMAKE_LOGFILE=$XDG_CACHE_HOME/xmake/xmake.log
export XMAKE_PKG_CACHEDIR=$XDG_CACHE_HOME/xmake
export XMAKE_PKG_INSTALLDIR=$XDG_DATA_HOME/xmake
export ZINIT_HOME=$XDG_DATA_HOME/zinit/zinit.git

export ZK_NOTEBOOK_DIR=$HOME/notebook/
export WINEPATH=/usr/x86_64-w64-mingw32/bin

export FZF_DEFAULT_OPTS="--ansi --color='fg:#A0A0A0,fg+:#A0A0A0,bg:#000000,bg+:#101010,hl:#A0A0A0,hl+:#A0A0A0,gutter:#000000,info:#707070,border:#404040,prompt:#A0A0A0,pointer:#A0A0A0,marker:#A0A0A0,spinner:#A0A0A0' --height='-1' --reverse --border sharp --inline-info --prompt='> '"
export FZF_ALT_C_COMMAND="fd -t d --exclude node_modules --exclude old ."
export FZF_ALT_C_OPTS="--height='-1'"
export FZF_CTRL_T_COMMAND="fd --exclude node_modules --exclude old ."
export FZF_CTRL_T_OPTS="--height='-1'"

export ZVM_INIT_MODE=sourcing
export ZVM_VI_HIGHLIGHT_FOREGROUND=#a0a0a0
export ZVM_VI_HIGHLIGHT_BACKGROUND=#202020

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#404040'

export XCURSOR_THEME=eyes
export XCURSOR_SIZE=24
export CLUTTER_BACKEND=wayland
export GDK_BACKEND=wayland
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export SDL_VIDEODRIVER=wayland
