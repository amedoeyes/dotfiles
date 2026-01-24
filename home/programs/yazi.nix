{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.yazi;
in
{
  options.programs.yazi = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    picker = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      mimeApps.defaultApplications."inode/directory" = lib.mkIf cfg.default "yazi.desktop";

      portal = lib.mkIf cfg.picker {
        extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
        config.common."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };

      configFile = {
        "xdg-desktop-portal-termfilechooser/config" = lib.mkIf cfg.picker {
          text =
            let
              deps = pkgs.symlinkJoin {
                name = "picker-dependencies";
                paths = with pkgs; [
                  yazi
                  bashInteractive
                  coreutils
                  gnused
                ];
              };
            in
            ''
              [filechooser]
              env=PATH='${deps}/bin'
              env=TERMCMD='${lib.getExe pkgs.${config.home.sessionVariables.TERMINAL}} --app-id=filepicker'
              cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
            '';
        };
      };
    };

    programs = {
      qutebrowser.settings.fileselect = lib.mkIf cfg.picker {
        handler = "external";
        folder.command = [
          config.home.sessionVariables.TERMINAL
          "--app-id=filepicker"
          "yazi"
          "--chooser-file={}"
        ];
        single_file.command = [
          config.home.sessionVariables.TERMINAL
          "--app-id=filepicker"
          "yazi"
          "--chooser-file={}"
        ];
        multiple_files.command = [
          config.home.sessionVariables.TERMINAL
          "--app-id=filepicker"
          "yazi"
          "--chooser-file={}"
        ];
      };

      yazi = {
        settings = {
          mgr = {
            show_hidden = true;
            ratio = [
              0
              1
              1
            ];
          };
          input = {
            cursor_blink = true;
          };
          plugin = {
            prepend_fetchers = [
              {
                id = "git";
                url = "*";
                run = "git";
              }
              {
                id = "git";
                url = "*/";
                run = "git";
              }
            ];
          };
        };
        initLua =
          with config.theme.colors;
          # lua
          ''
            th.git = th.git or {}
            th.git.modified = ui.Style():fg("#${c10.hex}")
            th.git.added = ui.Style():fg("#${c10.hex}")
            th.git.untracked = ui.Style():fg("#${c10.hex}")
            th.git.ignored = ui.Style():fg("#${c10.hex}")
            th.git.deleted = ui.Style():fg("#${c10.hex}")
            th.git.updated = ui.Style():fg("#${c10.hex}")

            require("no-status"):setup()
            require("git"):setup()
          '';
        plugins = with pkgs.yaziPlugins; {
          no-status = no-status;
          git = git;
        };
        theme = with config.theme.colors; {
          app = {
            overall = {
              fg = "#${c10.hex}";
              bg = "#${c00.hex}";
            };
          };
          mgr = {
            cwd = { };
            find_keyword = {
              bg = "#${c02.hex}";
            };
            find_position = { };
            marker_copied = {
              fg = "#${c06.hex}";
              bg = "#${c06.hex}";
            };
            marker_cut = {
              fg = "#${c04.hex}";
              bg = "#${c04.hex}";
            };
            marker_marked = {
              fg = "#${c02.hex}";
              bg = "#${c02.hex}";
            };
            marker_selected = {
              fg = "#${c02.hex}";
              bg = "#${c02.hex}";
            };
            count_copied = { };
            count_cut = { };
            count_selected = { };
            border_symbol = "│";
            border_style = {
              fg = "#${c04.hex}";
            };
            syntect_theme = "TODO";
          };
          tabs = {
            active = {
              bg = "#${c00.hex}";
              bold = true;
            };
            inactive = {
              bg = "#${c00.hex}";
              fg = "#${c06.hex}";
            };
            sep_inner = {
              open = "";
              close = "";
            };
            sep_outer = {
              open = "";
              close = "";
            };
          };
          mode = {
            normal_main = {
              bg = "#${c00.hex}";
            };
            normal_alt = { };
            select_main = {
              bg = "#${c00.hex}";
            };
            select_alt = { };
            unset_main = {
              bg = "#${c00.hex}";
            };
            unset_alt = { };
          };
          status = {
            overall = {
              bold = true;
            };
            sep_left = {
              open = "";
              close = "";
            };
            sep_right = {
              open = "";
              close = "";
            };
            perm_type = { };
            perm_read = { };
            perm_write = { };
            perm_exec = { };
            perm_sep = { };
            progress_label = {
              bold = true;
            };
            progress_normal = { };
            progress_error = { };
          };
          indicator = {
            parent = {
              bg = "#${c01.hex}";
            };
            current = {
              bg = "#${c01.hex}";
            };
            preview = {
              bg = "#${c01.hex}";
            };
            padding = {
              open = "█";
              close = "█";
            };
          };
          which = {
            cols = 1;
            mask = { };
            cand = { };
            rest = { };
            desc = { };
            separator = "  ";
            separator_style = { };
          };
          confirm = {
            border = {
              fg = "#${c04.hex}";
            };
            title = {
              fg = "#${c10.hex}";
              bold = true;
            };
            body = { };
            list = { };
            btn_yes = { };
            btn_no = { };
          };
          spot = {
            border = {
              fg = "#${c04.hex}";
            };
            title = {
              fg = "#${c10.hex}";
              bold = true;
            };
            tbl_col = { };
            tbl_cell = { };
          };
          notify = {
            title_info = { };
            title_warn = { };
            title_error = { };
          };
          pick = {
            border = {
              fg = "#${c04.hex}";
            };
            active = {
              bg = "#${c01.hex}";
            };
            inactive = { };
          };
          input = {
            border = {
              fg = "#${c04.hex}";
            };
            title = {
              fg = "#${c10.hex}";
              bold = true;
            };
            value = { };
            selected = {
              bg = "#${c01.hex}";
            };
          };
          cmp = {
            border = {
              fg = "#${c04.hex}";
            };
            active = {
              bg = "#${c01.hex}";
            };
            inactive = { };
          };
          tasks = {
            border = {
              fg = "#${c04.hex}";
            };
            title = {
              fg = "#${c10.hex}";
              bold = true;
            };
            hovered = {
              bg = "#${c01.hex}";
            };
          };
          help = {
            on = { };
            run = { };
            desc = { };
            hovered = {
              bg = "#${c01.hex}";
            };
            footer = {
              bold = true;
            };
          };
          filetype = {
            rules = [
              {
                url = "*";
                fg = "#${c10.hex}";
              }
            ];
          };
          icon =
            builtins.fetchurl {
              url = "https://raw.githubusercontent.com/sxyazi/yazi/refs/heads/main/yazi-config/preset/theme-dark.toml";
              sha256 = "114a8bizihrx2wyzfph4c4mpkghj6skgdc1db1d5268pnrhblvnn";
            }
            |> builtins.readFile
            |> fromTOML
            |> (x: x.icon)
            |> builtins.mapAttrs (
              key: value:
              map (
                icon:
                (
                  if key == "conds" then
                    { inherit (icon) "if" text; }
                  else
                    {
                      inherit (icon) name;
                      text = if key == "dirs" then "" else icon.text;
                    }
                )
                // {
                  fg = "#${c10.hex}";
                }
              ) value
            );
        };
      };
    };
  };
}
