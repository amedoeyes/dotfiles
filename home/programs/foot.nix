{ lib, config, ... }:
let
  cfg = config.programs.foot;
in
{
  options.programs.foot = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = lib.mkIf cfg.default {
      TERMINAL = "foot";
    };

    programs.foot = {
      settings = {
        main = {
          font = "monospace:size=10";
          pad = "4x4 center";
        };

        scrollback = {
          indicator-position = "none";
        };

        cursor = {
          blink = "yes";
          beam-thickness = 0.5;
        };

        mouse = {
          hide-when-typing = "true";
        };

        colors = {
          background = config.theme.colors.c00.hex;
          foreground = config.theme.colors.c10.hex;
          cursor = "${config.theme.colors.c00.hex} ${config.theme.colors.c10.hex}";

          regular0 = config.theme.colors.c00.hex;
          regular1 = config.theme.colors.c04.hex;
          regular2 = config.theme.colors.c06.hex;
          regular3 = config.theme.colors.c08.hex;
          regular4 = config.theme.colors.c04.hex;
          regular5 = config.theme.colors.c06.hex;
          regular6 = config.theme.colors.c08.hex;
          regular7 = config.theme.colors.c10.hex;

          bright0 = config.theme.colors.c00.hex;
          bright1 = config.theme.colors.c04.hex;
          bright2 = config.theme.colors.c06.hex;
          bright3 = config.theme.colors.c08.hex;
          bright4 = config.theme.colors.c04.hex;
          bright5 = config.theme.colors.c06.hex;
          bright6 = config.theme.colors.c08.hex;
          bright7 = config.theme.colors.c10.hex;

          selection-foreground = config.theme.colors.c10.hex;
          selection-background = config.theme.colors.c02.hex;

          jump-labels = "${config.theme.colors.c00.hex} ${config.theme.colors.c10.hex}";

          search-box-no-match = "${config.theme.colors.c00.hex} ${config.theme.colors.c00.hex}";
          search-box-match = "${config.theme.colors.c10.hex} ${config.theme.colors.c00.hex}";
        }
        // config.theme.ansiColors;

        key-bindings = {
          search-start = "Control+Shift+slash";
        };

        search-bindings = {
          find-prev = "Control+N";
          find-next = "Control+n";
        };
      };
    };
  };
}
