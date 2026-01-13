{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.aerc;
in
{
  config.programs.aerc = lib.mkIf cfg.enable {
    stylesets = {
      eyes = {
        global = {
          "*.fg" = config.theme.colors.c10.ansi;
          "*.bg" = config.theme.colors.c00.ansi;
          "*.normal" = "true";
          "*.selected.bg" = config.theme.colors.c01.ansi;
          "statusline_*.bold" = "true";

          "border.fg" = config.theme.colors.c04.ansi;

          "title.bold" = "true";
          "header.bold" = "true";

          "msglist_marked.bg" = config.theme.colors.c02.ansi;
          "msglist_result.bg" = config.theme.colors.c03.ansi;

          "tab.fg" = config.theme.colors.c06.ansi;
          "tab.selected.fg" = config.theme.colors.c10.ansi;
          "tab.selected.bg" = config.theme.colors.c00.ansi;
          "tab.selected.bold" = "true";
        };
      };
    };

    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
      };

      viewer = {
        alternatives = "text/plain";
      };

      ui = {
        styleset-name = "eyes";
        mouse-enabled = true;
      };

      hooks = {
        mail-received = ''${lib.getExe pkgs.libnotify} "[$AERC_ACCOUNT/$AERC_FOLDER] New mail from $AERC_FROM_NAME" "$AERC_SUBJECT"'';
      };

      filters = {
        "text/plain" = "${lib.getExe' pkgs.coreutils "cat"}";
      };

      openers = {
        "*" = "${lib.getExe' pkgs.xdg-utils "xdg-open"} {}";
      };
    };
  };
}
