{ pkgs, lib, ... }:
{
  services.swayidle =
    let
      brightnessctlBin = lib.getExe pkgs.brightnessctl;
      swaylockBin = lib.getExe pkgs.swaylock;
      swaymsgBin = lib.getExe' pkgs.sway "swaymsg";
      systemctlBin = lib.getExe' pkgs.systemd "systemctl";
    in
    {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${swaylockBin} -fF";
        }
        {
          event = "lock";
          command = "lock";
        }
      ];
      timeouts = [
        {
          timeout = 300;
          command = "${brightnessctlBin} -s s 5%";
          resumeCommand = "${brightnessctlBin} -r";
        }
        {
          timeout = 600;
          command = "${swaymsgBin} \"output * dpms off\"";
          resumeCommand = "${swaymsgBin} \"output * dpms on\"";
        }
        {
          timeout = 900;
          command = "${systemctlBin} suspend";
        }
      ];
    };
}
