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
            foreground = "#${config.theme.colors.c10.hex}";
            background = "#${config.theme.colors.c00.hex}";
            dim_foreground = "#${config.theme.colors.c10.hex}";
            bright_foreground = "#${config.theme.colors.c10.hex}";
          };

          cursor = {
            text = "#${config.theme.colors.c00.hex}";
            cursor = "#${config.theme.colors.c10.hex}";
          };

          vi_mode_cursor = {
            text = "#${config.theme.colors.c00.hex}";
            cursor = "#${config.theme.colors.c10.hex}";
          };

          search = {
            matches = {
              background = "#${config.theme.colors.c03.hex}";
              foreground = "#${config.theme.colors.c10.hex}";
            };
            focused_match = {
              background = "#${config.theme.colors.c03.hex}";
              foreground = "#${config.theme.colors.c10.hex}";
            };
          };

          hints = {
            start = {
              foreground = "#${config.theme.colors.c00.hex}";
              background = "#${config.theme.colors.c10.hex}";
            };
            end = {
              foreground = "#${config.theme.colors.c00.hex}";
              background = "#${config.theme.colors.c10.hex}";
            };
          };

          line_indicator = {
            foreground = "#${config.theme.colors.c10.hex}";
            background = "#${config.theme.colors.c01.hex}";
          };

          footer_bar = {
            foreground = "#${config.theme.colors.c10.hex}";
            background = "#${config.theme.colors.c00.hex}";
          };

          selection = {
            text = "#${config.theme.colors.c10.hex}";
            background = "#${config.theme.colors.c02.hex}";
          };

          normal = {
            black = "#${config.theme.colors.c00.hex}";
            red = "#${config.theme.colors.c04.hex}";
            green = "#${config.theme.colors.c06.hex}";
            yellow = "#${config.theme.colors.c08.hex}";
            blue = "#${config.theme.colors.c04.hex}";
            magenta = "#${config.theme.colors.c06.hex}";
            cyan = "#${config.theme.colors.c08.hex}";
            white = "#${config.theme.colors.c10.hex}";
          };

          bright = {
            black = "#${config.theme.colors.c00.hex}";
            red = "#${config.theme.colors.c04.hex}";
            green = "#${config.theme.colors.c06.hex}";
            yellow = "#${config.theme.colors.c08.hex}";
            blue = "#${config.theme.colors.c04.hex}";
            magenta = "#${config.theme.colors.c06.hex}";
            cyan = "#${config.theme.colors.c08.hex}";
            white = "#${config.theme.colors.c10.hex}";
          };

          dim = {
            black = "#${config.theme.colors.c00.hex}";
            red = "#${config.theme.colors.c04.hex}";
            green = "#${config.theme.colors.c06.hex}";
            yellow = "#${config.theme.colors.c08.hex}";
            blue = "#${config.theme.colors.c04.hex}";
            magenta = "#${config.theme.colors.c06.hex}";
            cyan = "#${config.theme.colors.c08.hex}";
            white = "#${config.theme.colors.c10.hex}";
          };

          indexed_colors = builtins.attrValues (
            builtins.mapAttrs (index: color: {
              index = lib.toInt index;
              color = "#" + color;
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
