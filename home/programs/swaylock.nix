{ lib, config, ... }:
let
  cfg = config.programs.swaylock;
in
{
  config.programs.swaylock = lib.mkIf cfg.enable {
    settings = {
      daemonize = true;

      ignore-empty-password = true;
      hide-keyboard-layout = true;

      color = "#${config.theme.colors.c00.hex}";

      font = config.theme.font.name;

      indicator-radius = "150";
      indicator-thickness = "2";

      bs-hl-color = "#${config.theme.colors.c10.hex}";
      key-hl-color = "#${config.theme.colors.c10.hex}";
      caps-lock-bs-hl-color = "#${config.theme.colors.c10.hex}";
      caps-lock-key-hl-color = "#${config.theme.colors.c10.hex}";

      inside-color = "#${config.theme.colors.c00.hex}";
      inside-clear-color = "#${config.theme.colors.c00.hex}";
      inside-caps-lock-color = "#${config.theme.colors.c00.hex}";
      inside-ver-color = "#${config.theme.colors.c00.hex}";
      inside-wrong-color = "#${config.theme.colors.c00.hex}";

      ring-color = "#${config.theme.colors.c04.hex}";
      ring-clear-color = "#${config.theme.colors.c04.hex}";
      ring-caps-lock-color = "#${config.theme.colors.c04.hex}";
      ring-ver-color = "#${config.theme.colors.c04.hex}";
      ring-wrong-color = "#${config.theme.colors.c04.hex}";

      text-color = "#${config.theme.colors.c10.hex}";
      text-clear-color = "#${config.theme.colors.c10.hex}";
      text-caps-lock-color = "#${config.theme.colors.c10.hex}";
      text-ver-color = "#${config.theme.colors.c10.hex}";
      text-wrong-color = "#${config.theme.colors.c10.hex}";

      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      separator-color = "00000000";
    };
  };
}
