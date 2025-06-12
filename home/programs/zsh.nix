{
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion = {
      enable = true;
      highlight = "fg=#404040";
    };
    history = {
      path = "$XDG_STATE_HOME/zsh/history";
      size = 100000;
      append = true;
      extended = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
      saveNoDups = true;
    };
    sessionVariables = {
      PROMPT = "%(!.#.$) ";
    };
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
    defaultKeymap = "viins";
    initContent =
      let
        zstyle = lib.mkOrder 1000 ''
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle ':completion:*' menu no
          zstyle ':completion::complete:*' gain-privileges 1
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path $ZDOTDIR/zcompcache

          zstyle ':fzf-tab:*' use-fzf-default-opts yes
          zstyle ':fzf-tab:*' fzf-flags --height -1
        '';

        keybinds = lib.mkOrder 1000 ''
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

          autoload -U edit-command-line
          zle -N edit-command-line
          bindkey "^X^E" edit-command-line

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
        '';

        functions = lib.mkOrder 1000 ''
          function spell {
          	echo $1 | hunspell -a | grep "^&" | awk -F": " '{print $2}'
          }

          function vifm {
          	local dst="$(command vifm --choose-dir - "$@")"
          	[ -z $dst ] && return 1
          	cd $dst
          }

          function preexec {
          	printf "\033]0;%s\007" "$HOST@$USER $PWD $ $1"
          }

          function precmd {
          	printf "\033]0;%s\007" "$HOST@$USER $PWD $"
          }
        '';
      in
      lib.mkMerge [
        zstyle
        keybinds
        functions
      ];
  };
}
