{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.qutebrowser;
in
{
  options.programs.qutebrowser = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home = lib.mkIf cfg.default {
      sessionVariables = {
        BROWSER = "qutebrowser";
      };
    };

    programs.qutebrowser = {
      greasemonkey = [
        (pkgs.fetchurl {
          url = "https://update.greasyfork.org/scripts/9165/Auto%20Close%20YouTube%20Ads.user.js";
          sha256 = "sha256-/SypoUVSVxvUq01s5i5Ep6WhIjCm5Of7JG9m3QSmWXc=";
        })
      ];

      settings = {
        downloads.location.directory = config.xdg.userDirs.download;

        spellcheck.languages = [ "en-US" ];

        tabs.show = "multiple";

        content.blocking.method = "both";
        content.blocking.adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
          "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
          "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
        ];

        auto_save.session = true;

        hints.border = "1px solid #${config.theme.colors.c04.hex}";
        prompt.radius = 0;

        colors = {
          completion.fg = "#${config.theme.colors.c10.hex}";
          completion.even.bg = "#${config.theme.colors.c00.hex}";
          completion.odd.bg = "#${config.theme.colors.c00.hex}";
          completion.match.fg = "#${config.theme.colors.c10.hex}";
          completion.scrollbar.bg = "#${config.theme.colors.c01.hex}";
          completion.scrollbar.fg = "#${config.theme.colors.c03.hex}";

          completion.category.bg = "#${config.theme.colors.c00.hex}";
          completion.category.border.bottom = "#${config.theme.colors.c04.hex}";
          completion.category.border.top = "#${config.theme.colors.c04.hex}";
          completion.category.fg = "#${config.theme.colors.c10.hex}";

          completion.item.selected.bg = "#${config.theme.colors.c01.hex}";
          completion.item.selected.border.bottom = "#${config.theme.colors.c00.hex}";
          completion.item.selected.border.top = "#${config.theme.colors.c00.hex}";
          completion.item.selected.fg = "#${config.theme.colors.c10.hex}";
          completion.item.selected.match.fg = "#${config.theme.colors.c10.hex}";

          downloads.bar.bg = "#${config.theme.colors.c00.hex}";
          downloads.error.bg = "#${config.theme.colors.c00.hex}";
          downloads.start.bg = "#${config.theme.colors.c00.hex}";
          downloads.stop.bg = "#${config.theme.colors.c00.hex}";

          downloads.error.fg = "#${config.theme.colors.c10.hex}";
          downloads.start.fg = "#${config.theme.colors.c10.hex}";
          downloads.stop.fg = "#${config.theme.colors.c10.hex}";
          downloads.system.fg = "none";
          downloads.system.bg = "none";

          hints.bg = "#${config.theme.colors.c00.hex}";
          hints.fg = "#${config.theme.colors.c10.hex}";
          hints.match.fg = "#${config.theme.colors.c04.hex}";

          keyhint.bg = "#${config.theme.colors.c00.hex}";
          keyhint.fg = "#${config.theme.colors.c10.hex}";
          keyhint.suffix.fg = "#${config.theme.colors.c10.hex}";

          messages.error.fg = "#${config.theme.colors.c10.hex}";
          messages.error.bg = "#${config.theme.colors.c00.hex}";
          messages.error.border = "#${config.theme.colors.c00.hex}";

          messages.info.fg = "#${config.theme.colors.c10.hex}";
          messages.info.bg = "#${config.theme.colors.c00.hex}";
          messages.info.border = "#${config.theme.colors.c00.hex}";

          messages.warning.fg = "#${config.theme.colors.c10.hex}";
          messages.warning.bg = "#${config.theme.colors.c00.hex}";
          messages.warning.border = "#${config.theme.colors.c00.hex}";

          prompts.fg = "#${config.theme.colors.c10.hex}";
          prompts.bg = "#${config.theme.colors.c00.hex}";
          prompts.border = "1px solid #${config.theme.colors.c04.hex}";
          prompts.selected.fg = "#${config.theme.colors.c10.hex}";
          prompts.selected.bg = "#${config.theme.colors.c01.hex}";

          statusbar.normal.fg = "#${config.theme.colors.c10.hex}";
          statusbar.normal.bg = "#${config.theme.colors.c00.hex}";

          statusbar.insert.fg = "#${config.theme.colors.c10.hex}";
          statusbar.insert.bg = "#${config.theme.colors.c00.hex}";

          statusbar.command.fg = "#${config.theme.colors.c10.hex}";
          statusbar.command.bg = "#${config.theme.colors.c00.hex}";

          statusbar.passthrough.fg = "#${config.theme.colors.c10.hex}";
          statusbar.passthrough.bg = "#${config.theme.colors.c00.hex}";

          statusbar.progress.bg = "#${config.theme.colors.c10.hex}";

          statusbar.private.fg = "#${config.theme.colors.c10.hex}";
          statusbar.private.bg = "#${config.theme.colors.c00.hex}";

          statusbar.command.private.fg = "#${config.theme.colors.c10.hex}";
          statusbar.command.private.bg = "#${config.theme.colors.c00.hex}";

          statusbar.caret.fg = "#${config.theme.colors.c10.hex}";
          statusbar.caret.bg = "#${config.theme.colors.c00.hex}";
          statusbar.caret.selection.fg = "#${config.theme.colors.c10.hex}";
          statusbar.caret.selection.bg = "#${config.theme.colors.c00.hex}";

          statusbar.url.fg = "#${config.theme.colors.c10.hex}";
          statusbar.url.error.fg = "#${config.theme.colors.c10.hex}";
          statusbar.url.hover.fg = "#${config.theme.colors.c10.hex}";
          statusbar.url.success.http.fg = "#${config.theme.colors.c10.hex}";
          statusbar.url.success.https.fg = "#${config.theme.colors.c10.hex}";
          statusbar.url.warn.fg = "#${config.theme.colors.c10.hex}";

          tabs.bar.bg = "#${config.theme.colors.c00.hex}";

          tabs.even.fg = "#${config.theme.colors.c06.hex}";
          tabs.even.bg = "#${config.theme.colors.c00.hex}";

          tabs.odd.fg = "#${config.theme.colors.c06.hex}";
          tabs.odd.bg = "#${config.theme.colors.c00.hex}";

          tabs.selected.even.fg = "#${config.theme.colors.c10.hex}";
          tabs.selected.even.bg = "#${config.theme.colors.c00.hex}";

          tabs.selected.odd.fg = "#${config.theme.colors.c10.hex}";
          tabs.selected.odd.bg = "#${config.theme.colors.c00.hex}";

          tabs.pinned.even.fg = "#${config.theme.colors.c06.hex}";
          tabs.pinned.even.bg = "#${config.theme.colors.c00.hex}";

          tabs.pinned.odd.fg = "#${config.theme.colors.c06.hex}";
          tabs.pinned.odd.bg = "#${config.theme.colors.c00.hex}";

          tabs.pinned.selected.even.fg = "#${config.theme.colors.c10.hex}";
          tabs.pinned.selected.even.bg = "#${config.theme.colors.c00.hex}";

          tabs.pinned.selected.odd.fg = "#${config.theme.colors.c10.hex}";
          tabs.pinned.selected.odd.bg = "#${config.theme.colors.c00.hex}";

          tabs.indicator.start = "#${config.theme.colors.c06.hex}";
          tabs.indicator.stop = "#${config.theme.colors.c10.hex}";
          tabs.indicator.error = "#${config.theme.colors.c04.hex}";
          tabs.indicator.system = "none";

          contextmenu.menu.fg = "#${config.theme.colors.c10.hex}";
          contextmenu.menu.bg = "#${config.theme.colors.c00.hex}";

          contextmenu.disabled.fg = "#${config.theme.colors.c04.hex}";
          contextmenu.disabled.bg = "#${config.theme.colors.c00.hex}";

          contextmenu.selected.fg = "#${config.theme.colors.c10.hex}";
          contextmenu.selected.bg = "#${config.theme.colors.c00.hex}";

          webpage.preferred_color_scheme = config.theme.palette;
        };
      };

      keyBindings = {
        command = {
          "<Ctrl-e>" = "cmd-edit";
        };
      };
    };
  };
}
