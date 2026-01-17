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
    config = with config.theme; {
      cache = true;
      hr-seek = true;
      keep-open = true;
      msg-color = false;
      volume-max = 200;
      ytdl-format = "bestvideo[height<=?360][fps<=?30]+bestaudio/best";
      osd-back-color = "#${colors.c00.hex}";
      osd-bar-h = 2;
      osd-color = "#${colors.c10.hex}";
      osd-font = font.name;
      osd-outline-color = "#${colors.c00.hex}";
      osd-scale-by-window = false;
      sub-back-color = colors.c00.hex;
      sub-color = colors.c10.hex;
      sub-outline-color = colors.c00.hex;
    };
    scriptOpts = {
      osc = with config.theme.colors; {
        background_color = "#${c00.hex}";
        buttons_color = "#${c10.hex}";
        held_element_color = "#${c10.hex}";
        small_buttonsL_color = "#${c10.hex}";
        small_buttonsR_color = "#${c10.hex}";
        time_pos_color = "#${c10.hex}";
        time_pos_outline_color = "#${c00.hex}";
        timecode_color = "#${c10.hex}";
        title_color = "#${c10.hex}";
        top_buttons_color = "#${c10.hex}";
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
