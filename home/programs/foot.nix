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
      settings =
        let
          stripHash = lib.strings.removePrefix "#";
        in
        {
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
            background = stripHash config.theme.colors.hex00;
            foreground = stripHash config.theme.colors.hex10;
            cursor = "${stripHash config.theme.colors.hex00} ${stripHash config.theme.colors.hex10}";

            regular0 = stripHash config.theme.colors.hex00;
            regular1 = stripHash config.theme.colors.hex04;
            regular2 = stripHash config.theme.colors.hex06;
            regular3 = stripHash config.theme.colors.hex08;
            regular4 = stripHash config.theme.colors.hex04;
            regular5 = stripHash config.theme.colors.hex06;
            regular6 = stripHash config.theme.colors.hex08;
            regular7 = stripHash config.theme.colors.hex10;

            bright0 = stripHash config.theme.colors.hex00;
            bright1 = stripHash config.theme.colors.hex04;
            bright2 = stripHash config.theme.colors.hex06;
            bright3 = stripHash config.theme.colors.hex08;
            bright4 = stripHash config.theme.colors.hex04;
            bright5 = stripHash config.theme.colors.hex06;
            bright6 = stripHash config.theme.colors.hex08;
            bright7 = stripHash config.theme.colors.hex10;

            selection-foreground = stripHash config.theme.colors.hex10;
            selection-background = stripHash config.theme.colors.hex02;

            jump-labels = "${stripHash config.theme.colors.hex00} ${stripHash config.theme.colors.hex10}";

            search-box-no-match = "${stripHash config.theme.colors.hex00} ${stripHash config.theme.colors.hex00}";
            search-box-match = "${stripHash config.theme.colors.hex10} ${stripHash config.theme.colors.hex00}";
          };

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
