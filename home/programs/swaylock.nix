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

      color = config.theme.colors.hex00;

      font = config.theme.font.name;

      indicator-radius = "150";
      indicator-thickness = "2";

      bs-hl-color = config.theme.colors.hex10;
      key-hl-color = config.theme.colors.hex10;
      caps-lock-bs-hl-color = config.theme.colors.hex10;
      caps-lock-key-hl-color = config.theme.colors.hex10;

      inside-color = config.theme.colors.hex00;
      inside-clear-color = config.theme.colors.hex00;
      inside-caps-lock-color = config.theme.colors.hex00;
      inside-ver-color = config.theme.colors.hex00;
      inside-wrong-color = config.theme.colors.hex00;

      ring-color = config.theme.colors.hex04;
      ring-clear-color = config.theme.colors.hex04;
      ring-caps-lock-color = config.theme.colors.hex04;
      ring-ver-color = config.theme.colors.hex04;
      ring-wrong-color = config.theme.colors.hex04;

      text-color = config.theme.colors.hex10;
      text-clear-color = config.theme.colors.hex10;
      text-caps-lock-color = config.theme.colors.hex10;
      text-ver-color = config.theme.colors.hex10;
      text-wrong-color = config.theme.colors.hex10;

      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      separator-color = "00000000";
    };
  };
}
