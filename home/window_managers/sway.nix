{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    batsignal
    brightnessctl
    cliphist
    foot
    grim
    libnotify
    mako
    slurp
    swayidle
    swaylock
    swaybg
    wl-clipboard
    yambar
  ];

  wayland.windowManager.sway = {
    enable = true;
    config =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;

        terminal = pkgs.foot;
        fzfmenu = pkgs.callPackage ../../pkgs/fzfmenu.nix {
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
        launcherBin = lib.getExe (pkgs.callPackage ./scripts/launcher.nix { inherit fzfmenu; });
        clipboardBin = lib.getExe (pkgs.callPackage ./scripts/clipboard.nix { inherit fzfmenu; });
        makoctlBin = lib.getExe' pkgs.mako "makoctl";
        control =
          let
            mprisctl = pkgs.callPackage ../../pkgs/mprisctl.nix { };
          in
          {
            audioBin = lib.getExe (pkgs.callPackage ./scripts/control/audio.nix { });
            brightnessBin = lib.getExe (pkgs.callPackage ./scripts/control/brightness.nix { });
            mprisBin = lib.getExe (pkgs.callPackage ./scripts/control/mpris.nix { inherit mprisctl; });
          };
      in
      {
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
            bg = "${../wallpapers/eyes.png} fill";
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
        bars = [ ];
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
        modifier = "Mod4";
        keybindings = {
          "${modifier}+return" = "exec ${terminalBin}";
          "${modifier}+space" = "exec ${launcherBin}";
          "${modifier}+c" = "exec ${clipboardBin}";
          "print" = "exec ~.local/bin/screenshot";
          "shift+print" = "exec ~.local/bin/screenshot -s";

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

          "${modifier}+r" = "mode resize";
          "${modifier}+m" = "mode mpris";
          "${modifier}+n" = "mode notification";
        };
        modes = {
          resize = {
            "${modifier}+h" = "resize shrink width 10px";
            "${modifier}+j" = "resize grow height 10px";
            "${modifier}+k" = "resize shrink height 10px";
            "${modifier}+l" = "resize grow width 10px";

            "${modifier}+escape" = "mode default";
          };
          mpris = {
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
          notification = {
            "${modifier}+m" = "exec ${makoctlBin} menu ${fzfmenuBin}";
            "${modifier}+d" = "exec ${makoctlBin} dismiss -a";
            "${modifier}+shift+d" = "exec ${makoctlBin} mode -t do-not-disturb";

            "${modifier}+escape" = "mode default";
          };
        };
        startup = [
          { command = "yambar"; }
          { command = "batsignal -b"; }
          { command = "mako"; }
          { command = "udiskie -A"; }
          { command = "wl-paste -w cliphist -max-items 1024 store"; }
        ];
        colors = {
          background = "#000000";
          focused = {
            background = "#000000";
            border = "#A0A0A0";
            childBorder = "#A0A0A0";
            indicator = "#A0A0A0";
            text = "#A0A0A0";
          };
          focusedInactive = {
            background = "#000000";
            border = "#404040";
            childBorder = "#404040";
            indicator = "#404040";
            text = "#606060";
          };
          unfocused = {
            background = "#000000";
            border = "#404040";
            childBorder = "#404040";
            indicator = "#404040";
            text = "#606060";
          };
          urgent = {
            background = "#000000";
            border = "#A0A0A0";
            childBorder = "#A0A0A0";
            indicator = "#A0A0A0";
            text = "#A0A0A0";
          };
        };
      };
  };
}
