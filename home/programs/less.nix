{ lib, config, ... }:
let
  cfg = config.programs.less;
in
{
  config.home.sessionVariables = lib.mkIf cfg.enable {
    LESS = "-~";
  };
}
