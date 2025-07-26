{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.zsh;
in
{
  config.programs.zsh = lib.mkIf cfg.enable {
    dotDir = ".config/zsh";
    defaultKeymap = "viins";

    autosuggestion = {
      enable = true;
      highlight = "fg=${config.theme.colors.hex04}";
    };

    history = {
      path = "${config.xdg.stateHome}/zsh/history";
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
            export DICPATH="${pkgs.hunspellDicts.en_US}/share/hunspell"
          	echo $1 | ${lib.getExe pkgs.hunspell} -a | ${lib.getExe pkgs.gnugrep} "^&" | ${lib.getExe pkgs.gawk} -F": " '{print $2}'
          }

          function preexec {
          	echo -en "\033]0;$1 @ ''${PWD/#$HOME/~}\007"
          }

          function precmd {
          	echo -en "\033]0;''${PWD/#$HOME/~}\007"
          }

          function osc7-pwd {
          	emulate -L zsh
          	setopt extendedglob
          	local LC_ALL=C
          	echo -en "\e]7;file://$HOST''${PWD//(#m)([^@-Za-z&-;_~])/%''${(l:2::0:)$(([##16]#MATCH))}}\e"
          }

          function chpwd-osc7-pwd {
          	((ZSH_SUBSHELL)) || osc7-pwd
          }
          add-zsh-hook -Uz chpwd chpwd-osc7-pwd
        '';
      in
      lib.mkMerge [
        zstyle
        keybinds
        functions
      ];
  };
}
