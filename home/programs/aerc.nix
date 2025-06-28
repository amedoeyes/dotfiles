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
        "*.fg" = config.theme.colors.ansi10;
        "*.bg" = config.theme.colors.ansi00;
        "*.normal" = true;
        "*.selected.bg" = config.theme.colors.ansi01;
        "statusline_*.bold" = true;

        "border.fg" = config.theme.colors.ansi04;

        "title.bold" = true;
        "header.bold" = true;

        "msglist_marked.bg" = config.theme.colors.ansi02;
        "msglist_result.bg" = config.theme.colors.ansi03;

        "tab.fg" = config.theme.colors.ansi06;
        "tab.selected.fg" = config.theme.colors.ansi10;
        "tab.selected.bg" = config.theme.colors.ansi00;
        "tab.selected.bold" = true;
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
