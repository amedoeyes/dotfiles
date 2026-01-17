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
      color = with config.theme.colors; {
        background = "'#${c00.hex}'";
        foreground = "'#${c10.hex}'";
      };
    };
  };
}
