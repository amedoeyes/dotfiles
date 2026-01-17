{ lib, config, ... }:
let
  cfg = config.programs.newsboat;
in
{
  config.programs.newsboat = lib.mkIf cfg.enable {
    autoReload = true;
    extraConfig = with config.theme.colors; ''
      show-keymap-hint no

      bind-key j down
      bind-key k up

      color background          color${c10.ansi} color${c10.ansi}
      color listnormal          color${c10.ansi} color${c10.ansi}
      color listfocus           color${c10.ansi} color${c01.ansi}
      color listnormal_unread   color${c10.ansi} color${c10.ansi}
      color listfocus_unread    color${c10.ansi} color${c01.ansi}
      color title               color${c10.ansi} color${c10.ansi} bold
      color info                color${c10.ansi} color${c10.ansi} bold
      color hint-key            color${c10.ansi} color${c10.ansi}
      color hint-keys-delimiter color${c10.ansi} color${c10.ansi}
      color hint-separator      color${c10.ansi} color${c10.ansi}
      color hint-description    color${c10.ansi} color${c10.ansi}
      color article             color${c10.ansi} color${c10.ansi}
      color end-of-text-marker  color${c10.ansi} color${c10.ansi}

      highlight article "https?://[^ ]+" color${c08.ansi} default underline
    '';
  };
}
