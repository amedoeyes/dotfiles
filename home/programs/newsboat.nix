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

      color background          color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color listnormal          color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color listfocus           color${config.theme.colors.c10.ansi} color${config.theme.colors.c01.ansi}
      color listnormal_unread   color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color listfocus_unread    color${config.theme.colors.c10.ansi} color${config.theme.colors.c01.ansi}
      color title               color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi} bold
      color info                color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi} bold
      color hint-key            color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color hint-keys-delimiter color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color hint-separator      color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color hint-description    color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color article             color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}
      color end-of-text-marker  color${config.theme.colors.c10.ansi} color${config.theme.colors.c10.ansi}

      highlight article "https?://[^ ]+" color${config.theme.colors.c08.ansi} default underline
    '';
  };
}
