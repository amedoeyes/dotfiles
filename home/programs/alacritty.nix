{ lib, config, ... }:
let
  cfg = config.programs.alacritty;
in
{
  options.programs.alacritty = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = lib.mkIf cfg.default {
      TERMINAL = "alacritty";
    };

    programs.alacritty = {
      settings = {
        window = {
          padding = {
            x = 4;
            y = 4;
          };
          dynamic_padding = true;
        };

        font = {
          normal = {
            family = "monospace";
            style = "Regular";
          };
          size = 10;
        };

        cursor = {
          style = {
            blinking = "On";
          };
          vi_mode_style = {
            shape = "Block";
            blinking = "On";
          };
        };

        mouse = {
          hide_when_typing = true;
        };

        colors = {
          primary = {
            foreground = config.theme.colors.hex10;
            background = config.theme.colors.hex00;
            dim_foreground = config.theme.colors.hex10;
            bright_foreground = config.theme.colors.hex10;
          };

          cursor = {
            text = config.theme.colors.hex00;
            cursor = config.theme.colors.hex10;
          };

          vi_mode_cursor = {
            text = config.theme.colors.hex00;
            cursor = config.theme.colors.hex10;
          };

          search = {
            matches = {
              background = config.theme.colors.hex03;
              foreground = config.theme.colors.hex10;
            };
            focused_match = {
              background = config.theme.colors.hex03;
              foreground = config.theme.colors.hex10;
            };
          };

          hints = {
            start = {
              foreground = config.theme.colors.hex00;
              background = config.theme.colors.hex10;
            };
            end = {
              foreground = config.theme.colors.hex00;
              background = config.theme.colors.hex10;
            };
          };

          line_indicator = {
            foreground = config.theme.colors.hex10;
            background = config.theme.colors.hex01;
          };

          footer_bar = {
            foreground = config.theme.colors.hex10;
            background = config.theme.colors.hex00;
          };

          selection = {
            text = config.theme.colors.hex10;
            background = config.theme.colors.hex02;
          };

          normal = {
            black = config.theme.colors.hex00;
            red = config.theme.colors.hex04;
            green = config.theme.colors.hex06;
            yellow = config.theme.colors.hex08;
            blue = config.theme.colors.hex04;
            magenta = config.theme.colors.hex06;
            cyan = config.theme.colors.hex08;
            white = config.theme.colors.hex10;
          };

          bright = {
            black = config.theme.colors.hex00;
            red = config.theme.colors.hex04;
            green = config.theme.colors.hex06;
            yellow = config.theme.colors.hex08;
            blue = config.theme.colors.hex04;
            magenta = config.theme.colors.hex06;
            cyan = config.theme.colors.hex08;
            white = config.theme.colors.hex10;
          };

          dim = {
            black = config.theme.colors.hex00;
            red = config.theme.colors.hex04;
            green = config.theme.colors.hex06;
            yellow = config.theme.colors.hex08;
            blue = config.theme.colors.hex04;
            magenta = config.theme.colors.hex06;
            cyan = config.theme.colors.hex08;
            white = config.theme.colors.hex10;
          };

          indexed_colors = builtins.attrValues (
            builtins.mapAttrs (index: color: {
              index = lib.toInt index;
              color = color;
            }) config.theme.ansiColors
          );
        };

        keyboard.bindings = [
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
  };
}
