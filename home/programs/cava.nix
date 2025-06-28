{ lib, config, ... }:
let
  cfg = config.programs.cava;
in
{
  config.programs.cava = lib.mkIf cfg.enable {
    settings = {
      general = {
        bar_spacing = 0;
        bar_width = 0;
        bars = 0;
        sleep_timer = 10;
      };

      output = {
        waveform = 1;
      };

      color = {
        background = "'${config.theme.colors.hex00}'";
        foreground = "'${config.theme.colors.hex10}'";
      };
    };
  };
}
