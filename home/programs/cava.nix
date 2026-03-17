{ lib, config, ... }:
let
  cfg = config.programs.cava;
in
{
  config.programs.cava = lib.mkIf cfg.enable {
    settings = {
      general = {
        bar_width = 1;
        bars = 0;
      };
      smoothing = {
        noise_reduction = 0;
      };
      color = with config.theme.colors; {
        background = "'#${c00.hex}'";
        foreground = "'#${c10.hex}'";
      };
    };
  };
}
