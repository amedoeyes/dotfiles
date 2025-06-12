{ lib, config, ... }:
let
  cfg = config.services.cliphist;
in
{
  config.services.cliphist = lib.mkIf cfg.enable {
    extraOptions = [
      "-max-items"
      "1024"
    ];
  };
}
