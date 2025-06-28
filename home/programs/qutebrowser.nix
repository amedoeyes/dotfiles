{ lib, config, ... }:
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

        editor.command = [
          "$TERMINAL"
          "$EDITOR"
          "{}"
        ];

        hints.border = "1px solid ${config.theme.colors.hex04}";
        prompt.radius = 0;

        colors = {
          completion.fg = config.theme.colors.hex10;
          completion.even.bg = config.theme.colors.hex00;
          completion.odd.bg = config.theme.colors.hex00;
          completion.match.fg = config.theme.colors.hex10;
          completion.scrollbar.bg = config.theme.colors.hex01;
          completion.scrollbar.fg = config.theme.colors.hex03;

          completion.category.bg = config.theme.colors.hex00;
          completion.category.border.bottom = config.theme.colors.hex04;
          completion.category.border.top = config.theme.colors.hex04;
          completion.category.fg = config.theme.colors.hex10;

          completion.item.selected.bg = config.theme.colors.hex01;
          completion.item.selected.border.bottom = config.theme.colors.hex00;
          completion.item.selected.border.top = config.theme.colors.hex00;
          completion.item.selected.fg = config.theme.colors.hex10;
          completion.item.selected.match.fg = config.theme.colors.hex10;

          downloads.bar.bg = config.theme.colors.hex00;
          downloads.error.bg = config.theme.colors.hex00;
          downloads.start.bg = config.theme.colors.hex00;
          downloads.stop.bg = config.theme.colors.hex00;

          downloads.error.fg = config.theme.colors.hex10;
          downloads.start.fg = config.theme.colors.hex10;
          downloads.stop.fg = config.theme.colors.hex10;
          downloads.system.fg = "none";
          downloads.system.bg = "none";

          hints.bg = config.theme.colors.hex00;
          hints.fg = config.theme.colors.hex10;
          hints.match.fg = config.theme.colors.hex04;

          keyhint.bg = config.theme.colors.hex00;
          keyhint.fg = config.theme.colors.hex10;
          keyhint.suffix.fg = config.theme.colors.hex10;

          messages.error.fg = config.theme.colors.hex10;
          messages.error.bg = config.theme.colors.hex00;
          messages.error.border = config.theme.colors.hex00;

          messages.info.fg = config.theme.colors.hex10;
          messages.info.bg = config.theme.colors.hex00;
          messages.info.border = config.theme.colors.hex00;

          messages.warning.fg = config.theme.colors.hex10;
          messages.warning.bg = config.theme.colors.hex00;
          messages.warning.border = config.theme.colors.hex00;

          prompts.fg = config.theme.colors.hex10;
          prompts.bg = config.theme.colors.hex00;
          prompts.border = "1px solid ${config.theme.colors.hex04}";
          prompts.selected.fg = config.theme.colors.hex10;
          prompts.selected.bg = config.theme.colors.hex01;

          statusbar.normal.fg = config.theme.colors.hex10;
          statusbar.normal.bg = config.theme.colors.hex00;

          statusbar.insert.fg = config.theme.colors.hex10;
          statusbar.insert.bg = config.theme.colors.hex00;

          statusbar.command.fg = config.theme.colors.hex10;
          statusbar.command.bg = config.theme.colors.hex00;

          statusbar.passthrough.fg = config.theme.colors.hex10;
          statusbar.passthrough.bg = config.theme.colors.hex00;

          statusbar.progress.bg = config.theme.colors.hex00;

          statusbar.private.fg = config.theme.colors.hex10;
          statusbar.private.bg = config.theme.colors.hex00;

          statusbar.command.private.fg = config.theme.colors.hex10;
          statusbar.command.private.bg = config.theme.colors.hex00;

          statusbar.caret.fg = config.theme.colors.hex10;
          statusbar.caret.bg = config.theme.colors.hex00;
          statusbar.caret.selection.fg = config.theme.colors.hex10;
          statusbar.caret.selection.bg = config.theme.colors.hex00;

          statusbar.url.fg = config.theme.colors.hex10;
          statusbar.url.error.fg = config.theme.colors.hex10;
          statusbar.url.hover.fg = config.theme.colors.hex10;
          statusbar.url.success.http.fg = config.theme.colors.hex10;
          statusbar.url.success.https.fg = config.theme.colors.hex10;
          statusbar.url.warn.fg = config.theme.colors.hex10;

          tabs.bar.bg = config.theme.colors.hex00;

          tabs.even.fg = config.theme.colors.hex06;
          tabs.even.bg = config.theme.colors.hex00;

          tabs.odd.fg = config.theme.colors.hex06;
          tabs.odd.bg = config.theme.colors.hex00;

          tabs.selected.even.fg = config.theme.colors.hex10;
          tabs.selected.even.bg = config.theme.colors.hex00;

          tabs.selected.odd.fg = config.theme.colors.hex10;
          tabs.selected.odd.bg = config.theme.colors.hex00;

          tabs.pinned.even.fg = config.theme.colors.hex06;
          tabs.pinned.even.bg = config.theme.colors.hex00;

          tabs.pinned.odd.fg = config.theme.colors.hex06;
          tabs.pinned.odd.bg = config.theme.colors.hex00;

          tabs.pinned.selected.even.fg = config.theme.colors.hex10;
          tabs.pinned.selected.even.bg = config.theme.colors.hex00;

          tabs.pinned.selected.odd.fg = config.theme.colors.hex10;
          tabs.pinned.selected.odd.bg = config.theme.colors.hex00;

          tabs.indicator.start = config.theme.colors.hex06;
          tabs.indicator.stop = config.theme.colors.hex10;
          tabs.indicator.error = config.theme.colors.hex04;
          tabs.indicator.system = "none";

          contextmenu.menu.fg = config.theme.colors.hex10;
          contextmenu.menu.bg = config.theme.colors.hex00;

          contextmenu.disabled.fg = config.theme.colors.hex04;
          contextmenu.disabled.bg = config.theme.colors.hex00;

          contextmenu.selected.fg = config.theme.colors.hex10;
          contextmenu.selected.bg = config.theme.colors.hex00;

          webpage.preferred_color_scheme = config.theme.palette;
        };
      };
    };
  };
}
