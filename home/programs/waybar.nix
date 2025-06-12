{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        margin-top = 10;
        margin-bottom = 0;
        margin-left = 10;
        margin-right = 10;
        spacing = 15;

        modules-left = [
          "clock"
          "clock#calendar"
          "sway/mode"
        ];

        modules-center = [
          "sway/workspaces"
        ];

        modules-right = [
          "network"
          "wireplumber"
          "battery"
        ];

        "sway/mode" = {
          format = "  {}";
          tooltip = false;
        };

        "sway/workspaces" = {
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            persistent = "  ";
            default = "  ";
            focused = "  ";
            urgent = "  ";
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
          format = "{icon} {essid}";
          format-ethernet = "󰈀 Ethernet";
          format-icons = [
            "󰤯 "
            "󰤟 "
            "󰤢 "
            "󰤨 "
          ];
          tooltip = false;
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " ";
          format-icons = [
            " "
            " "
            " "
          ];
          tooltip = false;
        };

        clock = {
          format = "  {:%H:%M}";
          tooltip = false;
        };

        "clock#calendar" = {
          format = "  {:%a %d-%m}";
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
        };
      };
    };

    style = ''
      * {
        all: unset;
        font-family: monospace;
        font-size: 9pt;
        font-weight: bold;
      }

      .modules-left {
        margin-left: 15px;
      }

      .modules-right {
        margin-right: 15px;
      }

      window#waybar {
        background: #000000;
        color: #a0a0a0;
        border: 1px solid #404040;
      }

      #workspaces button {
        color: #a0a0a0;
      }
    '';
  };
}
