{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.swayidle;
in
{
  config.services.swayidle = lib.mkIf cfg.enable {
    events = [
      {
        event = "before-sleep";
        command = "${lib.getExe pkgs.swaylock} -fF";
      }

      {
        event = "lock";
        command = "lock";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "${lib.getExe pkgs.brightnessctl} -s s 5%";
        resumeCommand = "${lib.getExe pkgs.brightnessctl} -r";
      }

      {
        timeout = 600;
        command = "${lib.getExe' pkgs.sway "swaymsg"} \"output * dpms off\"";
        resumeCommand = "${lib.getExe' pkgs.sway "swaymsg"} \"output * dpms on\"";
      }

      {
        timeout = 900;
        command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
      }
    ];
  };
}
