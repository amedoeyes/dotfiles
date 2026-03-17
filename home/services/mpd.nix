{ lib, config, ... }:
let
  cfg = config.services.mpd;
in
{
  config.services = lib.mkIf cfg.enable {
    mpd = {
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire output"
        }
      '';
    };
  };
}
