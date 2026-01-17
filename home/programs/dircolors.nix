{ lib, config, ... }:
let
  cfg = config.programs.dircolors;
in
{
  config.programs.dircolors = lib.mkIf cfg.enable {
    settings =
      with config.theme.colors;
      lib.mkForce {
        DIR = "38;2;${with c09; "${r};${g};${b}"}";
        "*" = "38;2;${with c10; "${r};${g};${b}"}";
      };
  };
}
