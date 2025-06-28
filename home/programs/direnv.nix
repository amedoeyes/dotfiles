{ lib, config, ... }:
let
  cfg = config.programs.direnv;
in
{
  config.programs.direnv = lib.mkIf cfg.enable {
    silent = true;
  };
}
