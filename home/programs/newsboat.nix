{ lib, config, ... }:
let
  cfg = config.programs.newsboat;
in
{
  config.programs.newsboat = lib.mkIf cfg.enable {
    autoReload = true;
    extraConfig = ''
      show-keymap-hint no

      bind-key j down
      bind-key k up

      color background          color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color listnormal          color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color listfocus           color${config.theme.colors.ansi10} color${config.theme.colors.ansi01}
      color listnormal_unread   color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color listfocus_unread    color${config.theme.colors.ansi10} color${config.theme.colors.ansi01}
      color title               color${config.theme.colors.ansi10} color${config.theme.colors.ansi10} bold
      color info                color${config.theme.colors.ansi10} color${config.theme.colors.ansi10} bold
      color hint-key            color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color hint-keys-delimiter color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color hint-separator      color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color hint-description    color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color article             color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}
      color end-of-text-marker  color${config.theme.colors.ansi10} color${config.theme.colors.ansi10}

      highlight article "https?://[^ ]+" color${config.theme.colors.ansi08} default underline
    '';
  };
}
