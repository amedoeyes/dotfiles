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
    syntaxHighlighting = with config.theme.colors; {
      enable = true;
      styles = {
        unknown-token = "fg=${c10.ansi}";
        reserved-word = "fg=${c06.ansi}";
        alias = "fg=${c09.ansi}";
        suffix-alias = "fg=${c09.ansi}";
        global-alias = "fg=${c09.ansi}";
        builtin = "fg=${c09.ansi}";
        function = "fg=${c09.ansi}";
        command = "fg=${c09.ansi}";
        precommand = "fg=${c09.ansi}";
        commandseparator = "fg=${c07.ansi}";
        hashed-command = "fg=${c09.ansi}";
        autodirectory = "fg=${c10.ansi}";
        path = "fg=${c08.ansi}";
        path_pathseparator = "fg=${c08.ansi}";
        path_prefix = "fg=${c10.ansi}";
        path_prefix_pathseparator = "fg=${c08.ansi}";
        globbing = "fg=${c07.ansi}";
        history-expansion = "fg=${c10.ansi}";
        command-substitution = "fg=${c10.ansi}";
        command-substitution-unquoted = "fg=${c10.ansi}";
        command-substitution-quoted = "fg=${c10.ansi}";
        command-substitution-delimiter = "fg=${c06.ansi}";
        command-substitution-delimiter-unquoted = "fg=${c06.ansi}";
        command-substitution-delimiter-quoted = "fg=${c06.ansi}";
        process-substitution = "fg=${c10.ansi}";
        process-substitution-delimiter = "fg=${c06.ansi}";
        arithmetic-expansion = "fg=${c10.ansi}";
        single-hyphen-option = "fg=${c10.ansi}";
        double-hyphen-option = "fg=${c10.ansi}";
        back-quoted-argument = "fg=${c08.ansi}";
        back-quoted-argument-unclosed = "fg=${c08.ansi}";
        back-quoted-argument-delimiter = "fg=${c08.ansi}";
        single-quoted-argument = "fg=${c08.ansi}";
        single-quoted-argument-unclosed = "fg=${c08.ansi}";
        double-quoted-argument = "fg=${c08.ansi}";
        double-quoted-argument-unclosed = "fg=${c08.ansi}";
        dollar-quoted-argument = "fg=${c08.ansi}";
        dollar-quoted-argument-unclosed = "fg=${c08.ansi}";
        rc-quote = "fg=${c08.ansi}";
        dollar-double-quoted-argument = "fg=${c10.ansi}";
        back-double-quoted-argument = "fg=${c08.ansi}";
        back-dollar-quoted-argument = "fg=${c08.ansi}";
        assign = "fg=${c10.ansi}";
        redirection = "fg=${c07.ansi}";
        comment = "fg=${c10.ansi}";
        named-fd = "fg=${c10.ansi}";
        numeric-fd = "fg=${c10.ansi}";
        arg0 = "fg=${c09.ansi}";
        default = "fg=${c10.ansi}";
      };
    };
    autosuggestion = with config.theme.colors; {
      enable = true;
      highlight = "fg=#${c04.hex}";
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
    sessionVariables = with config.theme.colors; {
      PROMPT = "%F{#${c06.hex}}$%f ";
    };
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
    initContent = ''
      prompt restore

      bindkey -e

      printf "\e[5 q"

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':completion::complete:*' gain-privileges 1
      zstyle ':completion:*' use-cache on

      zstyle ':fzf-tab:*' use-fzf-default-opts yes

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
  };
}
