{ lib, config, ... }:
let
  cfg = config.programs.gpg;
in
{
  config.programs.gpg = lib.mkIf cfg.enable {
    homedir = "${config.xdg.dataHome}/gnupg";
  };
}
