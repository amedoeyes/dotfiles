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

    style = ''
      * {
        all: unset;
        font-family: ${config.theme.font.name};
        font-size: ${toString config.theme.font.size}pt;
        font-weight: bold;
        color: ${config.theme.colors.hex10};
      }

      .modules-left {
        margin-left: 10px;
      }

      .modules-right {
        margin-right: 10px;
      }

      window#waybar {
        background: ${config.theme.colors.hex00};
        border: 1px solid ${config.theme.colors.hex04};
      }
    '';
  };
}
