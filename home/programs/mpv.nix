{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.mpv;
in
{
  config.programs.mpv = lib.mkIf cfg.enable {
    bindings = {
      l = "seek +5";
      h = "seek -5";
      L = "playlist-next";
      H = "playlist-prev";
      k = "add volume +5";
      j = "add volume -5";
      K = "cycle sub";
      J = "cycle sub down";
      Q = "quit-watch-later";
    };

    config = {
      cache = true;
      hr-seek = true;

      keep-open = true;

      msg-color = false;

      osd-back-color = config.theme.colors.hex00;
      osd-bar-h = 2;
      osd-bar-outline-size = 0.1;
      osd-border-size = 0.1;
      osd-color = config.theme.colors.hex10;
      osd-font = config.theme.font.name;
      osd-font-size = 24;
      osd-outline-color = config.theme.colors.hex00;
      osd-outline-size = 0.1;
      osd-scale-by-window = false;

      term-osd-bar = true;
      term-osd-bar-chars = "[━━ ]";

      sub-back-color = config.theme.colors.hex00;
      sub-color = config.theme.colors.hex10;
      sub-outline-color = config.theme.colors.hex00;
      sub-outline-size = 0.1;

      volume-max = 200;

      ytdl-format = "bestvideo[height<=?360][fps<=?30]+bestaudio/best";
    };

    scriptOpts = {
      osc = {
        background_color = config.theme.colors.hex00;
        buttons_color = config.theme.colors.hex10;
        held_element_color = config.theme.colors.hex10;
        small_buttonsL_color = config.theme.colors.hex10;
        small_buttonsR_color = config.theme.colors.hex10;
        time_pos_color = config.theme.colors.hex10;
        time_pos_outline_color = config.theme.colors.hex00;
        timecode_color = config.theme.colors.hex10;
        title_color = config.theme.colors.hex10;
        top_buttons_color = config.theme.colors.hex10;
      };

      webtorrent = {
        path = "${config.xdg.cacheHome}/webtorrent/";
      };
    };

    scripts = [
      pkgs.mpvScripts.mpris
      pkgs.mpvScripts.webtorrent-mpv-hook
    ];
  };
}
