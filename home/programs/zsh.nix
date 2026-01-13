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
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";

    syntaxHighlighting = {
      enable = true;
      styles = {
        unknown-token = "none";
        reserved-word = "fg=${config.theme.colors.c06.ansi}";
        alias = "none";
        suffix-alias = "none";
        global-alias = "none";
        builtin = "none";
        function = "none";
        command = "none";
        precommand = "none";
        commandseparator = "fg=${config.theme.colors.c07.ansi}";
        hashed-command = "none";
        autodirectory = "none";
        path = "none";
        path_pathseparator = "none";
        path_prefix = "none";
        path_prefix_pathseparator = "none";
        globbing = "none";
        history-expansion = "none";
        command-substitution = "none";
        command-substitution-unquoted = "none";
        command-substitution-quoted = "none";
        command-substitution-delimiter = "fg=${config.theme.colors.c06.ansi}";
        command-substitution-delimiter-unquoted = "fg=${config.theme.colors.c06.ansi}";
        command-substitution-delimiter-quoted = "fg=${config.theme.colors.c06.ansi}";
        process-substitution = "none";
        process-substitution-delimiter = "fg=${config.theme.colors.c06.ansi}";
        arithmetic-expansion = "none";
        single-hyphen-option = "none";
        double-hyphen-option = "none";
        back-quoted-argument = "fg=${config.theme.colors.c07.ansi}";
        back-quoted-argument-unclosed = "fg=${config.theme.colors.c07.ansi}";
        back-quoted-argument-delimiter = "fg=${config.theme.colors.c07.ansi}";
        single-quoted-argument = "fg=${config.theme.colors.c07.ansi}";
        single-quoted-argument-unclosed = "fg=${config.theme.colors.c07.ansi}";
        double-quoted-argument = "fg=${config.theme.colors.c07.ansi}";
        double-quoted-argument-unclosed = "fg=${config.theme.colors.c07.ansi}";
        dollar-quoted-argument = "fg=${config.theme.colors.c07.ansi}";
        dollar-quoted-argument-unclosed = "fg=${config.theme.colors.c07.ansi}";
        rc-quote = "fg=${config.theme.colors.c07.ansi}";
        dollar-double-quoted-argument = "none";
        back-double-quoted-argument = "fg=${config.theme.colors.c07.ansi}";
        back-dollar-quoted-argument = "fg=${config.theme.colors.c07.ansi}";
        assign = "none";
        redirection = "fg=${config.theme.colors.c07.ansi}";
        comment = "none";
        named-fd = "none";
        numeric-fd = "none";
        arg0 = "none";
        default = "none";
      };
    };

    autosuggestion = {
      enable = true;
      highlight = "fg=#${config.theme.colors.c04.hex}";
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
      PROMPT = "%F{#${config.theme.colors.c06.hex}}$%f ";
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
          prompt restore

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle ':completion:*' menu no
          zstyle ':completion::complete:*' gain-privileges 1
          zstyle ':completion:*' use-cache on

          zstyle ':fzf-tab:*' use-fzf-default-opts yes
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
