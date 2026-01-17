{ lib, config, ... }:
let
  cfg = config.programs.waybar;
in
{
  programs.waybar = lib.mkIf cfg.enable {
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-top = 10;
        margin-bottom = 0;
        margin-left = 10;
        margin-right = 10;
        spacing = 20;
        modules-left = [
          "sway/mode"
          "sway/workspaces"
        ];
        modules-right = [
          "network"
          "memory"
          "cpu"
          "battery"
          "clock"
        ];
        memory = {
          format = "  {percentage}%";
          tooltip = false;
        };
        cpu = {
          format = "  {usage}%";
          tooltip = false;
        };
        "sway/mode" = {
          tooltip = false;
        };
        "sway/workspaces" = {
          format = "{icon}";
          format-icons = {
            persistent = "  ";
            default = "  ";
            focused = "  ";
            urgent = "  ";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };
        };
        network = {
          format = "{icon} {essid} ({signalStrength}%)";
          format-ethernet = "󰈀  Ethernet";
          format-disconnected = "";
          format-icons = [
            "󰤯 "
            "󰤟 "
            "󰤢 "
            "󰤥 "
            "󰤨 "
          ];
          tooltip = false;
        };
        clock = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        battery = {
          format = "{icon} {capacity}%";
          format-charging = "{icon}󱐋 {capacity}%";
          format-plugged = "{icon} {capacity}%";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip = false;
        };
      };
    };
    style = with config.theme; ''
      * {
        all: unset;
        font-family: ${font.name};
        font-size: ${toString font.size}pt;
        font-weight: bold;
        color: #${colors.c10.hex};
      }
      .modules-left {
        margin-left: 10px;
      }
      .modules-right {
        margin-right: 10px;
      }
      window#waybar {
        background: #${colors.c00.hex};
        border: 1px solid #${colors.c04.hex};
      }
    '';
  };
}
