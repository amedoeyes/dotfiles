{ lib, config, ... }:
let
  cfg = config.programs.swaylock;
in
{
  config.programs.swaylock = lib.mkIf cfg.enable {
    settings = with config.theme; {
      daemonize = true;
      ignore-empty-password = true;
      hide-keyboard-layout = true;
      color = "#${colors.c00.hex}";
      font = font.name;
      indicator-radius = "150";
      indicator-thickness = "2";
      bs-hl-color = "#${colors.c10.hex}";
      key-hl-color = "#${colors.c10.hex}";
      caps-lock-bs-hl-color = "#${colors.c10.hex}";
      caps-lock-key-hl-color = "#${colors.c10.hex}";
      inside-color = "#${colors.c00.hex}";
      inside-clear-color = "#${colors.c00.hex}";
      inside-caps-lock-color = "#${colors.c00.hex}";
      inside-ver-color = "#${colors.c00.hex}";
      inside-wrong-color = "#${colors.c00.hex}";
      ring-color = "#${colors.c04.hex}";
      ring-clear-color = "#${colors.c04.hex}";
      ring-caps-lock-color = "#${colors.c04.hex}";
      ring-ver-color = "#${colors.c04.hex}";
      ring-wrong-color = "#${colors.c04.hex}";
      text-color = "#${colors.c10.hex}";
      text-clear-color = "#${colors.c10.hex}";
      text-caps-lock-color = "#${colors.c10.hex}";
      text-ver-color = "#${colors.c10.hex}";
      text-wrong-color = "#${colors.c10.hex}";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      separator-color = "00000000";
    };
  };
}
