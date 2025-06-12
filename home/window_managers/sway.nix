{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.wayland.windowManager.sway;
in
{
  config = lib.mkIf cfg.enable {
    home.pointerCursor.sway.enable = true;

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];

      config = {
        common = {
          default = "gtk";
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        };
      };
    };

    wayland.windowManager.sway = {
      config =
        let
          modifier = cfg.config.modifier;
          scripts = import ./scripts pkgs;

          terminal = pkgs.foot;
          fzfmenu = pkgs.fzfmenu.override {
            fzfOptions = [
              "$FZF_DEFAULT_OPTS"
              "--height 100%"
              "--list-border none"
              "--margin 1"
            ];
            terminal = terminal;
            terminalBinary = "foot";
            terminalOptions = [
              "--app-id"
              "fzfmenu"
            ];
          };

          terminalBin = lib.getExe terminal;
          fzfmenuBin = lib.getExe fzfmenu;
          launcherBin = lib.getExe (scripts.launcher.override { inherit fzfmenu; });
          clipboardBin = lib.getExe (scripts.clipboard.override { inherit fzfmenu; });
          makoctlBin = lib.getExe' pkgs.mako "makoctl";

          dateBin = lib.getExe' pkgs.coreutils "date";
          mkdirBin = lib.getExe' pkgs.coreutils "mkdir";
          wlCopyBin = lib.getExe' pkgs.wl-clipboard "wl-copy";
          grimBin = lib.getExe pkgs.grim;
          selectGeometryBin = lib.getExe pkgs.select-geometry;

          control = {
            audioBin = lib.getExe scripts.control.audio;
            brightnessBin = lib.getExe scripts.control.brightness;
            mprisBin = lib.getExe scripts.control.mpris;
          };
        in
        {
          modifier = "Mod4";

          input = {
            "type:keyboard" = {
              xkb_layout = "us,ara";
              xkb_options = "grp:alt_shift_toggle,caps:escape_shifted_capslock";
            };
            "type:touchpad" = {
              events = "disabled";
            };
            "2:10:TPPS/2_IBM_TrackPoint" = {
              accel_profile = "flat";
              pointer_accel = "0.5";
            };
          };

          output = {
            "*" = {
              background = "${config.theme.colors.hex00} solid_color";
            };
            "eDP-1" = {
              resolution = "1600x900";
              position = "0 0";
            };
            "DP-2" = {
              resolution = "1366x768";
              position = "1600 0";
            };
          };

          seat = {
            "*" = {
              hide_cursor = "when-typing enable";
            };
          };

          workspaceOutputAssign = [
            {
              workspace = "1";
              output = [ "eDP-1" ];
            }
            {
              workspace = "6";
              output = [ "DP-2" ];
            }
          ];

          focus = {
            mouseWarping = "container";
          };

          bars = [
            # {
            #   position = "top";
            # }
          ];

          fonts = {
            names = [ "monospace" ];
            size = 10.0;
          };

          window = {
            titlebar = false;
            border = 1;
            commands = [
              {
                command = "floating enable";
                criteria = {
                  app_id = "fzfmenu";
                };
              }
              {
                command = "focus";
                criteria = {
                  app_id = "fzfmenu";
                };
              }
            ];
          };

          floating = {
            titlebar = false;
            border = 1;
          };

          gaps = {
            inner = 10;
          };

          keybindings = {
            "${modifier}+return" = "exec ${terminalBin}";
            "${modifier}+space" = "exec ${launcherBin}";
            "${modifier}+c" = "exec ${clipboardBin}";
            "print" =
              "exec 'file=\"$HOME/media/screenshots/$(${dateBin} +%Y/%m/%d/%H%M%S).png\" ; ${mkdirBin} -p \"$''{file%/*}\" && ${grimBin} \"$file\" &&  ${wlCopyBin} -t image/png <\"$file\"'";
            "shift+print" =
              "exec 'file=\"$HOME/media/screenshots/$(${dateBin} +%Y/%m/%d/%H%M%S).png\" ; ${mkdirBin} -p \"$''{file%/*}\" && ${grimBin} -g \"$(${selectGeometryBin})\" \"$file\" &&  ${wlCopyBin} -t image/png <\"$file\"'";

            "XF86AudioMute" = "exec ${control.audioBin} toggle-sink";
            "XF86AudioMicMute" = "exec ${control.audioBin} toggle-source";
            "XF86AudioLowerVolume" = "exec ${control.audioBin} decrement-sink";
            "XF86AudioRaiseVolume" = "exec ${control.audioBin} increment-sink";
            "XF86MonBrightnessDown" = "exec ${control.brightnessBin} decrement";
            "XF86MonBrightnessUp" = "exec ${control.brightnessBin} increment";

            "${modifier}+q" = "kill";

            "${modifier}+f" = "fullscreen";
            "${modifier}+shift+space" = "floating toggle";
            "${modifier}+minus" = "scratchpad show";

            "${modifier}+t" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+v" = "splith";
            "${modifier}+s" = "splitv";

            "${modifier}+ctrl+space" = "focus mode_toggle";
            "${modifier}+a" = "focus parent";
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";

            "${modifier}+shift+h" = "move left";
            "${modifier}+shift+j" = "move down";
            "${modifier}+shift+k" = "move up";
            "${modifier}+shift+l" = "move right";
            "${modifier}+shift+minus" = "move scratchpad";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+shift+1" = "move container to workspace number 1";
            "${modifier}+shift+2" = "move container to workspace number 2";
            "${modifier}+shift+3" = "move container to workspace number 3";
            "${modifier}+shift+4" = "move container to workspace number 4";
            "${modifier}+shift+5" = "move container to workspace number 5";
            "${modifier}+shift+6" = "move container to workspace number 6";
            "${modifier}+shift+7" = "move container to workspace number 7";
            "${modifier}+shift+8" = "move container to workspace number 8";
            "${modifier}+shift+9" = "move container to workspace number 9";
            "${modifier}+shift+0" = "move container to workspace number 10";

            "${modifier}+r" = "mode RESIZE";
            "${modifier}+m" = "mode MPRIS";
            "${modifier}+n" = "mode NOTIFICATION";
          };
          modes = {
            RESIZE = {
              "${modifier}+h" = "resize shrink width 10px";
              "${modifier}+j" = "resize grow height 10px";
              "${modifier}+k" = "resize shrink height 10px";
              "${modifier}+l" = "resize grow width 10px";

              "${modifier}+escape" = "mode default";
            };

            MPRIS = {
              "${modifier}+n" = "exec ${control.mprisBin} notify-progress";
              "${modifier}+p" = "exec ${control.mprisBin} toggle";
              "${modifier}+l" = "exec ${control.mprisBin} next-track";
              "${modifier}+h" = "exec ${control.mprisBin} previous-track";
              "${modifier}+shift+l" = "exec ${control.mprisBin} seek-forward";
              "${modifier}+shift+h" = "exec ${control.mprisBin} seek-backward";
              "${modifier}+k" = "exec ${control.mprisBin} increment-volume";
              "${modifier}+j" = "exec ${control.mprisBin} decrement-volume";
              "${modifier}+shift+k" = "exec ${control.mprisBin} next-player";
              "${modifier}+shift+j" = "exec ${control.mprisBin} previous-player";

              "${modifier}+escape" = "mode default";
            };

            NOTIFICATION = {
              "${modifier}+m" = "exec ${makoctlBin} menu ${fzfmenuBin}";
              "${modifier}+d" = "exec ${makoctlBin} dismiss -a";
              "${modifier}+shift+d" = "exec ${makoctlBin} mode -t do-not-disturb";

              "${modifier}+escape" = "mode default";
            };
          };
          colors = {
            background = config.theme.colors.hex00;

            focused = {
              background = config.theme.colors.hex00;
              border = config.theme.colors.hex10;
              childBorder = config.theme.colors.hex10;
              indicator = config.theme.colors.hex10;
              text = config.theme.colors.hex10;
            };

            focusedInactive = {
              background = config.theme.colors.hex00;
              border = config.theme.colors.hex04;
              childBorder = config.theme.colors.hex04;
              indicator = config.theme.colors.hex04;
              text = config.theme.colors.hex06;
            };

            unfocused = {
              background = config.theme.colors.hex00;
              border = config.theme.colors.hex04;
              childBorder = config.theme.colors.hex04;
              indicator = config.theme.colors.hex04;
              text = config.theme.colors.hex06;
            };

            urgent = {
              background = config.theme.colors.hex00;
              border = config.theme.colors.hex10;
              childBorder = config.theme.colors.hex10;
              indicator = config.theme.colors.hex10;
              text = config.theme.colors.hex10;
            };
          };
        };
    };
  };
}
